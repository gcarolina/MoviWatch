//
//  SearchViewModel.swift
//  MoviWatch
//
//  Created by Carolina on 5.04.23.
//

import UIKit

class SearchViewModel {
    
    private var moviesArray: [FilmSearchResponseFilms] = []
    private var filteredMoviesArray = [FilmSearchResponseFilms]()
    
    func searchMovies(with text: String, completion: @escaping ([FilmSearchResponseFilms]) -> Void) {
        let urlString = "https://kinopoiskapiunofficial.tech/api/v2.1/films/search-by-keyword?keyword=\(text)&page=1"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.addValue("1bcbd78e-ca5b-4ba6-a840-e482764b60ef", forHTTPHeaderField: "X-API-KEY")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Unexpected response status code")
                return
            }
            guard let data = data else { return }
            do {
                let filmResponse = try JSONDecoder().decode(FilmSearchResponse.self, from: data)
                self.filteredMoviesArray = filmResponse.films ?? []
                completion(self.filteredMoviesArray)
            } catch {
                print(error)
            }
            print("Response: \(String(data: data, encoding: .utf8)!)")
        }
        task.resume()
    }
    
    func getMovie(at index: Int) -> FilmSearchResponseFilms {
        return filteredMoviesArray[index]
    }
    
    func getNumberOfMovies() -> Int {
        return filteredMoviesArray.count
    }
    
    func showFilmDetails(for film: FilmSearchResponseFilms, from viewController: UIViewController) {
        viewController.pushSearchViewController(withIdentifier: "FilmViewController", viewControllerType: FilmViewController.self, storyboardName: "Main") { vc in
            vc.id = film.filmId
        }
    }
}
