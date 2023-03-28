//
//  MainScreenViewController.swift
//  MoviWatch
//
//  Created by Carolina on 17.03.23.
//

import UIKit
import Firebase

class MainScreenViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    private var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // связываем делегат и источник данных с UICollectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "MainCVCell", bundle: .main), forCellWithReuseIdentifier: "MainCVCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let sizeWH = (UIScreen.main.bounds.height / 4)

        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.scrollDirection = .horizontal // set scroll direction to horizontal
        collectionViewFlowLayout.itemSize = CGSize(width: sizeWH, height: sizeWH)
        collectionView.collectionViewLayout = collectionViewFlowLayout
        
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
    

    // реализация метода UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // возвращает ячейку для конкретной позиции в UICollectionView
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCVCell", for: indexPath) as! MainCVCell
        return cell
    }
    
    // реализация метода UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // обработка нажатия на ячейку
        // ...
    }
}
