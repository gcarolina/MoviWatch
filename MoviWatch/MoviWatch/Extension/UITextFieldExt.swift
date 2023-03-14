//
//  UITextFieldExt.swift
//  MoviWatch
//
//  Created by Carolina on 14.03.23.
//

import UIKit

extension UITextField {
    func applyTextFieldStyle(placeholderName: String) {
        // Set the border color and width
        layer.borderColor = UIColor(red: 179, green: 40, blue: 85).cgColor
        layer.borderWidth = 1.4
        
        // Set the shadow properties
        layer.shadowColor = UIColor(red: 85, green: 51, blue: 178).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 3
        layer.shadowOpacity = 1.0
        
        // Set the attributed placeholder
        attributedPlaceholder = NSAttributedString(string: placeholderName, attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 86, green: 85, blue: 89)])
    }
}
