//
//  CollectionReusableViewModel.swift
//  MoviWatch
//
//  Created by Carolina on 2.04.23.
//

import Foundation
// MARK: - CollectionReusableViewProtocol
protocol CollectionReusableViewProtocol {
    var title: String { get }
}

// MARK: - CollectionReusableViewModel
final class CollectionReusableViewModel: CollectionReusableViewProtocol {
    internal let title: String
    
    init(title: String) {
        self.title = title
    }
    
    var cellTitle: String {
        return title
    }
}
