//
//  SearchTableViewCell1.swift
//  MoviWatch
//
//  Created by Carolina on 5.04.23.
//

import UIKit

final class SearchTableViewCell: UITableViewCell {
    static var cellIdentifier = "SearchTableViewCell"
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var lengthLabel: UILabel!
    @IBOutlet var filmImagePreview: UIImageView!
}

