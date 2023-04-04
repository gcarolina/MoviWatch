//  SignUpViewController.swift
//  MoviWatch
//  Created by Carolina on 1.02.23.

import UIKit
import FirebaseDatabase
import FirebaseAuth

final class SignUpViewController: UIViewController {

    private var viewModel: SignUpViewModelProtocol?
    
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var continueButton: UIButton!
    @IBOutlet private weak var logInButton: UIButton!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    private var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle!
    
    override func viewDidLoad() {
        viewModel = SignUpViewModel()
        
        setUpUI()
        scrollView.startKeyboardObserver()
        hideKeyboardWhenTappedAround()
        setDelegates()
        viewModel?.viewController = self
//        checkIfPersonIsRegistered()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.clearTextFields(nameTextField: nameTextField, emailTextField: emailTextField, passwordTextField: passwordTextField)
        self.navigationItem.hidesBackButton = true
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        viewModel?.removeObservers(authStateDidChangeListenerHandle: authStateDidChangeListenerHandle)
    }
    
    private func setUpUI(){
        nameTextField.applyTextFieldStyle(placeholderName: UserText.profileName.rawValue)
        emailTextField.applyTextFieldStyle(placeholderName: UserText.email.rawValue)
        passwordTextField.applyTextFieldStyle(placeholderName: UserText.password.rawValue)
        logInButton.setButtonStyle(shadowOpacity: 1.0)
    }
    
    @IBAction func continueButtonAction() {
        if ((viewModel?.validateTextFields(nameTextField: nameTextField, emailTextField: emailTextField, passwordTextField: passwordTextField)) != nil) {
        
            viewModel?.createUser(name: nameTextField.text, email: emailTextField.text, password: passwordTextField.text) { [weak self] error in
                if let error = error {
                    self?.viewModel?.showAlert(title: "Error creating user", message: "\(error.localizedDescription)")
                } else {
                    self?.pushViewController(withIdentifier: "MainVC", viewControllerType: MainVC.self, storyboardName: "Main")
                }
            }
        }
    }
    
    @IBAction func logInAction() {
        self.pushViewController(withIdentifier: "SignInViewController", viewControllerType: SignInViewController.self, storyboardName: "Main")
    }
    
    private func setDelegates() {
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    private func checkIfPersonIsRegistered() {
        _ = viewModel?.addAuthStateDidChangeListener { [weak self] success in
            guard success else { return }
            self?.pushViewController(withIdentifier: "MainVC", viewControllerType: MainVC.self, storyboardName: "Main")
        }
    }
}
