//  SignInViewModel.swift
//  MoviWatch
//  Created by Carolina on 20.03.23.

import UIKit
import FirebaseDatabase
import FirebaseAuth

protocol SignInViewModelProtocol {
    func clearTextFields(emailTextField: UITextField, passwordTextField: UITextField)
    func showAlert(title: String, message: String, onViewController viewController: UIViewController)
    func signIn(email: String?, password: String?, completion: @escaping (Result<Void, Error>) -> Void)
}

final class SignInViewModel: SignInViewModelProtocol {
    
    func clearTextFields(emailTextField: UITextField, passwordTextField: UITextField) {
        emailTextField.clearField()
        passwordTextField.clearField()
    }
    
    func showAlert(title: String, message: String, onViewController viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }

    func signIn(email: String?, password: String?, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let email = email, let password = password, !email.isEmpty, !password.isEmpty else {
            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Info is empty"])))
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if let error = error {
                completion(.failure(error))
            } else if user != nil {
                completion(.success(()))
            } else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No such user"])))
            }
        }
    }
}
