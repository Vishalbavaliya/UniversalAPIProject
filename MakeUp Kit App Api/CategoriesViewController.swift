////
////  CategoriesViewController.swift
////  MakeUp Kit App Api
////
////  Created by Vishal Bavaliya on 01/05/22.
////
//
//import UIKit
//
//class CategoriesViewController: UIViewController {
//
//    @IBOutlet weak var categoriesCollectionView: UICollectionView!
//    
//    var arreImage1 : [String] = ["Blush1","Bronzer1","Eyeshadow1","Foundation1","Lipliner1","Lipstick1","Mascara1","Nailpolish1"]
//
//    var arreItemName = [" Blush","Bronzer","Eyeshadow","Foundation","Lipliner","Lipstick","Mascara","Nailpolish"]
//    
//    var priceArrey = ["123","123","134","234","654","6543","457","889"]
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        categoriesCollectionView.dataSource = self
//        categoriesCollectionView.delegate = self
////        categoriesCollectionView.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
//    }
//    
//}
//var insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
//var selected = 0
//extension CategoriesViewController: UICollectionViewDelegate,UICollectionViewDataSource {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return arreImage1.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyAllCategoriesCollectionViewCell
//        cell.itemsImage.image = UIImage(named:arreImage1[indexPath.row])
//        cell.itemsNameLable.text = arreItemName[indexPath.row]
//        cell.itemPriceLable.text = "Rs \(priceArrey[indexPath.row])"
//        cell.layer.borderColor = selected == indexPath.row ? UIColor.white.cgColor :UIColor.gray.cgColor
//        cell.layer.borderWidth = selected == indexPath.row ? 2 : 1
//        cell.layer.masksToBounds = true
//        cell.layer.cornerRadius = 20
//        
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//      let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
//      return CGSize(width: itemSize, height: itemSize)
//    }
//  }
//    
//    
//
