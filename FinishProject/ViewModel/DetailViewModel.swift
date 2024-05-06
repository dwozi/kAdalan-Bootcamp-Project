//
//  DetailViewModel.swift
//  FinishProject
//
//  Created by Hakan Hardal on 14.04.2024.
//

import Foundation

class DetailViewModel{
    
    var foodRepo = Repository()
    
    func foodSave(foodName:String,foodImageName:String,foodPrice:Int,foodCount:Int,userName:String){
        foodRepo.foodSave(foodName: foodName, foodImageName: foodImageName, foodPrice: foodPrice, foodCount: foodCount, userName: userName)
    }
}
