//
//  MainScreenCViewController.swift
//  MoviWatch
//
//  Created by Carolina on 16.03.23.
//

import UIKit
import Firebase

private let reuseIdentifier = "Cell"

class MainScreenCViewController: UICollectionViewController {

    private var user: User!
    private var ref: DatabaseReference!
    private var userName: UserName?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // достаем текущего юзера
        guard let currentUser = Auth.auth().currentUser else { return }
        // сохраняем currentUser
        user = User(user: currentUser)
        ref = Database.database().reference(withPath: "users").child(String(user.userID))//.child("name")
        
        // добавляем наблюдателя для получения значения из Firebase
        ref.observeSingleEvent(of: .value) { [weak self] snapshot in
            print(snapshot)
            print(snapshot.value)
            let dic = snapshot.value as? [String:Any]
            // достаем значение поля "name"
            let name = dic?["name"] as? String
            print(name)
           
            // устанавливаем значение поля "name" как заголовок навигации
//            self?.navigationItem.title = name
            
            self?.navigationController?.navigationItem.titleView?.backgroundColor = .red
            
            self?.navigationController?.navigationItem.title = name
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
