//
//  CartViewModel.swift
//  FinishProject
//
//  Created by Hakan Hardal on 14.04.2024.
//

import Foundation
import RxSwift




class CartViewModel{
    var repo = Repository()
     
    var foodCartList = BehaviorSubject<[cartfoodsModel]>(value: [cartfoodsModel]())
    
    init(){
        repo.foodCartList = foodCartList
        cartVcFoods(userName: "pusu")
    }
    
    func cartVcFoods(userName: String){
        repo.cartVcFoods(userName: userName)
    }
    
    func cartFoodsDelete(id:Int,userName:String){
        repo.cartFoodsDelete(id: id, userName: userName)
    }
    
}
