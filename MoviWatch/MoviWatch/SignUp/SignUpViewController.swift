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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    private func setUpUI(){
        nameTextField.applyTextFieldStyle(placeholderName: "Profile name")
        emailTextField.applyTextFieldStyle(placeholderName: "Email")
        passwordTextField.applyTextFieldStyle(placeholderName: "Password")
        logInButton.setButtonStyle()
    }
    
    @IBAction func logInAction() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let signInVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController {
            navigationController?.pushViewController(signInVC, animated: true)
        }
    }
}
