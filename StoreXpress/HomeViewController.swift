//
//  HomeViewController.swift
//  StoreXpress
//
//  Created by Rana on 14/01/2019.
//  Copyright © 2019 exanadu. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON


class AllCatCollectionviewCell : UICollectionViewCell{
    
    @IBOutlet weak var CatName: UILabel!
    
    @IBOutlet weak var CatImage: UIImageView!
    
    
}

class AllProductCollectionViewCell : UICollectionViewCell{
    @IBOutlet weak var ProductImage: UIImageView!
    
    @IBOutlet weak var ProductName: UILabel!
    
    
}

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {

    var arrRes = [[String:AnyObject]]();
    var arrResProduct = [[String:AnyObject]]();
    var CatList=[CateogryModel]();
    var ProductList=[ProductModel]();
    
    @IBOutlet weak var CollectionCat: UICollectionView!
    
    @IBOutlet weak var CollectionProduct: UICollectionView!
    
    
    let reuseIdentifierForCat = "AllCatCell"
    
    let reuseIdentifierForProduct = "AllProductCell"

    let URL_GET_DATA = Webapis.BaseUrl + "category/getcategories"
     let URL_GET_PRODUCTS = Webapis.BaseUrl + "item/featureproducts"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Home contoller")
        Alamofire.request(URL_GET_DATA).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                
                if let resData = swiftyJsonVar["value"].arrayObject {
                    self.arrRes = resData as! [[String:AnyObject]]
                    
                    if(self.arrRes.count > 0){
                        //print(self.arrRes.count)
                        for i in 0..<self.arrRes.count{
                            
                            var dict = self.arrRes[i];
                            
                            self.CatList.append(CateogryModel(id: dict["id"] as? Int, name: dict["name"] as? String,  image: dict["image"] as? String))
                          // print(self.CatList[i].name)
                        }
                        
                        self.CollectionCat.reloadData()
                        self.getProducts();
                    }
                    
                }
                
            }
        }
        
        
        
        
        
        // Do any additional setup after loading the view.
    }

    
    func getProducts(){
        
        Alamofire.request(URL_GET_PRODUCTS).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                
                
                
                //print(resData);
                
                if let resData = swiftyJsonVar["value"].arrayObject {
                    self.arrResProduct = resData as! [[String:AnyObject]]
                    
                    if(self.arrResProduct.count > 0){
                        print(self.arrResProduct.count)
                        for i in 0..<self.arrResProduct.count{
                            
                            var dict = self.arrResProduct[i];
                            
                            self.ProductList.append(ProductModel(id: dict["id"] as? Int, name: dict["name"] as? String, price	: dict["price"] as? String,  image: dict["image"] as? String))
                          //  print(self.ProductList[i].name)
                        }
                        
                        self.CollectionProduct.reloadData()
                    }
                    
                }
                
            }
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
        if collectionView == self.CollectionCat {
        
        return self.CatList.count
            
        }
        
        else{
            
            return self.ProductList.count
            
        }
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         if collectionView == self.CollectionCat {
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierForCat, for: indexPath as IndexPath) as! AllCatCollectionviewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
       // cell.myLabel.text = self.items[indexPath.item]
       // cell.backgroundColor = UIColor.cyan // make cell more visible in our example project
        
        let category = self.CatList[indexPath.row]
        cell.CatName?.text = category.name
        
        
        Alamofire.request(category.image!).responseImage { response in
           // debugPrint(response)
            
            if let image = response.result.value {
                
                cell.CatImage?.image = image
            }
        }
        
        
        
        return cell
            
        }
         else{
            
            
            let cellPro = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierForProduct, for: indexPath as IndexPath) as! AllProductCollectionViewCell
            
            // Use the outlet in our custom class to get a reference to the UILabel in the cell
            // cell.myLabel.text = self.items[indexPath.item]
            // cell.backgroundColor = UIColor.cyan // make cell more visible in our example project
            
            let product = self.ProductList[indexPath.row]
            cellPro.ProductName?.text = product.name
            
            
            Alamofire.request(product.image!).responseImage { response in
                // debugPrint(response)
                
                if let image = response.result.value {
                    
                    cellPro.ProductImage?.image = image
                }
            }
            
            
            
            return cellPro
            
            
        }
        
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }





}
