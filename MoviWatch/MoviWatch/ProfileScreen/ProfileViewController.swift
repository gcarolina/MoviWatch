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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        personImage.layer.cornerRadius = personImage.frame.size.height / 2
        personImage.layer.borderWidth = 1.5
        personImage.layer.borderColor = CGColor(red: 105/255, green: 57/255, blue: 225/255, alpha: 1)
        
        imagePicker.delegate = self
        // Добавляем жест нажатия на UIImageView
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        personImage.isUserInteractionEnabled = true
        personImage.addGestureRecognizer(tapGesture)
    
        let signOutButton = UIBarButtonItem(title: "SignOut", style: .plain, target: self, action: #selector(signOutTapped))
        signOutButton.tintColor = UIColor(red: 105, green: 57, blue: 225)
        navigationItem.rightBarButtonItem = signOutButton
        
        guard let currentUser = Auth.auth().currentUser else { return }
        let user = User(user: currentUser)
        let ref = Database.database().reference(withPath: "users").child(String(user.userID))
        ref.observeSingleEvent(of: .value) { [weak self] snapshot in
            let model = UserName(snapshot: snapshot)
            let namePerson = model?.name
            let emailPerson = model?.email
            DispatchQueue.main.async {
                self?.personName.text = namePerson
                self?.personEmail.text = emailPerson
            }
        }
        
    }
    
    @objc private func signOutTapped() {
        do {
            try Auth.auth().signOut()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController else { return }
            navigationController?.pushViewController(vc, animated: true)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func imageViewTapped(_ sender: UITapGestureRecognizer) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Сделать фото", style: .default) { (action) in
                self.openCamera()
            }
            alertController.addAction(cameraAction)
        }
        
        let photoLibraryAction = UIAlertAction(title: "Выбрать из галереи", style: .default) { (action) in
            self.openPhotoLibrary()
        }
        alertController.addAction(photoLibraryAction)
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }

    func openCamera() {
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }

    func openPhotoLibrary() {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
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
