//
//  AllCatTableViewController.swift
//  StoreXpress
//
//  Created by Rana on 11/01/2019.
//  Copyright © 2019 exanadu. All rights reserved.
//

import UIKit

struct Headline {
    
    var id : Int
    var title : String
    var text : String
    var image : String
    
}

class HeadlineTableViewCell: UITableViewCell {
    
    @IBOutlet weak var catname: UILabel!
    
   
    @IBOutlet weak var catimg: UIImageView!
    
}


class AllCatTableViewController: UITableViewController {

    var headlines = [
        Headline(id: 1, title: "Lorem Ipsum", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", image: "logo"),
        Headline(id: 2, title: "Aenean condimentum", text: "Ut eget massa erat. Morbi mauris diam, vulputate at luctus non.", image: "logo"),
        Headline(id: 3, title: "In ac ante sapien", text: "Aliquam egestas ultricies dapibus. Nam molestie nunc.", image: "logo"),
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
            print("tabelview")
        self.tableView.backgroundColor = UIColor(red:0.97, green:0.96, blue:0.96, alpha:1.0)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return headlines.count
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! HeadlineTableViewCell
        //cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row)"
        let headline = headlines[indexPath.row]
        cell.catname?.text = headline.title
        
        cell.catimg?.image = UIImage(named: headline.image)
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
