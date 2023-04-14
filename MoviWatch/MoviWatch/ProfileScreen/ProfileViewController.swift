//
//  ProfileViewController.swift
//  MoviWatch
//
//  Created by Carolina on 6.04.23.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import AVFoundation
import Photos

final class ProfileViewController: UIViewController {
    
    @IBOutlet private weak var personEmail: UILabel!
    @IBOutlet private weak var personName: UILabel!
    @IBOutlet private weak var personImage: UIImageView!
    
    let imagePicker = UIImagePickerController()
    var profileViewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpImage(image: personImage)
        imagePicker.delegate = self
        addTapGesture(to: personImage, target: self, action: #selector(imageViewTapped))
        setUpButton(with: "Sign Out")
        loadUserData()
    }
    
    // MARK: - IBAction
    @IBAction func imageViewTapped(_ sender: UITapGestureRecognizer) {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let photoLibraryAction = UIAlertAction(title: "Выбрать из галереи", style: .default) { (action) in
            self.openPhotoLibrary()
        }
        alertController.addAction(photoLibraryAction)

        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }

    // MARK: - Private actions
    @objc private func signOutTapped() {
        do {
            try Auth.auth().signOut()
            self.pushViewController(withIdentifier: "SignInViewController", viewControllerType: SignInViewController.self, storyboardName: "Main")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func openPhotoLibrary() {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func setUpImage(image: UIImageView) {
        image.layer.cornerRadius = personImage.frame.size.height / 2
        image.layer.borderWidth = 1.5
        image.layer.borderColor = CGColor(red: 105/255, green: 57/255, blue: 225/255, alpha: 1)
    }
    
    private func addTapGesture(to view: UIView, target: Any, action: Selector) {
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setUpButton(with title: String) {
        let signOutButton = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(signOutTapped))
        signOutButton.tintColor = UIColor(red: 105, green: 57, blue: 225)
        navigationItem.rightBarButtonItem = signOutButton
    }
    
    private func loadUserData() {
        profileViewModel.loadData { [weak self] in
            DispatchQueue.main.async {
                self?.personName.text = self?.profileViewModel.name
                self?.personEmail.text = self?.profileViewModel.email
            }
        }
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            personImage.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
