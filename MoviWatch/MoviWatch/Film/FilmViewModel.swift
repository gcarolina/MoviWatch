//
//  FilmViewModel.swift
//  MoviWatch
//
//  Created by Carolina on 4.04.23.
//

import Foundation

protocol FilmViewModelProtocol {
    func fetchFilm(kinopoiskId: Int, completion: @escaping (Result<Film, Error>) -> Void)
}


class FilmViewModel: FilmViewModelProtocol {
    func fetchFilm(kinopoiskId: Int, completion: @escaping (Result<Film, Error>) -> Void) {
        NetworkService.fetchFilm(kinopoiskId: kinopoiskId, completion: completion)
    }
}
