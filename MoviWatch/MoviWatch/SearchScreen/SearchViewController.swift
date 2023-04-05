//
//  SearchViewController.swift
//  MoviWatch
//
//  Created by Carolina on 5.04.23.
//

import UIKit
import SkeletonView

final class SearchViewController: UIViewController, UITableViewDataSource, UISearchResultsUpdating, UITableViewDelegate {

    @IBOutlet private var tableView: UITableView!
    
    private var searchController: UISearchController!
    private var moviesArray: [FilmSearchResponseFilms] = []
    private var filteredMoviesArray = [FilmSearchResponseFilms]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 150
        tableView.estimatedRowHeight = 150
        tableView.dataSource = self
        tableView.delegate = self
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Enter the title of the desired film"
    
        searchController.searchBar.sizeToFit()
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    internal func updateSearchResults(for searchController: UISearchController) {
        filteredMoviesArray.removeAll()
        guard let searchText = searchController.searchBar.text?.lowercased(), !searchText.isEmpty else {
            filteredMoviesArray = []
            tableView.reloadData()
            return
        }
        
        let urlString = "https://kinopoiskapiunofficial.tech/api/v2.1/films/search-by-keyword?keyword=\(searchText)&page=1"
        print(urlString)
        guard let url = URL(string: urlString) else { return }
        print(url)
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
                let filmResponse = try JSONDecoder().decode(FilmSearchResponse.self, from: data)
                self?.filteredMoviesArray = filmResponse.films ?? []
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } catch {
                print(error)
            }
            print("Response: \(String(data: data, encoding: .utf8)!)")
        }
        task.resume()
    }

    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMoviesArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.cellIdentifier, for: indexPath) as! SearchTableViewCell
        
        cell.filmImagePreview?.isSkeletonable = true
        let gradient = SkeletonGradient(baseColor: .midnightBlue)
        let animation = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topLeftBottomRight, duration: 1.5)
        cell.filmImagePreview?.showAnimatedGradientSkeleton(usingGradient: gradient, animation: animation, transition: .crossDissolve(0.25))
        
        cell.titleLabel?.text = filteredMoviesArray[indexPath.row].nameRu
        cell.yearLabel?.text = filteredMoviesArray[indexPath.row].year
        cell.lengthLabel?.text = filteredMoviesArray[indexPath.row].filmLength
        
        guard let posterUrlPreview = filteredMoviesArray[indexPath.row].posterUrlPreview else { return UITableViewCell() }
        NetworkService.getPhoto(imageURL: posterUrlPreview) { image, error in
            DispatchQueue.main.async {
                if let image = image {
                    cell.filmImagePreview?.image = image
                    cell.setNeedsLayout()
                    cell.filmImagePreview?.hideSkeleton(transition: .crossDissolve(0.25))
                } else {
                    cell.filmImagePreview?.image = nil
                }
            }
        }
        return cell
    }
    
    // MARK: - Table view delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let film = filteredMoviesArray[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "FilmViewController") as? FilmViewController else { return }
        vc.id = film.filmId
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
