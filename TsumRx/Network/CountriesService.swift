//
//  CountriesService.swift
//  rxFun
//
//  Created by Valentin Shamardin on 16/09/2019.
//  Copyright © 2019 Delitime. All rights reserved.
//

import RxSwift

protocol CountriesServiceProtocol {
    func getCountries() -> Single<[Country]>
}

class CountriesService {
    private let api: ApiProvider<CountriesApi>

    init(api: ApiProvider<CountriesApi>) {
        self.api = api
    }
}

extension CountriesService: CountriesServiceProtocol {
    func getCountries() -> Single<[Country]> {
        let request = CountriesRequest()
        return api.request(.countries(request: request))
            .map([Country].self)
    }
}
