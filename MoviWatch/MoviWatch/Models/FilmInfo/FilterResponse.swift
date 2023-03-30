//
//  FilterResponse.swift
//  MoviWatch
//
//  Created by Carolina on 28.03.23.
//

import Foundation

struct FiltersResponse: Decodable {
    let genres: [FilterResponseGenres]?
}
