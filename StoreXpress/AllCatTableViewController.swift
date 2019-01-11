//
//  AllCatTableViewController.swift
//  StoreXpress
//
//  Created by Rana on 11/01/2019.
//  Copyright © 2019 exanadu. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON




class HeadlineTableViewCell: UITableViewCell {
    
    @IBOutlet weak var catname: UILabel!
    
   
    @IBOutlet weak var catimg: UIImageView!
    
}


class AllCatTableViewController: UITableViewController {
    var arrRes = [[String:AnyObject]]();
    var CatList=[CateogryModel]();
    
    let URL_GET_DATA = Webapis.BaseUrl + "category/getcategories"
    
    override func viewDidLoad() {
        super.viewDidLoad()
            print("tabelview")
        
        print(URL_GET_DATA)
        
       // self.CatList.append(CateogryModel(id: 1, name: "Lorem Ipsum1",  image: "logo"))
       // self.CatList.append(CateogryModel(id: 1, name: "Lorem Ipsum2",  image: "logo"))
        //self.CatList.append(CateogryModel(id: 1, name: "Lorem Ipsum3",  image: "logo"))
       
        Alamofire.request(URL_GET_DATA).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                
                	if let resData = swiftyJsonVar["value"].arrayObject {
                    self.arrRes = resData as! [[String:AnyObject]]
                        
                        if(self.arrRes.count > 0){
                            print(self.arrRes.count)
                             for i in 0..<self.arrRes.count{
                                
                                var dict = self.arrRes[i];
                            
                                self.CatList.append(CateogryModel(id: dict["id"] as? Int, name: dict["name"] as? String,  image: dict["image"] as? String))
                            print(self.CatList[i].image)
                            }
                            
                            self.tableView.reloadData()
                        }
                
                }
                
                            }
        }
        
       
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.CatList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! HeadlineTableViewCell
        //cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row)"
        let category = self.CatList[indexPath.row]
        cell.catname?.text = category.name
        
        
        Alamofire.request(category.image!).responseImage { response in
            debugPrint(response)
            
            if let image = response.result.value {
                
                cell.catimg?.image = image
            }
        }
        
        
        
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "All Categories"
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
