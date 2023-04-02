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

final class CollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "CollectionViewCell"
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var filmName: UILabel!
    
    var viewModel: CollectionViewModelCellProtocol? {
        didSet {
            configure()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpAnimationForImage(imageView: imageView)
    }
    
    private func configure() {
        guard let viewModel = viewModel else { return }
        filmName.text = viewModel.filmName
        viewModel.getImage { [weak self] image in
            self?.imageView.image = image
            self?.imageView.hideSkeleton(transition: .crossDissolve(0.25))
        }
    }
    
    private func setUpAnimationForImage(imageView: UIImageView) {
        imageView.isSkeletonable = true
        let gradient = SkeletonGradient(baseColor: .midnightBlue)
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topLeftBottomRight, duration: 1.5)
        imageView.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation, transition: .crossDissolve(0.25))
    }
}

