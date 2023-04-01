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
    
    func setup(_ title: String) {
        cellTitleLabel.text = title
    }
}
