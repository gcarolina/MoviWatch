//
//  SectionModel.swift
//  MoviWatch
//
//  Created by Carolina on 2.04.23.
//

import Foundation

struct Section {
    let title: String
    let items: [ListCellModel]
}

enum TitleForSection: String {
    case thriller = "Триллер"
    case drama = "Драма"
    case crime = "Криминал"
    case melodrama = "Мелодрама"
    case detective = "Детектив"
    case fantasy = "Фентези"
}

enum ListSection {
    case thriller([ListCellModel])
        case drama([ListCellModel])
        case crime([ListCellModel])
        case melodrama([ListCellModel])
        case detective([ListCellModel])
        case fantasy([ListCellModel])
    
    var items: [ListCellModel] {
        switch self {
        case .thriller(let items),
                .drama(let items),
                .crime(let items),
                .melodrama(let items),
                .detective(let items),
                .fantasy(let items):
            return items
        }
    }
    
    var count: Int {
        return items.count
    }
}
