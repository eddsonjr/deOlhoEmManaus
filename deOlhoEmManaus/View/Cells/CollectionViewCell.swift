//
//  CollectionViewCell.swift
//  VitrineProdutos
//
//  Created by Edson  Jr on 14/10/2019.
//  Copyright © 2019 Edson  Jr. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: CustomImageView!
    var tableViewSectionNumber = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

}
