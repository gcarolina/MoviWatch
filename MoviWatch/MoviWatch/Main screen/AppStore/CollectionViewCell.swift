//
//  CollectionViewCell.swift
//  MoviWatch
//
//  Created by Carolina on 30.03.23.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    var posterUrlPreview: String? {
        didSet {
            getPosterUrlPreview()
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var filmName: UILabel!
    
    static let reuseIdentifier = "CollectionViewCell"
    
    
    func configure(with name: String) {
        filmName.text = name
    }
    
    private func getPosterUrlPreview() {
        guard let posterUrlPreview = posterUrlPreview else { return }
        NetworkService.getPhoto(imageURL: posterUrlPreview) { [weak self] image, error in
            self?.imageView.image = image
        }
    }
}
