//
//  SignUpViewController.swift
//  MoviWatch
//
//  Created by Carolina on 1.02.23.
//

import UIKit

final class SignUpViewController: UIViewController {

    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var continueButton: UIButton!
    @IBOutlet private weak var logInButton: UIButton!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        setUpUI()
        scrollView.startKeyboardObserver()
        hideKeyboardWhenTappedAround()
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }

    private func setUpUI(){
        nameTextField.applyTextFieldStyle(placeholderName: "Profile name")
        emailTextField.applyTextFieldStyle(placeholderName: "Email")
        passwordTextField.applyTextFieldStyle(placeholderName: "Password")
        logInButton.setButtonStyle()
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
