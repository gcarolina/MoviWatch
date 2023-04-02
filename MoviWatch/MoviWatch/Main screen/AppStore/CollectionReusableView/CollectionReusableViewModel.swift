//
//  CollectionReusableViewModel.swift
//  MoviWatch
//
//  Created by Carolina on 2.04.23.
//

import Foundation

protocol CollectionReusableViewProtocol {
    var title: String { get }
}

class CollectionReusableViewModel: CollectionReusableViewProtocol {
    let title: String
    
    init(title: String) {
        self.title = title
    }
    
    var cellTitle: String {
        return title
    }
}
