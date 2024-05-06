//
//  CollectionViewCell.swift
//  FinishProject
//
//  Created by Hakan Hardal on 14.04.2024.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    func setuplayer(){
    
        contentView.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        contentView.layer.borderWidth = 0.1
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = UIColor.label.cgColor
        contentView.layer.cornerRadius = 5
        contentView.layer.shadowOffset = CGSize(width: -4, height: 4)
        contentView.layer.shadowOpacity = 0.6
        
        
    }
    
    
    
    @IBAction func addClick(_ sender: Any) {
        
    }
}
