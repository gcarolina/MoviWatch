//
//  SignUpViewController.swift
//  MoviWatch
//
//  Created by Carolina on 1.02.23.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

final class SignUpViewController: UIViewController {

    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var continueButton: UIButton!
    @IBOutlet private weak var logInButton: UIButton!
    @IBOutlet private weak var scrollView: UIScrollView!
    
//    private var isTextFieldEmpty = false
    var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle!
    
    override func viewDidLoad() {
        setUpUI()
        scrollView.startKeyboardObserver()
        hideKeyboardWhenTappedAround()
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
//        authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
//            guard let _ = user else { return }
//
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            if let mainVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController {
//                self?.navigationController?.pushViewController(mainVC, animated: true)
//            }
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // очистка полей
        nameTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
        if let handle = authStateDidChangeListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    private func setUpUI(){
        nameTextField.applyTextFieldStyle(placeholderName: UserText.profileName.rawValue )
        emailTextField.applyTextFieldStyle(placeholderName: UserText.email.rawValue)
        passwordTextField.applyTextFieldStyle(placeholderName: UserText.password.rawValue)
        logInButton.setButtonStyle()
    }
    
    @IBAction func continueButtonAction() {
        guard let name = nameTextField.text,
              let email = emailTextField.text,
              let password = passwordTextField.text,
              name != "", email != "", password != "" else {
//            isTextFieldEmpty = false
            return
        }
//        isTextFieldEmpty = true
//        continueButton.isEnabled = isTextFieldEmpty
//
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            if let error = error {
                print("Ошибка при создании пользователя: \(error.localizedDescription)")
            } else {
                guard let user = user else { return }
                let ref = Database.database().reference().child("users").child(user.user.uid)
                ref.setValue(["email": user.user.email, "name": name]) { (error, ref) in
                    if let error = error {
                        print("Ошибка при записи в базу данных: \(error.localizedDescription)")
                    } else {
                        print("Имя пользователя успешно записано в базу данных")
                    }
                }
            }
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let signInVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController {
            navigationController?.pushViewController(signInVC, animated: true)
        }
    }
    
    @IBAction func logInAction() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let signInVC = storyboard.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController {
            navigationController?.pushViewController(signInVC, animated: true)
        }
    }
}
