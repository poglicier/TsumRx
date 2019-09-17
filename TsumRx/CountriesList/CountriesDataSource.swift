//
//  CountriesDataSource.swift
//  rxFun
//
//  Created by Valentin Shamardin on 17/09/2019.
//  Copyright © 2019 Delitime. All rights reserved.
//

import UIKit

class CountriesDataSource: NSObject {
    // MARK: - Public
    var countriesDataSet = CountriesDataSet(countries: [])
}

extension CountriesDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesDataSet.countries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let res = tableView.dequeueCellAndRegisterIfNeeded(CountryCell.self, for: indexPath)
        let country = countriesDataSet.countries[indexPath.row]
        res.configure(leftText: country.name, rightText: "\(country.population)")
        return res
    }
}
