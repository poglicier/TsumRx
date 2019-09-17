//
//  UITableViewCell+Reuse.swift
//  rxFun
//
//  Created by Valentin Shamardin on 17/09/2019.
//  Copyright © 2019 Delitime. All rights reserved.
//

import UIKit

protocol ReusableCell {
    static var identifier: String { get }
}

extension ReusableCell {
    static var identifier: String {
        return "\(self)"
    }
}

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(_ : T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
    }

    func dequeueCellAndRegisterIfNeeded<T: UITableViewCell>(_ : T.Type, for indexPath: IndexPath) -> T {
        var res: T
        if let cell = dequeueReusableCell(withIdentifier: String(describing: T.self)) {
            res = cell as! T
        } else {
            let fileName = String(describing: T.self)
            register(UINib(nibName: fileName, bundle: nil), forCellReuseIdentifier: fileName)
            let cell = dequeueReusableCell(withIdentifier: fileName, for: indexPath) as! T
            res = cell
        }
        return res
    }
}
