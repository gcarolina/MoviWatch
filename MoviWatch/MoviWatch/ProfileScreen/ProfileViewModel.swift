//
//  ProfileViewModel.swift
//  MoviWatch
//
//  Created by Carolina on 6.04.23.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

final class ProfileViewModel {
    
    var name: String?
    var email: String?
    var image: UIImage?
    
    func loadData(completion: @escaping () -> Void) {
        guard let currentUser = Auth.auth().currentUser else { return }
        let user = User(user: currentUser)
        let ref = Database.database().reference(withPath: "users").child(String(user.userID))
        ref.observeSingleEvent(of: .value) { [weak self] snapshot in
            let model = UserName(snapshot: snapshot)
            self?.name = model?.name
            self?.email = model?.email
            completion()
        }
    }
    
    func updateImage(_ image: UIImage?) {
        self.image = image
    }
}
