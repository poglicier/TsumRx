//
//  CountriesListAssembly.swift
//  rxFun
//
//  Created Valentin Shamardin on 16/09/2019.
//  Copyright © 2019 Delitime. All rights reserved.
//

import UIKit

class CountriesListAssembly {
    // MARK: - Public
    func build() -> UIViewController {
        let view = CountriesListViewController.storyboardViewController()
        let router = CountriesListRouter()

        let countriesService = CountriesService(api: ApiProvider<CountriesApi>())
        let viewModel = CountriesListViewModel(router: router,
                                               countriesService: countriesService)

        view.viewModel = viewModel
        router.moduleViewController = view

        let navigationController = UINavigationController(rootViewController: view)

        return navigationController
    }
}
