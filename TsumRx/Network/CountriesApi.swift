//
//  CountryApi.swift
//  rxFun
//
//  Created by Valentin Shamardin on 16/09/2019.
//  Copyright © 2019 Delitime. All rights reserved.
//

import Moya

enum CountriesApi {
    case countries(request: CountriesRequest)
}

extension CountriesApi: TargetType {
    var baseURL: URL {
        return URL(string: "https://restcountries.eu/rest/v2/")!
    }

    var path: String {
        switch self {
        case .countries: return "all"
        }
    }

    var method: Method {
        switch self {
        case .countries: return .get
        }
    }

    var task: Task {
        switch self {
        case .countries(let request):
            return .requestJSONEncodable(request)
        }
    }
}

extension TargetType {
    var validationType: ValidationType {
        return .successCodes
    }

    var headers: [String : String]? {
        return [:]
    }

    var sampleData: Data {
        return Data()
    }
}
