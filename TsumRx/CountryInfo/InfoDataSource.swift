//
//  InfoDataSource.swift
//  rxFun
//
//  Created by Valentin Shamardin on 17/09/2019.
//  Copyright © 2019 Delitime. All rights reserved.
//

import UIKit
import Foundation

class InfoDataSource: NSObject {
    // MARK: - Public
    var country: Country!
    var countriesDataSet: CountriesDataSet!

    enum Section: Int {
        case base
        case boundaries
        case currencies
        case count
    }

    // MARK: - Private
    private enum BaseSectionRow: Int {
        case capital
        case population
        case cioc
        case count
    }
}

extension InfoDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.count.rawValue
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionEnum = Section(rawValue: section) else { return 0 }
        var res = 0

        switch sectionEnum {
        case .base:
            res = BaseSectionRow.count.rawValue
        case .boundaries:
            res = country.borders.count
        case .currencies:
            res = country.currencies?.count ?? 0
        case .count:
            break
        }
        return res
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sectionEnum = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        let res = tableView.dequeueCellAndRegisterIfNeeded(CountryCell.self, for: indexPath)
        res.selectionStyle = .none

        switch sectionEnum {
        case .base:
            guard let row = BaseSectionRow(rawValue: indexPath.row) else { break }

            switch row {
            case .capital:
                res.configure(leftText: "Capital", rightText: country.capital)
            case .population:
                res.configure(leftText: "Population", rightText: country.population)
            case .cioc:
                res.configure(leftText: "cioc", rightText: country.cioc)
            case .count:
                break
            }
        case .boundaries:
            let borderingCountryCioc = country.borders[indexPath.row]
            let borderingCountry = countriesDataSet.country(byCioc: borderingCountryCioc)
            res.configure(leftText: borderingCountry?.name ?? borderingCountryCioc, rightText: nil)
            res.selectionStyle = .default
        case .currencies:
            let currency = country.currencies![indexPath.row]
            res.configure(leftText: currency, rightText: nil)
        case .count:
            break
        }
        return res
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sectionEnum = Section(rawValue: section) else { return nil }
        var res: String?

        switch sectionEnum {
        case .base, .count:
            break
        case .boundaries:
            res =  country.borders.count > 0 ? "Boundaries" : nil
        case .currencies:
            res = (country.currencies?.count ?? 0) > 0 ? "Currencies" : nil
        }
        return res
    }
}
