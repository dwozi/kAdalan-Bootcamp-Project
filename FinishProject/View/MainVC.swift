//
//  ViewController.swift
//  FinishProject
//
//  Created by Hakan Hardal on 14.04.2024.
//

import UIKit
import RxSwift
import Kingfisher
class MainVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var searchText: UISearchBar!
    
    
    
    var viewModel = MainViewModel()
    var foodList = [Foods]()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchText.delegate = self
        
       
        _ = viewModel.foodList.subscribe(onNext: { list in
            self.foodList = list
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
        collectionViewDesign()

        
       
        
        //MARK: tabbar & navigationbar Controllers
        let appereance = UITabBarAppearance()
        appereance.configureWithDefaultBackground()
        tabBarController?.tabBar.standardAppearance = appereance
        tabBarController?.tabBar.scrollEdgeAppearance = appereance
        
        let control = UINavigationBarAppearance()
        control.configureWithDefaultBackground()
        navigationController?.navigationBar.standardAppearance = control
        navigationController?.navigationBar.scrollEdgeAppearance = control
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.compactAppearance = control
        navigationController?.navigationBar.compactScrollEdgeAppearance = control
        navigationController?.navigationBar.scrollEdgeAppearance = control
        
    }
    func collectionViewDesign(){
        let design = UICollectionViewFlowLayout()
        design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        design.minimumLineSpacing = 10
        design.minimumInteritemSpacing = 10
        let screenWidth =  UIScreen.main.bounds.width
        let itemWidth = (screenWidth-30) / 2
        design.itemSize = CGSize(width: itemWidth, height: itemWidth*1.4)
        collectionView.collectionViewLayout = design
        
        
        
        
    }
}


extension MainVC : UICollectionViewDelegate , UICollectionViewDataSource,UISearchBarDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
      
        let foods = foodList[indexPath.row]
        
        if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(foods.yemek_resim_adi!)"){
            DispatchQueue.main.async {
               cell.imageView.kf.setImage(with: url)
            }
        }
        cell.priceLabel.text = "\(foods.yemek_fiyat!)$"
        cell.nameLabel.text = (foods.yemek_adi)

       cell.setuplayer()
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailvc"{
            if let movieSender = sender as? Foods{
                let destinationVC = segue.destination as! DetailVC
                destinationVC.foods = movieSender
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let food = foodList[indexPath.row]
        self.performSegue(withIdentifier: "detailvc", sender: food)
        
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
}

