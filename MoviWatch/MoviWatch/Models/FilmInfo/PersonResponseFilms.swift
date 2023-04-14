//
//  PersonResponseFilms.swift
//  MoviWatch
//
//  Created by Carolina on 28.03.23.
//

import Foundation

struct PersonResponseFilms: Decodable {
    let filmId: Int?
    let nameEn: String?
    let rating: String?
    let description: String?
    let professionKey: String?
}
