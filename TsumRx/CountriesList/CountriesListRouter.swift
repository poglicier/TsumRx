//
//  CountriesListRouter.swift
//  rxFun
//
//  Created Valentin Shamardin on 16/09/2019.
//  Copyright © 2019 Delitime. All rights reserved.
//

import RxSwift

class CountriesListRouter: ToCountryInfoRouterProtocol {
    weak var moduleViewController: UIViewController!

    func openDetailsForCountry(_ country: Country, countriesDataSet: Observable<CountriesDataSet>) {
        let module = CountryInfoAssembly().build(country: country, countriesDataSet: countriesDataSet)
        moduleViewController.navigationController?.pushViewController(module, animated: true)
    }
}
