//
//  CountryInfoViewModel.swift
//  rxFun
//
//  Created Valentin Shamardin on 17/09/2019.
//  Copyright © 2019 Delitime. All rights reserved.
//

import RxSwift
import RxCocoa

protocol CountryInfoViewModelProtocol {
    var didSelectCountry: AnyObserver<Country> { get }
    var countriesDataSet: Observable<CountriesDataSet> { get set }

    func moduleDidLoad()
}

class CountryInfoViewModel: CountryInfoViewModelProtocol {
    // MARK: - Public
    var didSelectCountry: AnyObserver<Country> { return selectedCountry.asObserver() }
    var countriesDataSet: Observable<CountriesDataSet>

    init(router: ToCountryInfoRouterProtocol, countriesDataSet: Observable<CountriesDataSet>) {
        self.router = router
        self.countriesDataSet = countriesDataSet
    }

    func moduleDidLoad() {
        bind()
    }
    // MARK: - Private
    private var router: ToCountryInfoRouterProtocol
    private let selectedCountry = PublishSubject<Country>()
    private let bag = DisposeBag()

    private func bind() {
        selectedCountry
            .subscribe(onNext: { [weak self] country in
                guard let self = self else { return }
                self.router.openDetailsForCountry(country, countriesDataSet: self.countriesDataSet)
            })
            .disposed(by: bag)
    }
}
