//
//  PersonResponse.swift
//  MoviWatch
//
//  Created by Carolina on 28.03.23.
//

import Foundation

struct PersonResponse: Decodable {
    let personId: Int?
    let webUrl: String?
    let nameRu: String?
    let sex: String?
    let posterUrl: String?
    let birthday: String?
    let death: String?
    let age: Int?
    let hasAwards: Int?
    let profession: String?
    let films: PersonResponseFilms?
}
