//
//  SignUpViewModel.swift
//  MoviWatch
//
//  Created by Carolina on 16.03.23.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

protocol SignUpViewModelProtocol {
    var viewController: UIViewController? { get set }
    func addAuthStateDidChangeListener(completion: @escaping (Bool) -> Void) -> AuthStateDidChangeListenerHandle?
    func removeObservers(authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?)
    func clearTextFields(nameTextField: UITextField, emailTextField: UITextField, passwordTextField: UITextField)
    func createUser(name: String?, email: String?, password: String?, completion: @escaping (Error?) -> Void)
    func showAlert(title: String, message: String)
    func validateTextFields(nameTextField: UITextField, emailTextField: UITextField, passwordTextField: UITextField) -> Bool
}


final class SignUpViewModel: SignUpViewModelProtocol {
    var viewController: UIViewController?
    
    func addAuthStateDidChangeListener(completion: @escaping (Bool) -> Void) -> AuthStateDidChangeListenerHandle? {
        let handle = Auth.auth().addStateDidChangeListener { _, user in
            guard let _ = user else { return }
            completion(true)
        }
        return handle
    }

    func removeObservers(authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?) {
        NotificationCenter.default.removeObserver(self)
        if let handle = authStateDidChangeListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    func clearTextFields(nameTextField: UITextField, emailTextField: UITextField, passwordTextField: UITextField) {
        nameTextField.clearField()
        emailTextField.clearField()
        passwordTextField.clearField()
    }
    
    func createUser(name: String?, email: String?, password: String?, completion: @escaping (Error?) -> Void) {
        guard let name = name,
              let email = email,
              let password = password else { return }
            
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            if let error = error {
                completion(error)
            } else {
                guard let user = user else { return }
                let ref = Database.database().reference().child("users").child(user.user.uid)
                ref.setValue(["email": user.user.email, "name": name]) { error, ref in
                    if let error = error {
                        completion(error)
                    } else {
                        completion(nil)
                    }
                }
            }
        }
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
    
    func validateTextFields(nameTextField: UITextField, emailTextField: UITextField, passwordTextField: UITextField) -> Bool {
        guard let name = nameTextField.text, !name.isEmpty else {
            showAlert(title: "Error!", message: "You're name is empty")
            return false
        }
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
