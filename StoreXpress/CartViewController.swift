//
//  CartViewController.swift
//  StoreXpress
//
//  Created by Rana on 21/01/2019.
//  Copyright © 2019 exanadu. All rights reserved.
//

import UIKit
import Alamofire

class CartTableViewCell: UITableViewCell{
    
  
    @IBOutlet weak var cartImg: UIImageView!
    
    @IBOutlet weak var cartName: UILabel!
    
    @IBOutlet weak var cartPrice: UILabel!
    
    @IBOutlet weak var cartQty: UILabel!
    
    @IBOutlet weak var btnRemove: RemoveToCartButton!
    
    
}

class CartViewController: BaseViewController,UITableViewDataSource, UITableViewDelegate  {
  
    @IBOutlet weak var cartTotalItem: UILabel!
    
    @IBOutlet weak var cartTotalPrice: UILabel!
   
    var CartList=[CartItems]();
    
    var totalPrice = 0
    
    @IBOutlet weak var cartTable: UITableView!
    
    

    override func viewDidLoad() {
       
        
        super.viewDidLoad()
        
        
        
        reLoad()
        // Do any additional setup after loading the view.
    }
    
    
    func reLoad(){
         CartList = DBManager.shared.loadCart() 
       // self.cartTable.estimatedRowHeight = 0;
        
       // self.cartTable.estimatedSectionHeaderHeight = 0;
        
       // self.cartTable.estimatedSectionFooterHeight = 0;
        
        if(CartList.count > 0){
            CartList.removeAll()
            CartList = DBManager.shared.loadCart()
            
        cartTotalItem.text = String(CartList.count)
        updateCartCount()
            DispatchQueue.main.async {
                self.cartTable.reloadData();
                
            }
            
            self.cartTotalPrice.text = Constants.CURR_SIGN + String(self.totalPrice)
            
        }
        else{
            
             Toast.show(message: Constants.MSG_CART_EMPTY, controller: self)
            //self.openViewControllerBasedOnIdentifier("Home")
            
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
        //cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row)"
        let cart = self.CartList[indexPath.row]
        cell.cartName?.text = cart.ProductName
        cell.cartPrice?.text = Constants.CURR_SIGN + cart.ProductPrice
      //  cell.
        cell.cartQty.text = Constants.QTY_SIGN + String(cart.ProductQty)
        
        cell.btnRemove.tag = 301
        cell.btnRemove.RowIndex = indexPath.row
        cell.btnRemove.addTarget(self, action: #selector(removeFromcart), for: .touchUpInside)
        self.totalPrice = self.totalPrice + Int(cart.ProductPrice!)!
        
        Alamofire.request( cart.ProductImage).responseImage { response in
            // debugPrint(response)
            
            if let image = response.result.value {
                
               cell.cartImg.image = image
            }
        }
        
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    @objc func removeFromcart(sender: RemoveToCartButton! , Index : Int) {
        let btnsendtag: RemoveToCartButton = sender
        print (btnsendtag.tag)
        if( btnsendtag.tag==301){
            
            let cart = self.CartList[btnsendtag.RowIndex]
            
            if DBManager.shared.deleteCartItem(withProductID: cart.ProductID!) {
               
                Toast.show(message: Constants.MSG_PRODUCT_REMOVE_FROM_CART, controller: self)
                reLoad();
                
                
            }
            
        }
        
        
    }
}
