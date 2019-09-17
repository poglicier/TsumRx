//
//  ApiProvider.swift
//  rxFun
//
//  Created by Valentin Shamardin on 16/09/2019.
//  Copyright © 2019 Delitime. All rights reserved.
//

import Moya
import RxSwift

class ApiProvider<Target> where Target: TargetType {
    private let provider: MoyaProvider<Target>

    init(endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider<Target>.defaultEndpointMapping,
         requestClosure: @escaping MoyaProvider<Target>.RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
         stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider.neverStub,
         manager: Manager = MoyaProvider<Target>.defaultAlamofireManager(),
         plugins: [PluginType] = [],
         trackInflights: Bool = false) {

        self.provider = MoyaProvider(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, manager: manager, plugins: plugins, trackInflights: trackInflights)
    }

    func request(_ target: Target) -> Single<Response> {
        let actualRequest = provider.rx.request(target)

        return provider.rx
            .request(target)
            .catchError { error -> Single<Response> in
                return actualRequest
            }
    }
}
