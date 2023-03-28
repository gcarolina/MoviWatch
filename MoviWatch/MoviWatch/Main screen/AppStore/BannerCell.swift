//
//  BannerCell.swift
//  MoviWatch
//
//  Created by Carolina on 27.03.23.
//

import UIKit

class BannerCell: UICollectionViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    static let reuseIdentifier = "BannerCell"
    
    func configure(with title: String, subtitle: String, image: UIImage?) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        imageView.image = image
    }
    
}
