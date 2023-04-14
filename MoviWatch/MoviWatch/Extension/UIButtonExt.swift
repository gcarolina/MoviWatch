//
//  UIButtonExt.swift
//  MoviWatch
//
//  Created by Carolina on 14.03.23.
//

import UIKit

extension UIButton {
    func setButtonStyle(shadowOpacity: Float) {
        layer.shadowColor = UIColor(red: 85, green: 51, blue: 178).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 3
        layer.shadowOpacity = shadowOpacity
    }
    
    func applyButtonStyle() {
        layer.borderColor = UIColor(red: 179, green: 40, blue: 85).cgColor
        layer.borderWidth = 1.4
    }
    func setCornerRadius() {
        layer.cornerRadius = frame.size.height / 2
    }
}
