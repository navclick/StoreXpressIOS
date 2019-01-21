//
//  ProductDetailsViewController.swift
//  StoreXpress
//
//  Created by Naveed on 16/01/2019.
//  Copyright © 2019 exanadu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ProductDetailsViewController: BaseViewController {

    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    
    
    @IBOutlet weak var productPrice: UILabel!
    
    
    @IBOutlet weak var productPriceTwo: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        
        print("Product Details")
        self.productName?.text = ProductDetailsModel.name
        self.productPrice?.text = ProductDetailsModel.price
         self.productPriceTwo?.text = ProductDetailsModel.price
        
        
        
        
        Alamofire.request(ProductDetailsModel.image!).responseImage { response in
            // debugPrint(response)
            
            if let image = response.result.value {
                
                self.productImage?.image = image
            }
        }
        
        
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
