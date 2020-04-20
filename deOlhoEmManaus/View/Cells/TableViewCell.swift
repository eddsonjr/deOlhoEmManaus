//
//  TableViewCell.swift
//  VitrineProdutos
//
//  Created by Edson  Jr on 14/10/2019.
//  Copyright © 2019 Edson  Jr. All rights reserved.
//
//
//
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var sectionNameLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupForDarkMode()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func setupForDarkMode(){
        self.collectionView.backgroundColor = DynamicColor(light: .clear, dark: UIColor.darkModeBackgroundColor).resolve()
    }

}


extension TableViewCell {
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        print("CollectionViewTag: \(collectionView.tag)")
        collectionView.reloadData()
    }
    
    
}
