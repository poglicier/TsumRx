//
//  CountriesDataSet.swift
//  rxFun
//
//  Created by Valentin Shamardin on 17/09/2019.
//  Copyright © 2019 Delitime. All rights reserved.
//

import Foundation

struct CountriesDataSet {
    // MARK: - Public
    init(countries: [Country]) {
        self.countries = countries.sorted { $0.name < $1.name }
    }

    func country(byCioc cioc: String) -> Country? {
        return countries.first(where: { $0.cioc == cioc })
    }
    // MARK: - Private
    private(set) var countries = [Country]()
}
