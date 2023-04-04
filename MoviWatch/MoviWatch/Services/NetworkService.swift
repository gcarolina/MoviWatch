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

final class NetworkService {
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
    
    static func fetchFilm(kinopoiskId: Int, completion: @escaping (Result<Film, Error>) -> Void) {
        guard let url = URL(string: "https://kinopoiskapiunofficial.tech/api/v2.2/films/\(kinopoiskId)") else {
            completion(.failure(NetworkError.invalidUrl))
            return
        }
        var request = URLRequest(url: url)
        request.addValue("1bcbd78e-ca5b-4ba6-a840-e482764b60ef", forHTTPHeaderField: "X-API-KEY")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.invalidData))
                return
            }
            
            do {
                let filmResponse = try JSONDecoder().decode(Film.self, from: data)
                completion(.success(filmResponse))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    enum NetworkError: Error {
        case invalidUrl
        case invalidResponse
        case invalidData
    }
}
