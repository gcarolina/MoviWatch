//
//  CollectionViewModelCell.swift
//  MoviWatch
//
//  Created by Carolina on 2.04.23.
//

import UIKit

// MARK: - CollectionViewModelCellProtocol
protocol CollectionViewModelCellProtocol {
    var filmName: String { get }
    func getImage(completion: @escaping (UIImage?) -> Void)
}

// MARK: - CollectionViewModelCell
final class CollectionViewCellViewModel: CollectionViewModelCellProtocol {
    private let item: ListCellModel
    
    init(item: ListCellModel) {
        self.item = item
    }
    
    internal var filmName: String {
        return item.title
    }
    
    internal func getImage(completion: @escaping (UIImage?) -> Void) {
        NetworkService.getPhoto(imageURL: item.image) { image, error in
            completion(image)
        }
    }
}
