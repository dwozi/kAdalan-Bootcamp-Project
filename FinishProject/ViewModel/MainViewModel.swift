//
//  MainViewModel.swift
//  FinishProject
//
//  Created by Hakan Hardal on 14.04.2024.
//

import Foundation
import RxSwift

class MainViewModel{
    
    var repo = Repository()
    var foodList = BehaviorSubject<[Foods]>(value: [Foods]())
    
    init(){
        foodList = repo.foodList
        uploadFoods()
    }
    
    
    func uploadFoods(){
        repo.uploadFoods()
    }
}
