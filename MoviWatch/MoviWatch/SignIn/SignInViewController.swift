//  SignInViewController.swift
//  MoviWatch
//  Created by Carolina on 14.03.23.

import UIKit
import FirebaseDatabase
import FirebaseAuth

final class SignInViewController: UIViewController {
    private var viewModel: SignInViewModelProtocol?
    
    @IBOutlet private weak var emailTF: UITextField!
    @IBOutlet private weak var passwordTF: UITextField!
    @IBOutlet private weak var continueBtn: UIButton!
    @IBOutlet private weak var signUpBtn: UIButton!
    @IBOutlet private weak var scrollViewSignIn: UIScrollView!
    
    override func viewDidLoad() {
        viewModel = SignInViewModel()

        setUpUI()
        scrollViewSignIn.startKeyboardObserver()
        hideKeyboardWhenTappedAround()
        setDelegates()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.clearTextFields(emailTextField: emailTF, passwordTextField: passwordTF)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    @IBAction func continueBtnAction() {
        guard let email = emailTF.text,
              let password = passwordTF.text,
              email != "", password != "" else {
            showAlert(title: "Error", message: "Info is empty")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            if let error {
                self?.showAlert(title: "Error occurred", message: "\(error.localizedDescription)")
            } else if let _ = user {
                self?.pushViewController(withIdentifier: "MainScreenViewController", viewControllerType: MainScreenViewController.self, storyboardName: "Main")
                return
            } else {
                self?.showAlert(title: "Error occurred", message: "No such user")
            }
        }
    }
    
    private func setUpUI(){
        emailTF.applyTextFieldStyle(placeholderName: UserText.email.rawValue)
        passwordTF.applyTextFieldStyle(placeholderName: UserText.password.rawValue)
        signUpBtn.setButtonStyle()
    }
    
    @IBAction func signUpAction() {
        self.pushViewController(withIdentifier: "SignUpViewController", viewControllerType: SignUpViewController.self, storyboardName: "Main")
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
        })
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func setDelegates() {
        emailTF.delegate = self
        passwordTF.delegate = self
    }
}
