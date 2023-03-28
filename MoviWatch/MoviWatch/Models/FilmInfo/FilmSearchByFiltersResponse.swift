//
//  FilmSearchByFiltersResponse.swift
//  MoviWatch
//
//  Created by Carolina on 28.03.23.
//

import Foundation

struct FilmSearchByFiltersResponse: Decodable {
    let total: Int?
    let totalPages: Int?
    let items: FilmSearchByFiltersResponseItems?
}
