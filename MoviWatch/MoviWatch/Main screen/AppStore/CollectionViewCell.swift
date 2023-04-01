//
//  CollectionViewCell.swift
//  MoviWatch
//
//  Created by Carolina on 30.03.23.
//

import UIKit
import SkeletonView
import Alamofire
import AlamofireImage

class CollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "CollectionViewCell"
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var filmName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.isSkeletonable = true
        let gradient = SkeletonGradient(baseColor: .midnightBlue)
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topLeftBottomRight, duration: 1.5)
        imageView.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation, transition: .crossDissolve(0.25))
    }
    
    func setup(_ item: ListCellModel) {
        filmName.text = item.title
        NetworkService.getPhoto(imageURL: item.image) { [weak self] image, error in
            self?.imageView.image = image
            self?.imageView.hideSkeleton(transition: .crossDissolve(0.25))
        }
    }
}
