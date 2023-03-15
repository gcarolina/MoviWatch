//
//  UserModel.swift
//  MoviWatch
//
//  Created by Carolina on 14.03.23.
//

import Foundation
import Firebase

struct User {
    
    // MARK: - Internal
    /// идентификатор пользователя
    let userID: String
    let email: String
    
    // MARK: - Life cycle
    
    init(user: Firebase.User) {
        self.userID = user.uid
        self.email = user.email ?? ""
    }
}
