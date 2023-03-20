//
//  MainScreenModel.swift
//  MoviWatch
//
//  Created by Carolina on 16.03.23.

import Foundation
import Firebase
import FirebaseDatabase

struct UserName {
    
    // MARK: Internal

    let name: String
    let ref: DatabaseReference? // Reference к конкретной записи в DB
    
    // MARK: Lifecycle

    // для создания объекта локально
    init(name: String, userID: String) {
        self.name = name
        self.ref = nil
    }

    // для создания объекта из сети
    init?(snapshot: DataSnapshot) { // DataSnapshot - снимок иерархии DB
        guard let snapshotValue = snapshot.value as? [String: Any],
              let name = snapshotValue[Constants.nameKey] as? String else { return nil }
        self.name = name
        ref = snapshot.ref
    }

    func convertToDictionary() -> [String: Any] {
        [Constants.nameKey: name]
    }

    // MARK: Private

    private enum Constants {
        static let nameKey = "name"
    }
}
