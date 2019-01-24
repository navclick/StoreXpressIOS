//
//  DBManager.swift
//  testsql
//
//  Created by Rana on 23/01/2019.
//  Copyright © 2019 Rana. All rights reserved.
//



import UIKit

class DBManager: NSObject {
    static let shared: DBManager = DBManager()
    
    let field_CartID = "ID"
    let field_ProductID = "itemID"
    let field_ProductName = "name"
    let field_ProductImage = "image"
    let field_ProducQty = "qty"
    
    var productID=0;
    var ProductName="";
    var productImage=""
    var productQty=0;
    
    
    
    let databaseFileName = "testsqldb.sqlite"
    
    var pathToDatabase: String!
    
    var database: FMDatabase!
    
    
    override init() {
        super.init()
        
        let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        pathToDatabase = documentsDirectory.appending("/\(databaseFileName)")
    }
    
    
    
    
    
    func createDatabase() -> Bool {
        var created = false
        
        if !FileManager.default.fileExists(atPath: pathToDatabase) {
            database = FMDatabase(path: pathToDatabase!)
            
            if database != nil {
                // Open the database.
                if database.open() {
                    let createMoviesTableQuery = "create table cart (\(field_CartID) integer primary key autoincrement not null, \(field_ProductID) integer not null, \(field_ProductName) text not null, \(field_ProductImage) text not null, \(field_ProducQty) integer not null)"
                    
                    do {
                        try database.executeUpdate(createMoviesTableQuery, values: nil)
                        created = true
                    }
                    catch {
                        print("Could not create table.")
                        print(error.localizedDescription)
                    }
                    
                    database.close()
                }
                else {
                    print("Could not open the database.")
                }
            }
        }
        
        return created
    }
    
    func openDatabase() -> Bool {
        
        
        
        
        
        if database == nil {
            if FileManager.default.fileExists(atPath: pathToDatabase) {
                database = FMDatabase(path: pathToDatabase)
            }
        }
        
        
        
        
        
        
        if database != nil {
            if database.open() {
                print("database open")
                return true
            }
        }
        print("Not open")
        return false
    }
    
    
    func insertCart(Product : CartItems) {
        print("insert")
        if openDatabase() {
            print("open")
            var query = ""
            
            query += "insert into cart (\(field_CartID), \(field_ProductID), \(field_ProductName), \(field_ProductImage), \(field_ProducQty)) values (null, \(Product.ProductID!), '\(Product.ProductName!)', '\(Product.ProductImage!)', \(Product.ProductQty!));"
            
            print(query)
            
            if !database.executeStatements(query) {
                print("Failed to insert initial data into the database.")
                print(database.lastError(), database.lastErrorMessage())
            }
            
            
            
            database.close()
        }
    }
    
    
    
    func loadCart() -> [CartItems]! {
        var Cart: [CartItems]!
        
        if openDatabase() {
            let query = "select * from cart"
            
            do {
                print(database)
                let results = try database.executeQuery(query, values: nil)
                
                
                while results.next() {
                    let cartItem = CartItems(CartID: Int(results.int(forColumn: field_CartID)),
                                             ProductID: Int(results.int(forColumn: field_ProductID)),
                                             ProductName: results.string(forColumn: field_ProductName),
                                             ProductImage: results.string(forColumn: field_ProductImage),
                                             ProductQty: Int(results.int(forColumn: field_ProducQty))
                    )
                    
                    if Cart == nil {
                        Cart = [CartItems]()
                    }
                    
                    Cart.append(cartItem)
                }
            }
            catch {
                print(error.localizedDescription)
            }
            
            database.close()
        }
        
        return Cart
    }
    
    
    
    func loadCartItem(withProductID ID: Int, completionHandler: (_ movieInfo: CartItems?) -> Void) {
        var CartObj: CartItems!
        
        if openDatabase() {
            let query = "select * from cart where \(field_ProductID)=?"
            
            do {
                let results = try database.executeQuery(query, values: [ID])
                
                if results.next() {
                    CartObj = CartItems(CartID: Int(results.int(forColumn: field_CartID)),
                                        ProductID: Int(results.int(forColumn: field_ProductID)),
                                        ProductName: results.string(forColumn: field_ProductName),
                                        ProductImage: results.string(forColumn: field_ProductImage),
                                        ProductQty: Int(results.int(forColumn: field_ProducQty))
                    )
                    
                }
                else {
                    print(database.lastError())
                }
            }
            catch {
                print(error.localizedDescription)
            }
            
            database.close()
        }
        
        completionHandler(CartObj)
    }
    
    
    
    func updateCartItem(withProductID ID: Int, Qty: Int) {
        if openDatabase() {
            let query = "update cart set \(field_ProducQty)=?"
            
            do {
                try database.executeUpdate(query, values: [Qty, ID])
            }
            catch {
                print(error.localizedDescription)
            }
            
            database.close()
        }
    }
    
    
    
    
    
    func deleteCartItem(withProductID ID: Int) -> Bool {
        var deleted = false
        
        if openDatabase() {
            let query = "delete from cart where \(field_ProductID)=?"
            
            do {
                try database.executeUpdate(query, values: [ID])
                deleted = true
            }
            catch {
                print(error.localizedDescription)
            }
            
            database.close()
        }
        
        return deleted
    }
    
    
    
    func clearCart() -> Bool {
        var deleted = false
        
        if openDatabase() {
            let query = "delete from cart "
            
            do {
                try database.executeUpdate(query,values: nil)
                deleted = true
            }
            catch {
                print(error.localizedDescription)
            }
            
            database.close()
        }
        
        return deleted
    }
    
    
    
    
    func CheckCartItem(withProductID ID: Int) -> Bool {
    
        var Incart = false;
    
    if openDatabase() {
    let query = "select * from cart where \(field_ProductID)=?"
    
    do {
    let results = try database.executeQuery(query, values: [ID])
    
    if results.next() {
   
        Incart = true;
    
    }
    else {
    print(database.lastError())
    }
    }
    catch {
    print(error.localizedDescription)
    }
    
    database.close()
    }
    
    return Incart
    }
    
    
    
    func GetCartItemQty(withProductID ID: Int) -> Int {
        
        var qty = 1;
        
        if openDatabase() {
            let query = "select * from cart where \(field_ProductID)=?"
            
            do {
                let results = try database.executeQuery(query, values: [ID])
                
                if results.next() {
                    
                    qty = Int(results.int(forColumn: field_ProducQty))
                    
                }
                else {
                    print(database.lastError())
                }
            }
            catch {
                print(error.localizedDescription)
            }
            
            database.close()
        }
        
        return qty
    }
    
    
    func CartItemCount() -> Int! {
        var count=0
        
        if openDatabase() {
            let query = "SELECT COUNT(*) as Count from cart"
            
            do {
                print(database)
                let results = try database.executeQuery(query, values: nil)
                
                
                while results.next() {
                    
                    let DbCount = Int(results.int(forColumn: "Count"))
                    count = DbCount
                }
            }
            catch {
                print(error.localizedDescription)
            }
            
            database.close()
        }
        
        return count
    }
    
    
}




//
//  DBManager.swift
//  FMDBTut
//
//  Created by Gabriel Theodoropoulos on 07/10/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//
