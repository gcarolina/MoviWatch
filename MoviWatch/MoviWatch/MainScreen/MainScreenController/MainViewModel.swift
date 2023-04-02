//
//  MainViewModel.swift
//  MoviWatch
//
//  Created by Carolina on 2.04.23.
//

import FirebaseDatabase
import FirebaseAuth
import UIKit

protocol MainViewModelProtocol {
    var sections: [Section] { get }
    func createLayout() -> UICollectionViewCompositionalLayout
    func getUserName(completion: @escaping (String?) -> Void)
    func didSelectFilm(at indexPath: IndexPath, navigationController: UINavigationController?, storyboardName: String)
}

final class MainViewModel: MainViewModelProtocol {
    
    private let filmsForGenres = FilmsForGenres.shared
    var sections: [Section] {
        return [
            Section(title: TitleForSection.thriller.rawValue, items: filmsForGenres.pageData[0].items),
            Section(title: TitleForSection.drama.rawValue, items: filmsForGenres.pageData[1].items),
            Section(title: TitleForSection.crime.rawValue, items: filmsForGenres.pageData[2].items),
            Section(title: TitleForSection.melodrama.rawValue, items: filmsForGenres.pageData[3].items),
            Section(title: TitleForSection.detective.rawValue, items: filmsForGenres.pageData[4].items),
            Section(title: TitleForSection.fantasy.rawValue, items: filmsForGenres.pageData[5].items)
        ]
    }
    
    func createLayout() -> UICollectionViewCompositionalLayout {
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
    
    func getUserName(completion: @escaping (String?) -> Void) {
        guard let currentUser = Auth.auth().currentUser else {
            completion(nil)
            return
        }
        let user = User(user: currentUser)
        let ref = Database.database().reference(withPath: "users").child(String(user.userID))
        ref.observeSingleEvent(of: .value) { snapshot in
            let model = UserName(snapshot: snapshot)
            let namePerson = model?.name
            DispatchQueue.main.async {
                completion(namePerson)
            }
        }
    }
    
    func film(at indexPath: IndexPath) -> ListCellModel {
        return filmsForGenres.pageData[indexPath.section].items[indexPath.row]
    }
    
    func didSelectFilm(at indexPath: IndexPath, navigationController: UINavigationController?, storyboardName: String) {
        let kinopoiskId = film(at: indexPath).kinopoiskId
        pushViewController(withIdentifier: "FilmViewController", viewControllerType: FilmViewController.self, storyboardName: storyboardName, navigationController: navigationController, configureViewController: { viewController in
            viewController.id = kinopoiskId
        })
    }
        
    private func pushViewController<T: UIViewController>(withIdentifier identifier: String, viewControllerType: T.Type, storyboardName: String, navigationController: UINavigationController?, configureViewController: ((T) -> Void)?) {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? T {
            configureViewController?(viewController)
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

