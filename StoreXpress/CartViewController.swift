//
//  CartViewController.swift
//  StoreXpress
//
//  Created by Rana on 21/01/2019.
//  Copyright © 2019 exanadu. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell{
    
  
    @IBOutlet weak var cartImg: UIImageView!
    
    @IBOutlet weak var cartName: UILabel!
    
    @IBOutlet weak var cartPrice: UILabel!
}

class CartViewController: BaseViewController,UITableViewDataSource, UITableViewDelegate  {
  
    
    var CartList=[CartModel]();
    
    @IBOutlet weak var cartTable: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.CartList.append(CartModel(id: 1 as? Int, name: "Product1" as? String,  image: "Pro" as? String, price: "100"))
          self.CartList.append(CartModel(id: 1 as? Int, name: "Product2" as? String,  image: "Pro1" as? String, price: "200"))
          self.CartList.append(CartModel(id: 1 as? Int, name: "Product3" as? String,  image: "Pro" as? String, price: "300"))
          self.CartList.append(CartModel(id: 1 as? Int, name: "Product4" as? String,  image: "Pro1" as? String, price: "400"))
        self.CartList.append(CartModel(id: 1 as? Int, name: "Product5" as? String,  image: "Pro" as? String, price: "500"))
        self.CartList.append(CartModel(id: 1 as? Int, name: "Product6" as? String,  image: "Pro1" as? String, price: "600"))
        self.CartList.append(CartModel(id: 1 as? Int, name: "Product7" as? String,  image: "Pro" as? String, price: "700"))
        self.CartList.append(CartModel(id: 1 as? Int, name: "Product8" as? String,  image: "Pro1" as? String, price: "800"))

        self.cartTable.reloadData();
        // Do any additional setup after loading the view.
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
        //cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row)"
        let cart = self.CartList[indexPath.row]
        cell.cartName?.text = cart.name
        cell.cartPrice?.text = cart.price
      //  cell.
        var image : UIImage = UIImage(named: cart.image!)!
        
        cell.cartImg.image = image
        
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

}
