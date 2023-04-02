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
        setCollectionView(backgroundRed: 18, backgroundGreen: 18, backgroundBlue: 18)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getUserName()
    }
    
    private func getUserName() {
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
    
    private func setCollectionView(backgroundRed: Int, backgroundGreen: Int, backgroundBlue: Int) {
        let collectionViewFrame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        collectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: UICollectionViewLayout())
        collectionView.backgroundColor = UIColor(red: backgroundRed, green: backgroundGreen, blue: backgroundBlue)
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let filmCellNib = UINib(nibName: CollectionViewCell.reuseIdentifier, bundle: nil)
        collectionView.register(filmCellNib, forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
        
        let headerNib = UINib(nibName: CollectionReusableView.reuseIdentifier, bundle: nil)
        collectionView.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionReusableView.reuseIdentifier)
        
        let layout = createLayout()
        collectionView.collectionViewLayout = layout
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.75), heightDimension: .fractionalHeight(1)))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.3)), subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            section.interGroupSpacing = 7
            section.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
            section.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
            section.supplementariesFollowContentInsets = false
            return section
        }
        return layout
    }
        
    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
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
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionReusableView.reuseIdentifier , for: indexPath) as! CollectionReusableView
            let viewModel = CollectionReusableViewModel(title: sections[indexPath.section].title)
            header.viewModel = viewModel
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
    private func dequeueReusableCell(for indexPath: IndexPath, in collectionView: UICollectionView, items: [ListCellModel]) -> CollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier, for: indexPath) as? CollectionViewCell else {
            fatalError("Unable to dequeue cell with identifier \(CollectionViewCell.reuseIdentifier)")
        }
        let viewModel = CollectionViewCellViewModel(item: items[indexPath.row])
        cell.viewModel = viewModel
        return cell
    }
}
