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

enum NetworkError: Error {
    case invalidUrl
    case invalidResponse
    case invalidData
}

final class NetworkService {
    static func getPhoto(imageURL: String, callback: @escaping (_ image: UIImage?, _ error: Error?) -> Void) {
        if let image = CacheManager.shared.imageCache.image(withIdentifier: imageURL) {
            callback(image, nil)
        } else {
            AF.request(imageURL).responseImage { response in
                if case .success(let image) = response.result {
                    CacheManager.shared.imageCache.add(image, withIdentifier: imageURL)
                    callback(image, nil)
                } else {
                    callback(nil, response.error)
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
    
    static func fetchPhotos(kinopoiskId: Int, callback: @escaping (_ imagesArray: [UIImage]?, _ error: Error?) -> Void) {
        guard let url = URL(string: "https://kinopoiskapiunofficial.tech/api/v2.2/films/\(kinopoiskId)/images?type=STILL&page=1") else {
            return
        }
        var request = URLRequest(url: url)
        request.addValue("1bcbd78e-ca5b-4ba6-a840-e482764b60ef", forHTTPHeaderField: "X-API-KEY")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                callback(nil, error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                callback(nil, NetworkError.invalidResponse)
                return
            }
            
            guard let data = data else {
                callback(nil, NetworkError.invalidData)
                return
            }
            
            do {
                let filmResponse = try JSONDecoder().decode(ImageResponse.self, from: data)
                var imagesArray = [UIImage]()
                let dispatchGroup = DispatchGroup()
                for imageResponseItem in filmResponse.items ?? [] {
                    guard let imageURLString = imageResponseItem.imageUrl else {
                        continue
                    }
                    dispatchGroup.enter()
                    getPhoto(imageURL: imageURLString) { image, error in
                        defer { dispatchGroup.leave() }
                        if let error = error {
                            print("Failed to load image with URL: \(imageURLString). Error: \(error.localizedDescription)")
                            return
                        }
                        guard let image = image else { return }
                        imagesArray.append(image)
                    }
                }
                dispatchGroup.notify(queue: DispatchQueue.main) {
                    callback(imagesArray, nil)
                }
            } catch {
                callback(nil, error)
            }
        }.resume()
    }
}
