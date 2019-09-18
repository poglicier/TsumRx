//
//  Data+Tests.swift
//  TsumRxTests
//
//  Created by Валентин Шамардин on 18/09/2019.
//  Copyright © 2019 Валентин Шамардин. All rights reserved.
//

import Foundation

extension Data {
    static func data(with filename: String) -> Data? {
        guard let path = Bundle(for: CountryTest.self).path(forResource: filename, ofType: "json") else {
            return nil
        }
        let url = URL(fileURLWithPath: path)
        return try? Data(contentsOf: url)
    }
}
