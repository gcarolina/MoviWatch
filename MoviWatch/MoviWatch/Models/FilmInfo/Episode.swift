//
//  Episode.swift
//  MoviWatch
//
//  Created by Carolina on 28.03.23.
//

import Foundation

struct Episode: Decodable {
    let seasonNumber: Int?
    let episodeNumber: Int?
    let nameRu: String?
    let nameEn: String?
    let releaseDate: String?
}
