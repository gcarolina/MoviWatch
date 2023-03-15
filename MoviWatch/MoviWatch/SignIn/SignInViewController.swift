//
//  SignInViewController.swift
//  MoviWatch
//
//  Created by Carolina on 14.03.23.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

final class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var scrollViewSignIn: UIScrollView!
    
    override func viewDidLoad() {
        setUpUI()
        scrollViewSignIn.startKeyboardObserver()
        hideKeyboardWhenTappedAround()
        emailTF.delegate = self
        passwordTF.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailTF.text = ""
        passwordTF.text = ""
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func setUpUI(){
        emailTF.applyTextFieldStyle(placeholderName: "Email")
        passwordTF.applyTextFieldStyle(placeholderName: "Password")
        signUpBtn.setButtonStyle()
    }
    
    @IBAction func signUpAction() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let signUpVC = storyboard.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController {
            navigationController?.pushViewController(signUpVC, animated: true)
        }
    }
}
