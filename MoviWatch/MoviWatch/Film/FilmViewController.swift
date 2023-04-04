//
//  FilmViewController.swift
//  MoviWatch
//
//  Created by Carolina on 2.04.23.
//

import UIKit
import SkeletonView

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
        fetchPhoto(kinopoiskId: id)
    }
    
    override func viewDidLayoutSubviews() {
        setUpUI()
    }
    
    // MARK: - @IBAction
    @IBAction private func openBrowser(_ sender: UIButton) {
        if let url = URL(string: film?.webUrl ?? "") {
            UIApplication.shared.open(url)
        }
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
    
    func loadFilmData(kinopoiskId: Int) {
        filmViewModel?.fetchFilm(kinopoiskId: kinopoiskId) { [weak self] result in
            switch result {
            case .success(let film):
                DispatchQueue.main.async {
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
    
    private func fetchPhoto(kinopoiskId: Int) {
        guard let url = URL(string: "https://kinopoiskapiunofficial.tech/api/v2.2/films/\(kinopoiskId)/images?type=STILL&page=1") else { return }
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
                let filmResponse = try JSONDecoder().decode(ImageResponse.self, from: data)
                self?.image = filmResponse
            } catch {
                print(error)
            }
            print("Response: \(String(data: data, encoding: .utf8)!)")
            DispatchQueue.main.async {
                self?.getPhotos(imageResponseItems: self?.image?.items)
            }
        }
        task.resume()
    }
    
    private func getPhotos(imageResponseItems: [ImageResponseItems]?) {
        guard let imageResponseItems = imageResponseItems else { return }
        
        var imagesArray = [UIImage]()
        let dispatchGroup = DispatchGroup()
        for imageResponseItem in imageResponseItems {
            guard let imageURLString = imageResponseItem.imageUrl else { continue }
            
            dispatchGroup.enter()
            NetworkService.getPhoto(imageURL: imageURLString) { image, error in
                defer { dispatchGroup.leave() }
                if let error = error {
                    print("Failed to load image with URL: \(imageURLString). Error: \(error.localizedDescription)")
                    return
                }
                guard let image = image else { return }
                imagesArray.append(image)
            }
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main) { [weak self] in
            self?.filmImage.animationImages = imagesArray
            self?.filmImage.animationDuration = 35
            self?.filmImage.animationRepeatCount = 0
            self?.filmImage.startAnimating()
            self?.activityIndicator.stopAnimating()
        }
    }
    
    private func getPhoto(imageURL: String?) {
        guard let imageURL = imageURL else { return }
        
        NetworkService.getPhoto(imageURL: imageURL) { [weak self] image, error in
            self?.filmImage.image = image
        }
    }
}
