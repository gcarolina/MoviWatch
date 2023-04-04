//
//  UILabelExt.swift
//  MoviWatch
//
//  Created by Carolina on 4.04.23.
//

import UIKit

extension UILabel {
    func setStyle(shadowOpacity: Float) {
        layer.shadowColor = UIColor(red: 85, green: 51, blue: 178).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 3
        layer.shadowOpacity = shadowOpacity
    }
    func setCornerRadius() {
        layer.cornerRadius = frame.size.height / 2
    }
}
