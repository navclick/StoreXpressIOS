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
}

class CartViewController: BaseViewController,UITableViewDataSource, UITableViewDelegate  {
  
    
    var CartList=[CartItems]();
    
    @IBOutlet weak var cartTable: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CartList = DBManager.shared.loadCart()

        self.cartTable.reloadData();
        // Do any additional setup after loading the view.
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
        //cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row)"
        let cart = self.CartList[indexPath.row]
        cell.cartName?.text = cart.ProductName
        cell.cartPrice?.text = "100"
      //  cell.
        
        
        
        
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

}
