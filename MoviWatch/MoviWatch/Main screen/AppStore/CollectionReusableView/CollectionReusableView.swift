//
//  CollectionReusableView.swift
//  MoviWatch
//
//  Created by Carolina on 30.03.23.
//

import UIKit

class CollectionReusableView: UICollectionReusableView {

    static let reuseIdentifier = "CollectionReusableView"
    
    @IBOutlet weak var cellTitleLabel: UILabel!
    
    var viewModel: CollectionReusableViewModel? {
        didSet {
            configure()
        }
    }
    
    func configure() {
        guard let viewModel = viewModel else { return }
        cellTitleLabel.text = viewModel.cellTitle
    }
}
