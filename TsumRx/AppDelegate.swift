//
//  AppDelegate.swift
//  rxFun
//
//  Created by Valentin Shamardin on 09/09/2019.
//  Copyright © 2019 Delitime. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let assembly = CountriesListAssembly()
        window?.rootViewController = assembly.build()
        return true
    }
}
