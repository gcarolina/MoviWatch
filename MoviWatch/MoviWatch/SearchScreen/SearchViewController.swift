//
//  SearchViewController.swift
//  MoviWatch
//
//  Created by Carolina on 5.04.23.
//

import UIKit
import SkeletonView

final class SearchViewController: UIViewController, UISearchResultsUpdating, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet private var tableView: UITableView!
    private var searchController: UISearchController!
    private var viewModel = SearchViewModel()
    
    private var moviesArray: [FilmSearchResponseFilms] = []
    private var filteredMoviesArray = [FilmSearchResponseFilms]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView(tableView: tableView, height: 150)
        setUpSearchController(textForPlaceholder:  "Enter the title of the desired film")
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased(), !searchText.isEmpty else {
            viewModel.searchMovies(with: "") { [weak self] movies in
                self?.filteredMoviesArray = movies
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
            return
        }
        viewModel.searchMovies(with: searchText) { [weak self] movies in
            self?.filteredMoviesArray = movies
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfMovies()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.cellIdentifier, for: indexPath) as! SearchTableViewCell
        let movie = viewModel.getMovie(at: indexPath.row)
        cell.configure(with: movie)
        return cell
    }
    
    // MARK: - Table view delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let film = filteredMoviesArray[indexPath.row]
        viewModel.showFilmDetails(for: film, from: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Private functions
    private func setUpTableView(tableView: UITableView, height: CGFloat) {
        tableView.rowHeight = height
        tableView.estimatedRowHeight = height
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setUpSearchController(textForPlaceholder: String) {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = textForPlaceholder
        
        searchController.searchBar.sizeToFit()
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
}
