//
//  CollectionViewCell.swift
//  VitrineProdutos
//
//  Created by Edson  Jr on 14/10/2019.
//  Copyright © 2019 Edson  Jr. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var textView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupForDarkMode()
    }
    
    func setupForDarkMode(){
        //Ajustando para o dark mode
        self.backgroundColor = DynamicColor(light: .clear, dark: UIColor.darkModeBackgroundColor).resolve()
               
        self.imageView.backgroundColor = DynamicColor(light: .clear, dark: UIColor.darkModeBackgroundColor).resolve()

        self.textView.backgroundColor = DynamicColor(light: .clear, dark: UIColor.darkModeBackgroundColor).resolve()
    }
}


