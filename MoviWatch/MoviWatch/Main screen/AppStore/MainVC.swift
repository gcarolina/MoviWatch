//
//  MainVC.swift
//  MoviWatch
//
//  Created by Carolina on 29.03.23.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

final class MainVC: UIViewController {
    
    private let sections = FilmsForGenres.shared.pageData
    private var filmResponse: FilmSearchByFiltersResponse?
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let collectionViewFrame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        collectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: UICollectionViewLayout())
        collectionView.backgroundColor = UIColor(red: 18, green: 18, blue: 18)
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let filmCellNib = UINib(nibName: CollectionViewCell.reuseIdentifier, bundle: nil)
        collectionView.register(filmCellNib, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
        
        let headerNib = UINib(nibName: CollectionReusableView.reuseIdentifier, bundle: nil)
        collectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionReusableView.reuseIdentifier)
        
        // create layout
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.75), heightDimension: .fractionalHeight(1)))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.3)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            section.interGroupSpacing = 10
            section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
            section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
            section.supplementariesFollowContentInsets = false
            return section
        }
        collectionView.collectionViewLayout = layout
    }
    
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let currentUser = Auth.auth().currentUser else { return }
        let user = User(user: currentUser)
        let ref = Database.database().reference(withPath: "users").child(String(user.userID))
        ref.observeSingleEvent(of: .value) { [weak self] snapshot in
            print(snapshot)
            let model = UserName(snapshot: snapshot)
            guard let namePerson = model?.name else { return }
            self?.navigationItem.title = "Welcome, \(namePerson)!"
        }
    }
}

extension MainVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case .thriller(let items):
            let cell = dequeueReusableCell(for: indexPath, in: collectionView, items: items)
            return cell
        case .drama(let items):
            let cell = dequeueReusableCell(for: indexPath, in: collectionView, items: items)
            return cell
        case .crime(let items):
            let cell = dequeueReusableCell(for: indexPath, in: collectionView, items: items)
            return cell
        case .melodrama(let items):
            let cell = dequeueReusableCell(for: indexPath, in: collectionView, items: items)
            return cell
        case .detective(let items):
            let cell = dequeueReusableCell(for: indexPath, in: collectionView, items: items)
            return cell
        case .fantasy(let items):
            let cell = dequeueReusableCell(for: indexPath, in: collectionView, items: items)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionReusableView", for: indexPath) as! CollectionReusableView
            header.setup(sections[indexPath.section].title)//.rawValue)
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
    private func dequeueReusableCell(for indexPath: IndexPath, in collectionView: UICollectionView, items: [ListCellModel]) -> CollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier, for: indexPath) as? CollectionViewCell else {
            fatalError("Unable to dequeue cell with identifier \(CollectionViewCell.reuseIdentifier)")
        }
        cell.setup(items[indexPath.row])
        return cell
    }
}
