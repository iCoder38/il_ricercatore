//
//  login.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 13/12/23.
//

import UIKit
import Alamofire

class login: UIViewController {

    @IBOutlet weak var txt_email:UITextField!
    @IBOutlet weak var txt_password:UITextField!
    
    @IBOutlet weak var btn_login:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btn_login.addTarget(self, action: #selector(login_wb), for: .touchUpInside)
        self.remember_me()
    }

    @objc func remember_me() {
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            print(person as Any)
            
            if person["role"] as! String == "Member" {
                
                if (person["gender"] as! String) == "" {
                    
                    let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "complete_profile_id")
                    self.navigationController?.pushViewController(push, animated: true)
                    
                } else if (person["Fitness_goal"] as! String) == "" {
                    
                    let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "complete_profile_two_id")
                    self.navigationController?.pushViewController(push, animated: true)
                    
                } else if (person["food_preference"] as! String) == "" {
                    
                    let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "complete_profile_three_id")
                    self.navigationController?.pushViewController(push, animated: true)
                    
                } else {
                    
                    // push to dashboard
                    let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "dashboard_id")
                    self.navigationController?.pushViewController(push, animated: true)
                    
                }
                
                
                
            } else {
                
                // DRIVER
                // let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "dashboard_id")
                // self.navigationController?.pushViewController(push, animated: true)
                
            }
            
        }
        
    }
    
    @objc func login_wb() {
        
        if (self.txt_email.text == "") {
            return
        }
        
        if (self.txt_password.text == "") {
            return
        }
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        var parameters:Dictionary<AnyHashable, Any>!
        
        
        parameters = [
            "action"    : "login",
            "email"     : String(self.txt_email.text!),
            "password"  : String(self.txt_password.text!),
            "device"    : "iOS",
            
        ]
        
        print("parameters-------\(String(describing: parameters))")
        
        AF.request(application_base_url, method: .post, parameters: parameters as? Parameters).responseJSON {
            response in
            
            switch(response.result) {
            case .success(_):
                if let data = response.value {
                    
                    let JSON = data as! NSDictionary
                    print(JSON)
                    
                    var strSuccess : String!
                    strSuccess = JSON["status"] as? String
                    
                    if strSuccess.lowercased() == "success" {
                        ERProgressHud.sharedInstance.hide()
                        
                        var dict: Dictionary<AnyHashable, Any>
                        dict = JSON["data"] as! Dictionary<AnyHashable, Any>
                        
                        let defaults = UserDefaults.standard
                        defaults.setValue(dict, forKey: str_save_login_user_data)
                        
                        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "dashboard_id")
                        self.navigationController?.pushViewController(push, animated: true)
                        
                    }
                    
                    
                }
                
            case .failure(_):
                print("Error message:\(String(describing: response.error))")
                ERProgressHud.sharedInstance.hide()
                self.please_check_your_internet_connection()
                
                break
            }
        }
    }
    
    @objc func refresh_token_WB() {
        
        var parameters:Dictionary<AnyHashable, Any>!
        
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            
            let x : Int = person["userId"] as! Int
            let myString = String(x)
            
            parameters = [
                "action"    : "gettoken",
                "userId"    : String(myString),
                "email"     : (person["email"] as! String),
                "role"      : "Member"
            ]
        }
        
        print("parameters-------\(String(describing: parameters))")
        
        AF.request(application_base_url, method: .post, parameters: parameters as? Parameters).responseJSON {
            response in
            
            switch(response.result) {
            case .success(_):
                if let data = response.value {
                    
                    let JSON = data as! NSDictionary
                    print(JSON)
                    
                    var strSuccess : String!
                    strSuccess = JSON["status"] as? String
                    
                    if strSuccess.lowercased() == "success" {
                        
                        let str_token = (JSON["AuthToken"] as! String)
                        UserDefaults.standard.set("", forKey: str_save_last_api_token)
                        UserDefaults.standard.set(str_token, forKey: str_save_last_api_token)
                        
                        self.login_wb()
                        
                    } else {
                        ERProgressHud.sharedInstance.hide()
                    }
                    
                }
                
            case .failure(_):
                print("Error message:\(String(describing: response.error))")
                ERProgressHud.sharedInstance.hide()
                self.please_check_your_internet_connection()
                
                break
            }
        }
    }
    
}
