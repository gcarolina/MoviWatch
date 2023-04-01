//
//  CacheManager.swift
//  MoviWatch
//
//  Created by Carolina on 29.03.23.
//

import Foundation
import AlamofireImage

final class CacheManager {
    private init() {}
    
    static let shared = CacheManager()
    
    let imageCache = AutoPurgingImageCache(
        memoryCapacity: 100_000_000,
        preferredMemoryUsageAfterPurge: 60_000_000
    )
}
