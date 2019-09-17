//
//  CountriesListViewModel.swift
//  rxFun
//
//  Created Valentin Shamardin on 16/09/2019.
//  Copyright © 2019 Delitime. All rights reserved.
//

import RxSwift
import RxCocoa

protocol CountriesListViewModelProtocol {
    var isRequestActive: Observable<Bool> { get }
    var error: Observable<Error> { get }
    var dataSet: Observable<CountriesDataSet> { get }
    var didSelectCountry: AnyObserver<Country> { get }

    func moduleDidLoad()
    func getData()
}

class CountriesListViewModel: CountriesListViewModelProtocol {
    // MARK: - Public
    var isRequestActive: Observable<Bool> { return isRequestActiveRelay.asObservable() }
    var error: Observable<Error> { return errorRelay.asObservable() }
    var dataSet: Observable<CountriesDataSet> { return dataSetRelay.asObservable() }
    var didSelectCountry: AnyObserver<Country> { return selectedCountry.asObserver() }

    init(router: ToCountryInfoRouterProtocol, countriesService: CountriesServiceProtocol) {
        self.router = router
        self.countriesService = countriesService
    }

    func moduleDidLoad() {
        bind()
        getData()
    }

    func getData() {
        countriesService.getCountries()
            .do(onSubscribe: { [weak self] in
                self?.isRequestActiveRelay.accept(true)
            })
            .subscribe(onSuccess: { [weak self] countries in
                self?.dataSetRelay.accept(.init(countries: countries))
                self?.isRequestActiveRelay.accept(false)
                }, onError: { [weak self] error in
                    self?.isRequestActiveRelay.accept(false)
                    self?.errorRelay.accept(error)
            })
            .disposed(by: bag)
    }

    // MARK: - Private
    private var router: ToCountryInfoRouterProtocol
    private let countriesService: CountriesServiceProtocol
    private let bag = DisposeBag()
    private let isRequestActiveRelay = PublishRelay<Bool>()
    private let errorRelay = PublishRelay<Error>()
    private let dataSetRelay = BehaviorRelay<CountriesDataSet>(value: CountriesDataSet(countries: []))
    private let selectedCountry = PublishSubject<Country>()

    private func bind() {
        selectedCountry
            .subscribe(onNext: { [weak self] country in
                guard let self = self else { return }
                self.router.openDetailsForCountry(country, countriesDataSet: self.dataSet)
            })
            .disposed(by: bag)
    }
}
