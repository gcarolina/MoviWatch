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
    
    @IBOutlet weak var labelNme: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // связываем делегат и источник данных с UICollectionView
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // регистрируем ячейки для использования в UICollectionView
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // отключение жеста возврата по свайпу
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        self.navigationItem.hidesBackButton = true
        
        // достаем текущего юзера
        guard let currentUser = Auth.auth().currentUser else { return }
        // сохраняем currentUser
        let user = User(user: currentUser)
        let ref = Database.database().reference(withPath: "users").child(String(user.userID))
        // добавляем наблюдателя для получения значения из Firebase
        ref.observeSingleEvent(of: .value) { [weak self] snapshot in
            print(snapshot)
            let model = UserName(snapshot: snapshot)
            self?.navigationItem.title = model?.name
            self?.labelNme.text = model?.name
        }
    }
    
    
    
    // реализация метода UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // возвращает ячейку для конкретной позиции в UICollectionView
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        // конфигурируем ячейку
        // ...
        return cell
    }
    
    // реализация метода UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // обработка нажатия на ячейку
        // ...
    }
}
