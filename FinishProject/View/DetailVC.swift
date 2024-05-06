//
//  DetailView.swift
//  FinishProject
//
//  Created by Hakan Hardal on 14.04.2024.
//

import UIKit
import Kingfisher

class DetailVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    
    @IBOutlet weak var countLabel: UILabel!
    
    
    @IBOutlet weak var priceCountLabel: UILabel!
    
    var foods : Foods?
    
    var detailVC = DetailViewModel()
    
    
    var price : Int?
    
    var counter = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let f = foods{
            nameLabel.text = f.yemek_adi
            priceLabel.text = "\(f.yemek_fiyat ?? "0$")$"
            priceCountLabel.text = "\(f.yemek_fiyat!)$"
            if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(f.yemek_resim_adi!)"){
                self.imageView.kf.setImage(with: url)
                
            }
        }
    }
    
    func calculateCountPrice(x:Int,y:Int) -> Int{
        let result = x*y
        priceCountLabel.text = "\(result)$"
        return result
    }

    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func plusClick(_ sender: Any) {
        counter += 1
        countLabel.text = "\(counter)"
        
        if let f = foods{
            if let price = f.yemek_fiyat{
                calculateCountPrice(x: counter, y: Int(price)!)

            }
        }
    }
    
    @IBAction func minusClick(_ sender: Any) {
        if counter > 1{
            counter -= 1
                    countLabel.text = "\(counter)"
            if let f = foods?.yemek_fiyat{
                calculateCountPrice(x: counter, y: Int(f)!)
            }
        }
    }
    @IBAction func addToCart(_ sender: Any) {
        if let name = nameLabel.text ,let f = foods{
            detailVC.foodSave(foodName: name, foodImageName: f.yemek_resim_adi!, foodPrice: Int(f.yemek_fiyat!)!  , foodCount: counter , userName: "pusu")
            self.dismiss(animated: true)
           
        }        
    }
    
    
    
}
