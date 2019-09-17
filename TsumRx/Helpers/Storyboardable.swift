//
//  Storyboardable.swift
//  rxFun
//
//  Created by Valentin Shamardin on 16/09/2019.
//  Copyright © 2019 Delitime. All rights reserved.
//

import UIKit

protocol Storyboardable: class {
    static var storyboardIdentifier: String { get }
    static var storyboardName: String { get }
}

extension Storyboardable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }

    static var storyboardName: String {
        return "Main"
    }

    static func storyboardViewController() -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        guard let vc = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as? Self else {
            fatalError("Couldn't create a storyboard of \(storyboardIdentifier) class")
        }
        return vc
    }
}
