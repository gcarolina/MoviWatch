//
//  FilmViewController.swift
//  MoviWatch
//
//  Created by Carolina on 2.04.23.
//

import UIKit

class FilmViewController: UIViewController {
    
    var film: Film? = nil
    var id: Int?
    
    @IBOutlet weak var filmDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFilm(kinopoiskId: id ?? 0)
    }
    
    private func fetchFilm(kinopoiskId: Int) {
        guard let url = URL(string: "https://kinopoiskapiunofficial.tech/api/v2.2/films/\(kinopoiskId)") else { return }
        var request = URLRequest(url: url)
        request.addValue("1bcbd78e-ca5b-4ba6-a840-e482764b60ef", forHTTPHeaderField: "X-API-KEY")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            
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
                let filmResponse = try JSONDecoder().decode(Film.self, from: data)
                self?.film = filmResponse
            } catch {
                print(error)
            }
            print("Response: \(String(data: data, encoding: .utf8)!)")
            DispatchQueue.main.async {
                self?.filmDescription.text = self?.film?.description
            }
        }
        task.resume()
    }
}
