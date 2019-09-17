//
//  ToCountryInfoRouterProtocol.swift
//  rxFun
//
//  Created by Valentin Shamardin on 17/09/2019.
//  Copyright © 2019 Delitime. All rights reserved.
//

import RxSwift

protocol ToCountryInfoRouterProtocol {
    func openDetailsForCountry(_ country: Country, countriesDataSet: Observable<CountriesDataSet>)
}
