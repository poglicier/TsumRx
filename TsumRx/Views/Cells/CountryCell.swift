//
//  CountryCell.swift
//  rxFun
//
//  Created by Valentin Shamardin on 17/09/2019.
//  Copyright © 2019 Delitime. All rights reserved.
//

import UIKit

class CountryCell: UITableViewCell, ReusableCell {
    // MARK: - Public
    func configure(leftText: String, rightText: String?) {
        leftLabel?.text = leftText
        rightLabel?.text = rightText
    }
    // MARK: - Private
    @IBOutlet private var leftLabel: UILabel!
    @IBOutlet private var rightLabel: UILabel!
}
