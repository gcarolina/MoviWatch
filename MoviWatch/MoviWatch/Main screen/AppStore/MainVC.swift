//
//  MainVC.swift
//  MoviWatch
//
//  Created by Carolina on 29.03.23.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

enum Genres: String, CaseIterable {
    case triller = "триллер"
    case drama = "драма"
    case criminal = "криминал"
    case melodrama = "мелодрама"
    case detective = "детектив"
    case fantasy = "фантастика"
}

class MainVC: UIViewController {
    
    private let sections = Genres.allCases
    private var filmResponse: FilmSearchByFiltersResponse?
    private var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        for index in sections {
            fetchFilms(for: index)
        }
        
        // Create a collection view and add it to the view hierarchy
        let collectionViewFrame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        collectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: UICollectionViewLayout())
        view.addSubview(collectionView)
        
        // Set the data source and delegate
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Register FilmCell XIB file as a cell
        let filmCellNib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(filmCellNib, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)

        // Register CollectionReusableView XIB file as a header view
        let headerNib = UINib(nibName: "CollectionReusableView", bundle: nil)
        collectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionReusableView")

        // create layout
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(170), heightDimension: .absolute(80)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuous
            section.interGroupSpacing = 10
            section.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
            section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
            section.supplementariesFollowContentInsets = false
            return section
        }
        collectionView.collectionViewLayout = layout
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // достаем текущего юзера
        guard let currentUser = Auth.auth().currentUser else { return }
        // сохраняем currentUser
        let user = User(user: currentUser)
        let ref = Database.database().reference(withPath: "users").child(String(user.userID))
        // добавляем наблюдателя для получения значения из Firebase
        ref.observeSingleEvent(of: .value) { [weak self] snapshot in
            print(snapshot)
            let model = UserName(snapshot: snapshot)
            guard let namePerson = model?.name else { return }
            self?.navigationItem.title = "Welcome, \(namePerson)!"
        }
    }
    
    private func fetchFilms(for genre: Genres) {
        var genreId: Int
        switch genre {
        case .triller: genreId = 1
        case .drama: genreId = 2
        case .criminal: genreId = 3
        case .melodrama: genreId = 4
        case .detective: genreId = 5
        case .fantasy: genreId = 6
        }
        fetchFilms(genreId: genreId)
    }

    private func fetchFilms(genreId: Int) {
        guard let url = URL(string: "https://kinopoiskapiunofficial.tech/api/v2.2/films?genres=\(genreId)&order=RATING&type=FILM&ratingFrom=0&ratingTo=10&yearFrom=1000&yearTo=3000&page=1") else { return }
        var request = URLRequest(url: url)
        request.addValue("1bcbd78e-ca5b-4ba6-a840-e482764b60ef", forHTTPHeaderField: "X-API-KEY")
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Unexpected response status code")
                return
            }
            
            guard let data = data else { return }
            
            do {
                self?.filmResponse = try JSONDecoder().decode(FilmSearchByFiltersResponse.self, from: data)
                print(self?.filmResponse ?? "")
            } catch {
                print(error)
            }
            DispatchQueue.main.async {
                self?.collectionView?.reloadData()
            }
            print("Response: \(String(data: data, encoding: .utf8)!)")
        }
        task.resume()
    }
}


extension MainVC: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filmResponse?.items?.count ?? 0
    }
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
       
        let posterUrlPreview = filmResponse?.items?[indexPath.item].posterUrlPreview
        cell.posterUrlPreview = posterUrlPreview
        cell.configure(with: filmResponse?.items?[indexPath.item].nameRu ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionReusableView", for: indexPath) as! CollectionReusableView
            header.setup(sections[indexPath.section].rawValue)
            return header
        default:
            return UICollectionReusableView()
        }
    }
}
