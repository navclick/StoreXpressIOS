//
//  CateogryModel.swift
//  StoreXpress
//
//  Created by Rana on 11/01/2019.
//  Copyright © 2019 exanadu. All rights reserved.
//


class CateogryModel {
    
    var id : Int?
    var name : String?
    
    var image : String?
    
    init(id: Int?,name: String?, image: String?) {
        self.id=id;
        self.name = name
        self.image = image
    }
}
