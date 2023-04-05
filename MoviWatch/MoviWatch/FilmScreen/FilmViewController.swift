//
//  FilmViewController.swift
//  MoviWatch
//
//  Created by Carolina on 2.04.23.
//

import UIKit

final class FilmViewController: UIViewController {
    private var filmViewModel: FilmViewModelProtocol?
    
    // MARK: - @IBOutlets
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var watchNowButton: UIButton!
    @IBOutlet private weak var filmImage: UIImageView!
    @IBOutlet private weak var filmName: UILabel!
    @IBOutlet private weak var filmGenre: UILabel!
    @IBOutlet private weak var filmYear: UILabel!
    @IBOutlet private weak var filmLength: UILabel!
    @IBOutlet private weak var filmDescription: UILabel!
    private var film: Film? = nil
    private var image: ImageResponse? = nil
    var id: Int?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        filmViewModel = FilmViewModel()
        createBarButtonItems()
        
        guard let id = id else { return }
        loadFilmData(kinopoiskId: id)
        loadFilmImages(kinopoiskId: id)
    }
    
    override func viewDidLayoutSubviews() {
        setUpUI()
    }
    // MARK: - @IBAction
    @IBAction private func openBrowser(_ sender: UIButton) {
        guard let url = URL(string: film?.webUrl ?? "") else { return }
        print(url)
        UIApplication.shared.open(url)
    }
    // MARK: - Private functions
    private func setUpUI() {
        filmGenre.setCornerRadius()
        filmYear.setCornerRadius()
        filmLength.setCornerRadius()
        watchNowButton.setCornerRadius()
        watchNowButton.setButtonStyle(shadowOpacity: 0.7)
        watchNowButton.applyButtonStyle()
        filmDescription.setStyle(shadowOpacity: 0.7)
        filmImage.layer.cornerRadius = 10
    }
    
    private func createButton(imageName: String, tintColor: UIColor, backgroundColor: UIColor, target: Any?, action: Selector?) -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: imageName), for: .normal)
        button.tintColor = tintColor
        button.addTarget(target, action: #selector(backButtonTapped), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.layer.cornerRadius = 20
        button.backgroundColor = backgroundColor
        return button
    }
    
    private func createBarButtonItems() {
        let backButton = createButton(imageName: "chevron.backward", tintColor:  UIColor(red: 179, green: 40, blue: 85), backgroundColor: UIColor(red: 33, green: 33, blue: 33), target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        let favoriteButton = createButton(imageName: "bookmark", tintColor:  UIColor(red: 179, green: 40, blue: 85), backgroundColor: UIColor(red: 33, green: 33, blue: 33), target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: favoriteButton)
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func loadFilmData(kinopoiskId: Int) {
        filmViewModel?.fetchFilm(kinopoiskId: kinopoiskId) { [weak self] result in
            switch result {
            case .success(let film):
                DispatchQueue.main.async {
                    self?.film = film
                    self?.filmName.text = film.nameRu
                    self?.filmGenre.text = film.genres?[0].genre
                    self?.filmYear.text = film.year?.description
                    self?.filmLength.text = film.filmLength?.description
                    self?.filmDescription.text = film.description
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func loadFilmImages(kinopoiskId: Int) {
        filmViewModel?.fetchPhotos(kinopoiskId: kinopoiskId) { [weak self] imagesArray, error in
            if let error = error {
                print(error.localizedDescription)
            }
            self?.filmImage.animationImages = imagesArray
            self?.filmImage.animationDuration = 35
            self?.filmImage.animationRepeatCount = 0
            self?.filmImage.startAnimating()
            self?.activityIndicator.stopAnimating()
        }
    }
}
