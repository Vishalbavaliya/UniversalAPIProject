//
//  HomeViewController.swift
//  MakeUp Kit App Api
//
//  Created by Vishal Bavaliya on 01/05/22.
//

import UIKit
struct Article: Codable {
    let newsTitle:String
    let newsContent:String
    let newsImage:String

    private enum CodingKeys: String, CodingKey {
        case newsTitle = "newstitle"
        case newsContent = "newscontent"
        case newsImage = "newsimage"
    }
}
//struct Article: Codable {
//    let author, title, articleDescription: String
//    let url, urlToImage: String
//    let publishedAt: Date
//    let content: String
//
//    enum CodingKeys: String, CodingKey {
//        case author, title
//        case articleDescription = "description"
//        case url, urlToImage, publishedAt, content
//    }
//}

class HomeViewController: UIViewController {

    @IBOutlet weak var pageView: UIPageControl!
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var allCategoriesCell: UICollectionView!
    
    
 
    var timer  = Timer()
    var counter = 0
    var arreItemName = ["1","2","3","4","5","6","7","8","9","10"]
    var arreyNewsList = [Article]()
    
      override func viewDidLoad() {
        super.viewDidLoad()
        allCategoriesCell.dataSource = self
        allCategoriesCell.delegate = self
          getApiCall()
          pageView.numberOfPages = arreItemName.count
          pageView.currentPage = 0
          DispatchQueue.main.async {
              
              self.timer = Timer.scheduledTimer(timeInterval: 1.5 , target: self, selector: #selector(self.changeimage), userInfo: nil, repeats: true)
          }
        }
    
    @objc func changeimage() {
        if counter < arreItemName.count {
            let index = IndexPath.init(item:counter, section:0)
            self.allCategoriesCell.scrollToItem(at:index, at:.centeredHorizontally, animated: true)
            pageView.currentPage = counter
             counter += 1
        } else {
            counter = 0
            let index = IndexPath.init(item:counter, section:0)
            self.allCategoriesCell.scrollToItem(at:index, at:.centeredHorizontally, animated: true)
            pageView.currentPage = counter
            counter = 1
        }        
    }
    
    func getApiCall() {
        
//        let url =  URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=ee1713290f314803a8616ac05f11c0be")
        let url =  URL(string: "http://haritibhakti.com/newsdata.json")
        let dataTask = URLSession.shared.dataTask(with: url!, completionHandler: {
            (data, response, error)  in
            guard let data = data, error == nil else {
                return
            }
        var unilist = [Article]()
            do {
                unilist = try JSONDecoder().decode([Article].self, from: data)
                dump(unilist)
            } catch {
                print("error\(error )")
            }
            self.arreyNewsList = unilist
            DispatchQueue.main.async {
                self.myTableView.reloadData()
                self.allCategoriesCell.reloadData()
            }
            
        })
        dataTask.resume()
    }
}
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

extension HomeViewController:UICollectionViewDelegate,UICollectionViewDataSource {
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arreyNewsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? AllCategoriesCollectionCell {
//           cell.layer.cornerRadius = 40
//           cell.layer.masksToBounds = true
//           cell.layer.borderColor = UIColor.black.cgColor
//           cell.layer.borderWidth = 1
//           cell.layer.borderColor = UIColor.gray.cgColor
//           cell.itemImage.downloaded(from: "http://haritibhakti.com\(arreyNewsList[indexPath.row].newsImage)")
//           cell.itemImage.downloaded(from:arreyNewsList[indexPath.row].urlToImage)
           cell.itemImage.image = UIImage(named: arreItemName[indexPath.row])
           cell.itemNameLable.text = arreyNewsList[indexPath.row].newsTitle
           
            return cell
        }
        
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
extension HomeViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arreyNewsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyNewsTableViewCell
        cell.newsImage.image = UIImage(named: arreItemName[indexPath.row])
//        cell.titleLable.text = arreyNewsList[indexPath.row].newsTitle
//        cell.newsImage.downloaded(from: arreyNewsList[indexPath.row].urlToImage)
        cell.titleLable.text = arreyNewsList[indexPath.row].newsTitle
        return cell
    }
    
}



var noInRow = 1
var insets : UIEdgeInsets = UIEdgeInsets(top: 9, left: 20, bottom: 26, right: 20)
var selectedCellIndex = -1

extension HomeViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widht = view.frame.width
        let paddingspace =  insets.left * CGFloat(noInRow+1)
        let availablewhith = widht - paddingspace
        let cellwidht = availablewhith/CGFloat(noInRow)
        let cellsize : CGSize = CGSize(width: cellwidht, height: cellwidht)
        return cellsize
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return insets.left
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return insets.left
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return insets
    }
}
