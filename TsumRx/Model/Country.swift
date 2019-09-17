//
//  Country.swift
//  rxFun
//
//  Created by Valentin Shamardin on 16/09/2019.
//  Copyright © 2019 Delitime. All rights reserved.
//

import Foundation

struct Country: Codable {
    // MARK: - Public
    let cioc: String?
    let name: String
    let population: String
    let borders: [String]
    let capital: String
    let currencies: [String]?

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        cioc = try? container.decode(String.self, forKey: .cioc)
        name = try container.decode(String.self, forKey: .name)
        let rawPopulation = try container.decode(Int.self, forKey: .population)
        population = Country.populationFormatter.string(from: NSNumber(value: rawPopulation)) ?? "\(rawPopulation)"
        borders = try container.decode([String].self, forKey: .borders)
        capital = try container.decode(String.self, forKey: .capital)
        currencies = try? container.decode([Currency].self, forKey: .currencies).map { $0.name }
    }
    // MARK: - Private
    private static let populationFormatter: NumberFormatter = {
        let res = NumberFormatter()
        res.numberStyle = .decimal
        res.locale = Locale.current
        res.groupingSeparator = " "
        return res
    }()

    private struct Currency: Codable {
        let name: String
    }
}
