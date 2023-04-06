//
//  MainScreenModel.swift
//  MoviWatch
//
//  Created by Carolina on 16.03.23.

import Foundation
import Firebase
import FirebaseDatabase

struct UserName {
    
    // MARK: - Internal
    let name: String
    let email: String
    let ref: DatabaseReference?
    
    // MARK: - Lifecycle
    init(name: String, email: String, userID: String) {
        self.name = name
        self.email = email
        self.ref = nil
    }
    init?(snapshot: DataSnapshot) {
        guard let snapshotValue = snapshot.value as? [String: Any],
              let name = snapshotValue[Constants.nameKey] as? String,
              let email = snapshotValue[Constants.emailKey] as? String else { return nil }
        self.name = name
        self.email = email
        ref = snapshot.ref
    }

    func convertToDictionary() -> [String: Any] {
        [Constants.nameKey: name, Constants.emailKey: email]
    }

    // MARK: -  Private
    private enum Constants {
        static let nameKey = "name"
        static let emailKey = "email"
    }
}
