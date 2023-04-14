//
//  VideoResponse.swift
//  MoviWatch
//
//  Created by Carolina on 28.03.23.
//

import Foundation

struct VideoResponse: Decodable {
    let total: Int?
    let items: [VideoResponseItems]?
}
