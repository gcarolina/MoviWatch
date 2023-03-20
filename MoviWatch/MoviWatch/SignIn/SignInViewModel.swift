//  SignInViewModel.swift
//  MoviWatch
//  Created by Carolina on 20.03.23.

import UIKit
import FirebaseDatabase
import FirebaseAuth

protocol SignInViewModelProtocol {
    var viewController: UIViewController? { get set }
    func clearTextFields(emailTextField: UITextField, passwordTextField: UITextField)
    func showAlert(title: String, message: String)
    func signInUser(email: String?, password: String?, completion: @escaping (Error?) -> Void)
    func validateTextFields(emailTextField: UITextField, passwordTextField: UITextField) -> Bool
}

final class SignInViewModel: SignInViewModelProtocol {
    var viewController: UIViewController?
    
    func clearTextFields(emailTextField: UITextField, passwordTextField: UITextField) {
        emailTextField.clearField()
        passwordTextField.clearField()
    }
    
    func showAlert(title: String, message: String) {
        guard let viewController = viewController else {
            return
        }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    func signInUser(email: String?, password: String?, completion: @escaping (Error?) -> Void) {
        guard let email = email,
              let password = password else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if let error = error {
                completion(error)
            } else if let _ = user {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
    
    func validateTextFields(emailTextField: UITextField, passwordTextField: UITextField) -> Bool {
        guard let email = emailTextField.text, !email.isEmpty else {
            showAlert(title: "Error!", message: "You're email is empty")
            return false
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            showAlert(title: "Error!", message: "You're password is empty")
            return false
        }
        return true
    }
    
}
