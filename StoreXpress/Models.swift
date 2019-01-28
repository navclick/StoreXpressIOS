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
    
    var desc : String?
    init(id: Int?,name: String?,price: String?, image: String?, desc: String? ) {
        self.id=id;
        self.name = name
         self.price = price
        self.image = image
        self.desc=desc
    }
}

class ProductDetailsModel {
    
     static var  id : Int?
    static var  name : String?
    static var  price : String?
    
    static var  image : String?
    
    static var  desc : String?
    
    
   
}


class CartModel {
    
    var id : Int?
    var name : String?
    
    var image : String?
    var price : String?
    
    init(id: Int?,name: String?, image: String?,price : String?) {
        self.id=id;
        self.name = name
        self.image = image
        self.price=price
    }
    
    
    
}

struct CartItems {
    var CartID: Int!
    var ProductID: Int!
    var ProductName: String!
    var ProductImage: String!
    var ProductQty: Int!
     var ProductPrice: String!
    
    
}
