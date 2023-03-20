//
//  UIViewControllerExt.swift
//  MoviWatch
//
//  Created by Carolina on 14.03.23.
//
import UIKit

extension UIViewController: UITextFieldDelegate {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func pushViewController<T: UIViewController>(withIdentifier identifier: String, viewControllerType: T.Type, storyboardName: String) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? T {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
