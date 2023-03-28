//
//  SeasonResponse.swift
//  MoviWatch
//
//  Created by Carolina on 28.03.23.
//

import Foundation

struct SeasonResponse: Decodable {
    let total: Int?
    let items: Season?
}
