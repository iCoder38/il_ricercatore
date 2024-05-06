//
//  weight_goal.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 06/05/24.
//

import UIKit
import Alamofire

class weight_goal: UIViewController {
    var dict_profile:NSDictionary!
    @IBOutlet weak var btn_menu:UIButton!
    
    @IBOutlet weak var lbl_navigation_title:UILabel! {
        didSet {
            lbl_navigation_title.text = "WEIGHT GOAL"
            lbl_navigation_title.textColor = .white
        }
    }
    
    @IBOutlet weak var view_one:UIView! {
        didSet {
            view_one.layer.cornerRadius = 8
            view_one.clipsToBounds = true
            view_one.backgroundColor = light_pink_color
             
        }
    }
    @IBOutlet weak var view_two:UIView! {
        didSet {
            view_two.layer.cornerRadius = 8
            view_two.clipsToBounds = true
            view_two.backgroundColor = light_pink_color
             
        }
    }
    @IBOutlet weak var view_three:UIView! {
        didSet {
            view_three.layer.cornerRadius = 8
            view_three.clipsToBounds = true
            view_three.backgroundColor = light_pink_color
             
        }
    }
    @IBOutlet weak var view_one_right:UIView! {
        didSet {
            view_one_right.layer.cornerRadius = 8
            view_one_right.clipsToBounds = true
            view_one_right.backgroundColor = .clear
            view_one_right.layer.borderWidth = 1.0
            view_one_right.layer.borderColor = UIColor.black.cgColor
        }
    }
    //
    @IBOutlet weak var view_two_right:UIView! {
        didSet {
            view_two_right.layer.cornerRadius = 8
            view_two_right.clipsToBounds = true
            view_two_right.backgroundColor = .clear
            view_two_right.layer.borderWidth = 1.0
            view_two_right.layer.borderColor = UIColor.black.cgColor
        }
    }
    @IBOutlet weak var btn_one:UIButton!
    @IBOutlet weak var btn_two:UIButton!
    
    @IBOutlet weak var lbl_one:UILabel!
    @IBOutlet weak var lbl_two:UILabel!
    
    @IBOutlet weak var lbl_one_text:UILabel!
    @IBOutlet weak var lbl_two_text:UILabel!
    @IBOutlet weak var lbl_three_text:UILabel!
    
    @IBOutlet weak var btn_activity:UIButton!
    @IBOutlet weak var btn_continue:UIButton!
    
    @IBOutlet weak var txt_one:UITextField! {
        didSet {
            txt_one.setLeftPaddingPoints(20)
        }
    }
    @IBOutlet weak var txt_two:UITextField! {
        didSet {
            txt_two.setLeftPaddingPoints(20)
        }
    }
    
