//
//  SearchTableViewCell1.swift
//  MoviWatch
//
//  Created by Carolina on 5.04.23.
//

import UIKit
import SkeletonView

final class SearchTableViewCell: UITableViewCell {
    static var cellIdentifier = "SearchTableViewCell"
    
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var movieReleaseYearLabel: UILabel!
    @IBOutlet var movieLengthLabel: UILabel!
    @IBOutlet var moviePosterImageView: UIImageView!

    func configure(with movie: FilmSearchResponseFilms) {
        moviePosterImageView?.isSkeletonable = true
        let gradient = SkeletonGradient(baseColor: .midnightBlue)
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topLeftBottomRight, duration: 1.5)
        moviePosterImageView?.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation, transition: .crossDissolve(0.25))
        
        movieTitleLabel.text = movie.nameRu
        movieReleaseYearLabel.text = movie.year ?? ""
        movieLengthLabel?.text = movie.filmLength
        
        guard let posterUrlPreview = movie.posterUrlPreview else { return }
        
        NetworkService.getPhoto(imageURL: posterUrlPreview) { [weak self] image, error in
            DispatchQueue.main.async {
                if let image = image {
                    self?.moviePosterImageView.image = image
                    self?.setNeedsLayout()
                    self?.moviePosterImageView?.hideSkeleton(transition: .crossDissolve(0.25))
                } else {
                    self?.moviePosterImageView?.image = nil
                }
            }
        }
    }
}
