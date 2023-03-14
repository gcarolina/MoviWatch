//
//  UIButtonExt.swift
//  MoviWatch
//
//  Created by Carolina on 14.03.23.
//

import UIKit

extension UIButton {
    func setButtonStyle() {
        layer.shadowColor = UIColor(red: 85, green: 51, blue: 178).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 3
        layer.shadowOpacity = 1.0
    }
}
