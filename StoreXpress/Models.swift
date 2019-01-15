//
//  Models.swift
//  StoreXpress
//
//  Created by Rana on 15/01/2019.
//  Copyright © 2019 exanadu. All rights reserved.
//



class ProductModel {
    
    var id : Int?
    var name : String?
    var price : String?
    
    var image : String?
    
    init(id: Int?,name: String?,price: String?, image: String?) {
        self.id=id;
        self.name = name
         self.price = price
        self.image = image
    }
}
