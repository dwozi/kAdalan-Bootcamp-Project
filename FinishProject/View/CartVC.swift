//
//  CartView.swift
//  FinishProject
//
//  Created by Hakan Hardal on 14.04.2024.
//

import UIKit
import Foundation

class CartVC: UIViewController{


    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var orderPrice: UILabel!
    
    
    
    
    
    let cellSpacingHeight: CGFloat = 0.01
    
    var foods : cartfoodsModel?
    
    
    var cartVM = CartViewModel()
    
    var foodCartList = [cartfoodsModel]()
    
    var result = 0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableViewDesign()
        
        _ = cartVM.foodCartList.subscribe(onNext: { list in
            self.foodCartList = list
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.totalPriceCalculate()

            }
        })
        
        let control = UINavigationBarAppearance()
        control.configureWithDefaultBackground()
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.compactAppearance = control
        navigationController?.navigationBar.compactScrollEdgeAppearance = control
        navigationController?.navigationBar.scrollEdgeAppearance = control
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cartVM.cartVcFoods(userName: "pusu")
        print(foodCartList.count)
        
    }
    
    func tableViewDesign(){
        tableView.separatorStyle = .none

    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
          let headerView = UIView()
          headerView.backgroundColor = UIColor.clear
          return headerView
      }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
       }
    @IBAction func cartOrderClick(_ sender: Any) {
        
    }
    
    public func totalPriceCalculate(){
        
        let total = foodCartList.reduce(0.0) { currentTotal, item in
            
            if let priceString = item.yemek_fiyat,  // Eğer `yemek_fiyat` boş değilse
               
                let price = Double(priceString),
                let priceCountString = item.yemek_siparis_adet,
                let priceCount = Double(priceCountString)  {  // `Double`'a çevirmeyi deneyin
                
                
                return currentTotal + (price * priceCount) // Dönüşüm başarılı olursa ekleyin
            }
            return currentTotal  // Boş veya hatalıysa eklemeyin
        }
        orderPrice.text = "\(String(format: "%.2f", total)) $"
        
        print("Ekran arası geçiliyor")

    }

}


extension CartVC : UITableViewDelegate, UITableViewDataSource, cellProtocol{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodCartList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! cartTableViewCell
        let foods = foodCartList[indexPath.row]
        cell.setuplayer()
        cell.cartNameLabel.text = foods.yemek_adi
        cell.cartPrice.text = "\(foods.yemek_fiyat!)$"
        cell.orderTotal.text = foods.yemek_siparis_adet
        
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(foods.yemek_resim_adi!)"){
            cell.cartImageview.kf.setImage(with: url)
        }
        
        if let price = Int(foods.yemek_fiyat ?? "error") , let orderTotal = Int(foods.yemek_siparis_adet ?? "error"){
            result = price*orderTotal
            cell.orderTotalPrice.text = "\(result)$"
        }
        
        cell.indexPath = indexPath
        cell.cellProtocol = self
        
        return cell
    }
    

    func deleteFood(indexPath: IndexPath) {
        
        let food = foodCartList[indexPath.row]
        let alertController = UIAlertController(title: "Eminmisiniz?", message: "\(food.yemek_adi!) Silinecek", preferredStyle: .alert)
        let delete = UIAlertAction(title: "Sil", style: .destructive) { action in
            self.cartVM.cartFoodsDelete(id: Int(food.sepet_yemek_id!)!, userName: "pusu")
        }
        let ok = UIAlertAction(title: "İptal", style: .cancel)
       
        alertController.addAction(ok)

        alertController.addAction(delete)
        self.present(alertController, animated: true)
    }
    
    
    
}
