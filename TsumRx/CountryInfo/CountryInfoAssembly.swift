//
//  CountryInfoAssembly.swift
//  rxFun
//
//  Created Valentin Shamardin on 17/09/2019.
//  Copyright © 2019 Delitime. All rights reserved.
//

import RxSwift

class CountryInfoAssembly {
    // MARK: - Public
    func build(country: Country, countriesDataSet: Observable<CountriesDataSet>) -> UIViewController {
        let view = CountryInfoViewController.storyboardViewController()
        let router = CountryInfoRouter()
        let viewModel = CountryInfoViewModel(router: router, countriesDataSet: countriesDataSet)
        
        view.viewModel = viewModel
        view.country = country
        router.moduleViewController = view
        
        return view
    }
}
