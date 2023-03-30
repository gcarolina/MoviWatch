//
//  NetworkService.swift
//  MoviWatch
//
//  Created by Carolina on 29.03.23.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class NetworkService {
    static func getPhoto(imageURL: String,
                         callback: @escaping (_ image: UIImage?, _ error: Error?) -> Void) {
        
        if let image = CacheManager.shared.imageCache.image(withIdentifier: imageURL) {
            callback(image, nil)
        } else {
            AF.request(imageURL).responseImage { response in
                if case .success(let image) = response.result {
                    CacheManager.shared.imageCache.add(image, withIdentifier: imageURL)
                    callback(image, nil)
                }
            }
        }
    }
}
