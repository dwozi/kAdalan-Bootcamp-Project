//
//  cartTableViewCell.swift
//  FinishProject
//
//  Created by Hakan Hardal on 18.04.2024.
//

import UIKit

protocol cellProtocol{
    func deleteFood(indexPath:IndexPath)
}

class cartTableViewCell: UITableViewCell {

    
    @IBOutlet weak var contentContainerView: UIView!
    
    
    @IBOutlet weak var cartImageview: UIImageView!
    
    @IBOutlet weak var cartNameLabel: UILabel!
    
    @IBOutlet weak var cartPrice: UILabel!
    
    @IBOutlet weak var orderTotal: UILabel!
    
    @IBOutlet weak var orderTotalPrice: UILabel!
    
    var cellProtocol : cellProtocol?
    var indexPath : IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentContainerView.layoutMargins = UIEdgeInsets(top: 50, left: 0, bottom: 50, right: 0)
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       

    }

    
    func setuplayer(){
    
        contentView.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        contentView.layer.borderWidth = 2.5
        contentView.layer.cornerRadius = 5

        contentView.clipsToBounds = true
        contentView.backgroundColor = .white
        
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        cellProtocol?.deleteFood(indexPath: indexPath!)
        print("Butona Tıklandı")
        
    }
    
}
