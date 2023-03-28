//
//  BoxOfficeResponse.swift
//  MoviWatch
//
//  Created by Carolina on 28.03.23.
//

import Foundation

struct BoxOfficeResponse: Decodable {
    let total: Int?
    let items: BoxOffice?
}
