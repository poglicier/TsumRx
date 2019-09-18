//
//  CountriesServiceTests.swift
//  TsumRxTests
//
//  Created by Валентин Шамардин on 18/09/2019.
//  Copyright © 2019 Валентин Шамардин. All rights reserved.
//

import XCTest
import RxSwift
import Moya
@testable import TsumRx

class CountriesServiceTests: XCTestCase {
    var countriesService: CountriesService!
    let bag = DisposeBag()

    func customEndpointClosure(filename: String) -> ((CountriesApi) -> Endpoint) {
        return { target in
            Endpoint(url: URL(target: target).absoluteString,
            sampleResponseClosure: { .networkResponse(200, target.testSampleData(filename: filename)) },
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers)
        }
    }

    func testCountriesJsonProvidesNoErrors() {
        countriesService = CountriesService(api: ApiProvider<CountriesApi>(endpointClosure: customEndpointClosure(filename: "countries"),
                                                                           stubClosure: MoyaProvider.immediatelyStub))
        let expectation = XCTestExpectation(description: "download countries")
        countriesService.getCountries()
            .subscribe(onSuccess: { countries in
                expectation.fulfill()
                }, onError: { error in
                    XCTFail()
                    expectation.fulfill()
            })
            .disposed(by: bag)
        wait(for: [expectation], timeout: 1)
    }
    
    func testXmlProvidesFormatError() {
        countriesService = CountriesService(api: ApiProvider<CountriesApi>(endpointClosure: customEndpointClosure(filename: "xml"),
                                                                           stubClosure: MoyaProvider.immediatelyStub))
        let expectation = XCTestExpectation(description: "download countries")
        countriesService.getCountries()
            .subscribe(onSuccess: { countries in
                XCTFail()
                expectation.fulfill()
            }, onError: { error in
                expectation.fulfill()
            })
            .disposed(by: bag)
        wait(for: [expectation], timeout: 1)
    }
}

extension CountriesApi {
    func testSampleData(filename: String) -> Data {
        guard let data = Data.data(with: filename) else {
            XCTFail()
            return Data()
        }
        return data
    }
}
