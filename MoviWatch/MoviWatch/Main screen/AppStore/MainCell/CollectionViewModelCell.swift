//
//  CollectionViewModelCell.swift
//  MoviWatch
//
//  Created by Carolina on 2.04.23.
//

import UIKit

// MARK: - TableViewCellViewModelProtocol

protocol CollectionViewModelCellProtocol {
    var filmName: String { get }
    func getImage(completion: @escaping (UIImage?) -> Void)
}

class CollectionViewCellViewModel: CollectionViewModelCellProtocol {
    let item: ListCellModel
    
    init(item: ListCellModel) {
        self.item = item
    }
    
    var filmName: String {
        return item.title
    }
    
    func getImage(completion: @escaping (UIImage?) -> Void) {
        NetworkService.getPhoto(imageURL: item.image) { image, error in
            completion(image)
        }
    }
}
