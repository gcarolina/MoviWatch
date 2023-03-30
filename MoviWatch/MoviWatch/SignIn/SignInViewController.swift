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
        viewModel?.signIn(email: emailTF.text, password: passwordTF.text) { [weak self] result in
            switch result {
            case .success:
                self?.pushViewController(withIdentifier: "MainVC", viewControllerType: MainVC.self, storyboardName: "Main")
            case .failure(let error):
                self?.viewModel?.showAlert(title: "Error occurred", message: error.localizedDescription, onViewController: self!)
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
    
    private func setDelegates() {
        emailTF.delegate = self
        passwordTF.delegate = self
    }
}
