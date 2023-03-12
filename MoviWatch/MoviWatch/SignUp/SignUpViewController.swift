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
    @IBOutlet private weak var joinedLabel: UILabel!
    @IBOutlet private weak var logInButton: UIButton!
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()

    override func viewDidLoad() {
        setupScrollView()
        setUpUI()
    }

    private func setupScrollView(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }

    private func setUpUI(){

        //Name TextField
        nameTextField.layer.borderColor = UIColor(red: 179, green: 40, blue: 85).cgColor
        nameTextField.layer.borderWidth = 1.4

        nameTextField.layer.shadowColor = UIColor(red: 85, green: 51, blue: 178).cgColor
        nameTextField.layer.shadowOffset = CGSize(width: 0, height: 3)
        nameTextField.layer.shadowRadius = 3
        nameTextField.layer.shadowOpacity = 1.0

        nameTextField.attributedPlaceholder = NSAttributedString(string: "Profile name", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 86, green: 85, blue: 89)])
        
        //Email TextField
        emailTextField.layer.borderColor = UIColor(red: 179, green: 40, blue: 85).cgColor
        emailTextField.layer.borderWidth = 1.4

        emailTextField.layer.shadowColor = UIColor(red: 85, green: 51, blue: 178).cgColor
        emailTextField.layer.shadowOffset = CGSize(width: 0, height: 3)
        emailTextField.layer.shadowRadius = 3
        emailTextField.layer.shadowOpacity = 1.0

        emailTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 86, green: 85, blue: 89)])
        
        //Password TextField
        passwordTextField.layer.borderColor = UIColor(red: 179, green: 40, blue: 85).cgColor
        passwordTextField.layer.borderWidth = 1.4

        passwordTextField.layer.shadowColor = UIColor(red: 85, green: 51, blue: 178).cgColor
        passwordTextField.layer.shadowOffset = CGSize(width: 0, height: 3)
        passwordTextField.layer.shadowRadius = 3
        passwordTextField.layer.shadowOpacity = 1.0

        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 86, green: 85, blue: 89)])
        
        logInButton.layer.shadowColor = UIColor(red: 85, green: 51, blue: 178).cgColor
        logInButton.layer.shadowOffset = CGSize(width: 0, height: 3)
        logInButton.layer.shadowRadius = 3
        logInButton.layer.shadowOpacity = 1.0
    }
}
