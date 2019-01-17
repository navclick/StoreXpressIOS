//
//  RegistrationViewController.swift
//  StoreXpress
//
//  Created by Rana on 15/01/2019.
//  Copyright © 2019 exanadu. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON




class RegistrationViewController: UIViewController {

    
    
     let URL_POST_CREATE_USER = Webapis.BaseUrl + "accounts/createappuser"
    
    
    var arrRes = [[String:AnyObject]]();
    //{"ConfirmPassword":"1234567","Email":"asa_khannn@hotmail.com","FullName":"asadnn","Password":"1234567","PhoneNumber":"04332422328","Username":"asa_khannn@hotmail.com"}
    
    @IBOutlet weak var FullName: UITextField!
    
    
    @IBOutlet weak var Email: UITextField!
    
   
    @IBOutlet weak var PhoneNumber: UITextField!
    
    @IBOutlet weak var Password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
       // let customer = RegRequest(ConfirmPassword: "1234567", Email: "asa_khannn@hotmail.com", FullName: "asadnn", Password: "1234567", PhoneNumber: "04332422328", Username: "asa_khannn@hotmail.com" )
        
       // let self.arrRes=
        
        
        
        
        
       // print(String(data: jsonData, encoding: .utf8)!)
        //print(json)
        //self.arrRes = jsonDataS as! [[String:AnyObject]]
        //print ("Registration")
        //print (self.arrRes)
        
       
        
        
    }
    

    @IBAction func openLogin(_ sender: UIButton) {
        
        
        performSegue(withIdentifier: "OpenLogin", sender: self)
    }
    
    func loginScreen(){
        
        performSegue(withIdentifier: "OpenLogin", sender: self)
        
        
    }
    
    func Validate() -> Bool{
        
        let response = Validation.shared.validate(values: (ValidationType.alphabeticString, FullName.text!), (ValidationType.email, Email.text!),(ValidationType.phoneNo, PhoneNumber.text!))
        switch response {
        case .success:
            
            return true
            break
        case .failure(_, let message):
            
            let alert = UIAlertController(title: "Validation", message: message.localized(), preferredStyle: UIAlertController.Style.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
            print(message.localized())
            break
            return false
            
        }
        
        return true
        
    }
    
    
    
    @IBAction func register(_ sender: UIButton) {
      
        reisterUser();
    }
    
    func reisterUser(){
        //self.loginScreen()
        
        
        
        var VConfirmPassword: String
        var VEmail: String
        var VFullName: String
        var VPassword: String
        var VPhoneNumber: String
        var VUsername: String
        
        
        
        
        
        if(Validate()){
            
            VConfirmPassword = Password.text!
            VEmail = Email.text!
            VFullName = FullName.text!
            VPassword = Password.text!
            VPhoneNumber = PhoneNumber.text!
            VUsername = Email.text!
            
            let parm=["ConfirmPassword" : VConfirmPassword, "Email" : VEmail, "FullName" : VFullName, "Password" : VConfirmPassword, "PhoneNumber" :VPhoneNumber,"Username" : VEmail ];
            
            
            
            Alamofire.request(URL_POST_CREATE_USER, method: .post, parameters: parm,encoding: JSONEncoding.default, headers: nil).responseJSON {
                response in
                switch response.result {
                case .success:
                 //   print(response)
                   let swiftyJsonVar = JSON(response.result.value!)
                    
                    let isError=swiftyJsonVar["iserror"].boolValue
                  let message=swiftyJsonVar["message"].description
                   
                   if(!isError){
                    
                    
                    self.displayMsg(title: Constants.AppName, msg:message)
                    //self.loginScreen();
                    
                    let alert = UIAlertController(title: Constants.AppName, message: message, preferredStyle: UIAlertController.Style.alert)
                    
                   
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                      // print("Handle Ok logic here")
                    self.performSegue(withIdentifier: "OpenLogin", sender: self)
                    }))
                    
                   }
                   else{
                    
                    self.displayMsg(title: Constants.AppName, msg:message)
                    
                   }
                   
                  
                    
                    break
                case .failure(let error):
                    
                   
                    self.displayMsg(title: Constants.AppName, msg: error.localizedDescription)
                    print(error)
                }
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
extension UIViewController {
    func displayMsg(title : String?, msg : String,
                    style: UIAlertController.Style = .alert,
                    dontRemindKey : String? = nil) {
        if dontRemindKey != nil,
            UserDefaults.standard.bool(forKey: dontRemindKey!) == true {
            return
        }
        
        let ac = UIAlertController.init(title: title,
                                        message: msg, preferredStyle: style)
        ac.addAction(UIAlertAction.init(title: "OK",
                                        style: .default, handler: nil))
        
        if dontRemindKey != nil {
            ac.addAction(UIAlertAction.init(title: "Don't Remind",
                                            style: .default, handler: { (aa) in
                                                UserDefaults.standard.set(true, forKey: dontRemindKey!)
                                                UserDefaults.standard.synchronize()
            }))
        }
        DispatchQueue.main.async {
            self.present(ac, animated: true, completion: nil)
        }
    }
    
    func setToken(token : String){
        let userDefult = UserDefaults.standard
        userDefult.set(token , forKey: Constants.KEY_TOKEN)
      }

    
    func getToken()-> String{
        let userDefult = UserDefaults.standard
        
        let token=userDefult.string(forKey: Constants.KEY_TOKEN)
        return token!
    }

    
}
