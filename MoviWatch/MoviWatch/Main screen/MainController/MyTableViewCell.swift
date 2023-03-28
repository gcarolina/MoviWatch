//
//  MyTableViewCell.swift
//  MoviWatch
//
//  Created by Carolina on 24.03.23.
//

import UIKit

class MyTableViewCell: UITableViewCell, UICollectionViewDataSource {
   
    var collectionView: UICollectionView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: self.contentView.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCollectionViewCell")
        collectionView.backgroundColor = UIColor(red: 18, green: 18, blue: 18)
        
        self.contentView.addSubview(collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath)
        cell.backgroundColor = UIColor(red: 179, green: 40, blue: 85)
        
        return cell
    }
}
