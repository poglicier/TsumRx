//
//  CountryTest.swift
//  TsumRxTests
//
//  Created by Валентин Шамардин on 18/09/2019.
//  Copyright © 2019 Валентин Шамардин. All rights reserved.
//

import XCTest
@testable import TsumRx

class CountryTest: XCTestCase {
    var countriesData: Data?

    func testCountriesJsonProduces4Countries() {
        guard let data = Data.data(with: "countries") else {
            XCTFail()
            return
        }
        
        let decoder = JSONDecoder()
        guard let countries = try? decoder.decode([Country].self, from: data) else {
            XCTFail()
            return
        }
        XCTAssertEqual(countries.count, 4)
    }
    
    func testAfgJsonProduces() {
        guard let data = Data.data(with: "afg") else {
            XCTFail()
            return
        }
        
        let decoder = JSONDecoder()
        let country = try? decoder.decode(Country.self, from: data)
        XCTAssertNotNil(country)
        XCTAssertEqual(country?.name, "Afghanistan")
        XCTAssertEqual(country?.capital, "Kabul")
        XCTAssertEqual(country?.population, "27 657 145")
        XCTAssertEqual(country?.cioc, "AFG")
        XCTAssertEqual(country?.borders.count, 6)
    }
    
    func testCountryWithoutNameDoesntProduceObject() {
        guard let data = Data.data(with: "countryWithoutName") else {
            XCTFail()
            return
        }
        
        let decoder = JSONDecoder()
        let country = try? decoder.decode(Country.self, from: data)
        XCTAssertNil(country)
    }
}