    var activity:NSMutableArray! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btn_one.addTarget(self, action: #selector(btn_one_click), for: .touchUpInside)
        self.btn_two.addTarget(self, action: #selector(btn_two_click), for: .touchUpInside)
        self.btn_menu.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        self.btn_activity.addTarget(self, action: #selector(activity_click_method), for: .touchUpInside)
        self.btn_continue.addTarget(self, action: #selector(create_an_account), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        self.general_WB()
    }
    @objc func btn_one_click() {
        
        let dummyList = ["KG","LBS"]
        RPicker.selectOption(title: "Select Weight", cancelText: "Cancel", dataArray: dummyList, selectedIndex: 0) { (selctedText, atIndex) in
             
            self.lbl_one.text = String(selctedText)
            
        }
        
    }
    @objc func btn_two_click() {
        
        let dummyList = ["KG","LBS"]
        RPicker.selectOption(title: "Select Weight", cancelText: "Cancel", dataArray: dummyList, selectedIndex: 0) { (selctedText, atIndex) in
             
            self.lbl_two.text = String(selctedText)
        }
        
    }
    
    @objc func activity_click_method() {
        
        let swiftArray = ["Light or No Activity","Lightly Active","Moderately Active","Very Active"]
        
        RPicker.selectOption(title: "Activity Level", cancelText: "Cancel", dataArray: swiftArray, selectedIndex: 0) { (selctedText, atIndex) in
            
            self.lbl_three_text.text = String(selctedText)
        }
        
    }
    
    @objc func general_WB() {
     
        var parameters:Dictionary<AnyHashable, Any>!
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
       
        parameters = [
            "action"            : "general",
        ]
        
        print("parameters-------\(String(describing: parameters))")
        
        AF.request(application_base_url, method: .post, parameters: parameters as? Parameters ).responseJSON {[self]
            response in
            
            switch(response.result) {
            case .success(_):
                if let data = response.value {
                    
                    let JSON = data as! NSDictionary
                    print(JSON)
                    
                    var ar : NSArray!
                    ar = (JSON["Daily_Activity"] as! Array<Any>) as NSArray
                    self.activity.addObjects(from: ar as! [Any])
                    my_profile(loader: "no")
                }
                
            case .failure(_):
                print("Error message:\(String(describing: response.error))")
                ERProgressHud.sharedInstance.hide()
                self.please_check_your_internet_connection()
                
                break
            }
        }
    }
    
    @objc func my_profile(loader:String) {
        //  let indexPath = IndexPath.init(row: 0, section: 0)
        //  let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_three_table_cell
        
        var parameters:Dictionary<AnyHashable, Any>!
        
        if (loader == "yes") {
            // ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        }
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            print(person)
            
            let x : Int = person["userId"] as! Int
            let myString = String(x)
            
            if let token_id_is = UserDefaults.standard.string(forKey: str_save_last_api_token) {
                
                let headers: HTTPHeaders = [
                    "token":String(token_id_is),
                ]
                
                parameters = [
                    "action"            : "profile",
                    "userId"            : String(myString),
                ]
                
                print("parameters-------\(String(describing: parameters))")
                
                AF.request(application_base_url, method: .post, parameters: parameters as? Parameters,headers: headers).responseJSON { [self]
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
                                
                                self.dict_profile = dict as NSDictionary
                                
                                /*self.tble_view.delegate = self
                                self.tble_view.dataSource = self
                                self.tble_view.reloadData()*/
                                
                                self.txt_one.text = (self.dict_profile["current_wight"] as! String)
                                self.txt_two.text = (self.dict_profile["target_wight"] as! String)
                                self.lbl_three_text.text = (self.dict_profile["daily_activity"] as! String)
                            }
                            else {
                                self.refresh_token_WB()
                            }
                            
                        }
                        
                    case .failure(_):
                        print("Error message:\(String(describing: response.error))")
                        ERProgressHud.sharedInstance.hide()
                        self.please_check_your_internet_connection()
                        
                        break
                    }
                }
            } else {
                self.refresh_token_WB()
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
                        
                        self.my_profile(loader: "no")
                        
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
    
    
    
    @objc func create_an_account() {
        // let indexPath = IndexPath.init(row: 0, section: 0)
        // let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_table_cell
        
        var parameters:Dictionary<AnyHashable, Any>!
        
        
            ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
     
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            print(person)
            
            let x : Int = person["userId"] as! Int
            let myString = String(x)
            
            if let token_id_is = UserDefaults.standard.string(forKey: str_save_last_api_token) {
                
                let headers: HTTPHeaders = [
                    "token":String(token_id_is),
                ]
                
                //
                /*
                 [current_wight] => 33
                     [current_wight_measurement] => KG
                     [target_wight] => 3
                     [target_wight_measurement] => KG
                     [daily_activity] => Moderately Active
                 */
                parameters = [
                    "action"                    : "editprofile",
                    "userId"                    : String(myString),
                    "current_wight"             : String(self.txt_one.text!),
                    "current_wight_measurement" : String(self.lbl_one.text!),
                    "target_wight"              : String(self.txt_two.text!),
                    "target_wight_measurement"  : String(self.lbl_two.text!),
                    "daily_activity"            : String(self.lbl_three_text.text!),
                ]
                
                
                print("parameters-------\(String(describing: parameters))")
                
                AF.request(application_base_url, method: .post, parameters: parameters as? Parameters,headers: headers).responseJSON {
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
                                
                                /*let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "complete_profile_two_id")
                                self.navigationController?.pushViewController(push, animated: true)*/
                                
                                
                            }
                            else {
                                self.refresh_token_WB3()
                            }
                            
                        }
                        
                    case .failure(_):
                        print("Error message:\(String(describing: response.error))")
                        ERProgressHud.sharedInstance.hide()
                        self.please_check_your_internet_connection()
                        
                        break
                    }
                }
            } else {
                self.refresh_token_WB3()
            }
        }
        
    }
    
    @objc func refresh_token_WB3() {
        
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
                        
                        self.create_an_account()
                        
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
