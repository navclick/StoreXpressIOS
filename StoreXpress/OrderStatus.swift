//
//  OrderStatus.swift
//  StoreXpress
//
//  Created by Naveed on 23/01/2019.
//  Copyright © 2019 exanadu. All rights reserved.
//

import UIKit

class OrderStatusViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    self.UIViewStatusOrderID.borderWidths = UIEdgeInsetsMake(2.0, 4.0, 6.0, 8.0);
    self.UIViewStatusOrderID.borderColorTop = [UIColor blueColor];
    self.UIViewStatusOrderID.borderColorRight = [UIColor redColor];
    self.UIViewStatusOrderID.borderColorBottom = [UIColor greenColor];
    self.UIViewStatusOrderID.borderColorLeft = [UIColor darkGrayColor];

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
