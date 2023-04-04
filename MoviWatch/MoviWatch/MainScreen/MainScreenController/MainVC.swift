//
//  MainVC.swift
//  MoviWatch
//
//  Created by Carolina on 29.03.23.
//

import UIKit

final class MainVC: UIViewController {
    
    private var mainViewModel: MainViewModelProtocol?
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainViewModel = MainViewModel()
        setUpCollectionView(backgroundRed: 18, backgroundGreen: 18, backgroundBlue: 18)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        mainViewModel?.getUserName(completion: { [weak self] name in
        guard let name = name else { return }
            //вынести в стурктуру (в строки)
        self?.navigationItem.title = "Welcome, \(name)!"
        })
    }
    
    private func setUpCollectionView(backgroundRed: Int, backgroundGreen: Int, backgroundBlue: Int) {
        let collectionViewFrame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        collectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: UICollectionViewLayout())
        collectionView.backgroundColor = UIColor(red: backgroundRed, green: backgroundGreen, blue: backgroundBlue)
        view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let filmCellNib = UINib(nibName: CollectionViewCell.reuseIdentifier, bundle: nil)
        collectionView.register(filmCellNib,
                                forCellWithReuseIdentifier: CollectionViewCell.reuseIdentifier)
        
        let headerNib = UINib(nibName: CollectionReusableView.reuseIdentifier, bundle: nil)
        collectionView.register(headerNib,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: CollectionReusableView.reuseIdentifier)
        
        guard let layout = mainViewModel?.createLayout() else { return }
        collectionView.collectionViewLayout = layout
    }
}

extension MainVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return mainViewModel?.sections.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainViewModel?.sections[section].items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.reuseIdentifier,
                                                      for: indexPath) as! CollectionViewCell
        guard let item = mainViewModel?.sections[indexPath.section].items[indexPath.row] else { return UICollectionViewCell() }
        let collectionCellViewModel = CollectionViewCellViewModel(item: item)
        cell.viewModel = collectionCellViewModel
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: CollectionReusableView.reuseIdentifier,
                                                                         for: indexPath) as! CollectionReusableView
            let title = mainViewModel?.sections[indexPath.section].title ?? ""
            let sectionHeaderViewModel = CollectionReusableViewModel(title: title)
            header.viewModel = sectionHeaderViewModel
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        mainViewModel?.isSelectedFilm(at: indexPath, navigationController: navigationController, storyboardName: "Main")
    }
}
