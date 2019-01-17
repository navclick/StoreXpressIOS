//
//  LoginViewController.swift
//  StoreXpress
//
//  Created by Rana on 15/01/2019.
//  Copyright © 2019 exanadu. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoginViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    
    
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    
    func Validate() -> Bool{
        
        let response = Validation.shared.validate(values: (ValidationType.email, txtUsername.text!), (ValidationType.password, txtPassword.text!))
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
    
    @IBAction func openRegistration(_ sender: UIButton) {
      
        
        performSegue(withIdentifier: "OpenRegistration", sender: self)
    }
    
    
    @IBAction func clickLogin(_ sender: UIButton) {
        
        SignIN()
    }
    

    func SignIN(){
        
        
        if(Validate()){
        let parm=["username" : txtUsername.text! , "password" : txtPassword.text!, "grant_type" : "password" ];
       
        Spinner.start()
            Alamofire.request(Webapis.TokeURL, method: .post, parameters: parm,encoding: URLEncoding.default, headers: nil).responseJSON {
                response in
                switch response.result {
                case .success:
                    print(response)
                    
                    let swiftyJsonVar = JSON(response.result.value!)
                    
                    let token = swiftyJsonVar["access_token"].description
                    
                  
                    
                    if token.characters.count > 7 {
                        
                        
                        self.setToken(token: token)
                         
                        
                        
                    }
                    else{
                       // print("Fail")
                        
                        self.setToken(token: "")
                        self.displayMsg(title: Constants.AppName, msg: Constants.LoginFailed)
                    }
                        
                    
                    Spinner.stop()
                    
                    
                    
                    break
                    
                case .failure(let error):
                    
                    Spinner.stop()
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
