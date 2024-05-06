//
//  Repository.swift
//  FinishProject
//
//  Created by Hakan Hardal on 14.04.2024.
//

import Foundation
import Alamofire
import RxSwift
class Repository{
    
    var foodList = BehaviorSubject <[Foods]>(value: [Foods]())
    var foodCartList = BehaviorSubject <[cartfoodsModel]>(value: [cartfoodsModel]())
    
    func uploadFoods(){
        
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php",method: .get).response { response in
            guard let data = response.data else { return}
            
            do{
                
                let response = try JSONDecoder().decode(FoodResponse.self, from: data)
                guard let list = response.yemekler else { return}
                self.foodList.onNext(list)
                
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func foodSave(foodName:String,foodImageName:String,foodPrice:Int,foodCount:Int,userName:String){
        print("Foods: \(foodName)-\(foodImageName)-\(foodPrice)-\(foodCount)-\(userName)")
        let parameter : Parameters = ["yemek_adi": foodName,"yemek_resim_adi":foodImageName,"yemek_fiyat":foodPrice,"yemek_siparis_adet":foodCount,"kullanici_adi":userName]
        
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php",method: .post,parameters: parameter).response { response in
            guard let data = response.data else {return}
            
            do{
                let result = try JSONDecoder().decode(CRUDrepo.self, from: data)
                print(String(describing: result))
                
            }catch{
                print(error.localizedDescription)
            }
        }
        
    }
    
    func cartVcFoods(userName: String){
        let parameter : Parameters = ["kullanici_adi": userName]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php",method: .post,parameters: parameter).response { response in
            guard let data = response.data else {return}
            
            do{
                let response = try JSONDecoder().decode(cartFoodResponse.self, from: data)
                guard let list = response.sepet_yemekler else {return}
                self.foodCartList.onNext(list)
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    
    func cartFoodsDelete(id:Int,userName:String){
        let paramater : Parameters = ["sepet_yemek_id":id,"kullanici_adi":userName]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php",method: .post,parameters: paramater).response { response in
            guard let data = response.data else {return}
            
            do{
                _ = try JSONDecoder().decode(CRUDrepo.self, from: data)
                print(CRUDrepo.self)
                self.cartVcFoods(userName: "pusu")
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}
