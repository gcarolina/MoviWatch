//
//  FilmViewModel.swift
//  MoviWatch
//
//  Created by Carolina on 4.04.23.
//

import UIKit

protocol FilmViewModelProtocol {
    func fetchFilm(kinopoiskId: Int, completion: @escaping (Result<Film, Error>) -> Void)
    func fetchPhotos(kinopoiskId: Int, callback: @escaping (_ imagesArray: [UIImage]?, _ error: Error?) -> Void)
}

class FilmViewModel: FilmViewModelProtocol {
    func fetchFilm(kinopoiskId: Int, completion: @escaping (Result<Film, Error>) -> Void) {
        NetworkService.fetchFilm(kinopoiskId: kinopoiskId, completion: completion)
    }
    func fetchPhotos(kinopoiskId: Int, callback: @escaping (_ imagesArray: [UIImage]?, _ error: Error?) -> Void) {
        NetworkService.fetchPhotos(kinopoiskId: kinopoiskId) { imagesArray, error in
            if let error = error {
                callback(nil, error)
                return
            }
            callback(imagesArray, nil)
        }
    }
}
