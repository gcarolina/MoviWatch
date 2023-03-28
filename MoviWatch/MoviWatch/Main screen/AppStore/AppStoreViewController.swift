//  AppStoreViewController.swift
//  MoviWatch
//  Created by Carolina on 27.03.23.

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Alamofire
import AlamofireImage
import SwiftyJSON

class AppStoreViewController: UIViewController {
    
    enum Section: Int, CaseIterable {
        case banner
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil
    var collectionView: UICollectionView! = nil
    private var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureDataSource()
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
    
    private func createLayout() -> UICollectionViewLayout {
        let sectionProvider: UICollectionViewCompositionalLayoutSectionProvider = { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            guard let sectionKind = Section(rawValue: sectionIndex) else { return nil }
            let section = self.layoutSection(for: sectionKind, layoutEnvironment: layoutEnvironment)
            return section
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 16.0
        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: config)
        return layout
    }
    
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = UIColor(red: 18, green: 18, blue: 18)
        let nib = UINib(nibName: BannerCell.reuseIdentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: BannerCell.reuseIdentifier)
        view.addSubview(collectionView)
    }
    
    private lazy var bannerRange: ClosedRange<Int> = 1...banners.count
    private var banners: [Banner] = Banner.testData()
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
            
            if self.bannerRange ~= identifier {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCell.reuseIdentifier, for: indexPath) as? BannerCell else { fatalError("Cannot create the cell") }
                let banner = self.banners[indexPath.row]
                cell.configure(with: banner.title, subtitle: banner.subtitle, image: UIImage(named: banner.imageName))
                return cell
            }
            fatalError("Cannot create the cell")
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        let sections: [Section] = [.banner]
        snapshot.appendSections([sections[0]])
        snapshot.appendItems(Array(bannerRange))
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func layoutSection(for section: Section, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        switch section {
        case .banner:
            return bannerSection()
        }
    }
    
    private func bannerSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = .init(top: 8.0, leading: 8.0, bottom: 8.0, trailing: 8.0)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        return section
    }
}
    
//    private func fetchFilms() {
//        guard let url = URL(string: "https://kinopoiskapiunofficial.tech/api/v2.2/films?genres=13&order=RATING&type=FILM&ratingFrom=0&ratingTo=10&yearFrom=1000&yearTo=3000&page=1") else { return }
//        var request = URLRequest(url: url)
//        request.addValue("1bcbd78e-ca5b-4ba6-a840-e482764b60ef", forHTTPHeaderField: "X-API-KEY")
//
//        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
//
//            if let error = error {
//                print("Error: \(error.localizedDescription)")
//                return
//            }
//
//            guard let httpResponse = response as? HTTPURLResponse,
//                  (200...299).contains(httpResponse.statusCode) else {
//                print("Unexpected response status code")
//                return
//            }
//
//            guard let data = data else {
//                print("No data received")
//                return
//            }
//
//            do {
//                self?.films = try JSONDecoder().decode([FilmSearchByFiltersResponse].self, from: data)
//                print(self?.films)
//            } catch {
//                print(error)
//            }
//            DispatchQueue.main.async {
//                self?.collectionView.reloadData()
//            }
//            print("Response: \(String(data: data, encoding: .utf8)!)")
//        }
//        task.resume()
//    }

