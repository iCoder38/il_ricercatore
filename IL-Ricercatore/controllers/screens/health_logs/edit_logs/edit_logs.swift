//
//  edit_logs.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 13/05/24.
//

import UIKit
import Alamofire

class edit_logs: UIViewController, UITextFieldDelegate {
    
    var str_title:String!
    
    var str_value:String! = "0"
    var arr_calories:NSMutableArray! = []
    
    @IBOutlet weak var btn_back:UIButton! {
        didSet {
            btn_back.tintColor = .white
            btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var view_navigation_title:UILabel! {
        didSet {
            view_navigation_title.text = str_title.uppercased()
            view_navigation_title.textColor = .white
        }
    }
    
    @IBOutlet weak var tbleView: UITableView! {
        didSet {
            tbleView.tableFooterView = UIView.init(frame: CGRect(origin: .zero, size: .zero))
            tbleView.backgroundColor = .white
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        print(self.str_title as Any)
       
        
        
        self.my_profile(loader: "yes")
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
                                
                                if String(self.str_title) == "Hip" {
                                    self.str_value = (dict["body_Hip"] as! String)
                                } else if String(self.str_title) == "Waist" {
                                    self.str_value = (dict["body_Waist"] as! String)
                                } else if String(self.str_title) == "Add calf" {
                                    self.str_value = (dict["body_calf"] as! String)
                                } else if String(self.str_title) == "Add chest" {
                                    self.str_value = (dict["body_chest"] as! String)
                                } else if String(self.str_title) == "Add body fat" {
                                    self.str_value = (dict["body_fat"] as! String)
                                } else if String(self.str_title) == "Add arm - left" {
                                    self.str_value = (dict["body_left_arm"] as! String)
                                } else if String(self.str_title) == "Add arm - Right" {
                                    self.str_value = (dict["body_right_arm"] as! String)
                                } else if String(self.str_title) == "Add thigh" {
                                    self.str_value = (dict["body_thigh"] as! String)
                                } else  {
                                    self.str_value = (dict["target_wight"] as! String)
                                }
                                self.tbleView.delegate = self
                                self.tbleView.dataSource = self
                                self.tbleView.reloadData()
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
    
    @objc func add_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tbleView.cellForRow(at: indexPath) as! edit_logs_table_cell
        
        print(self.str_value as Any)
        
        if self.str_value == nil {
            self.str_value = "0"
        } else if self.str_value == "" {
            self.str_value = "0"
        }
        
        let a: Int? = Int(self.str_value)
        print(a as Any)
        
        if a == nil {
            
        }
        var sum = a
        sum! += 1
        // print(sum as Any)
        
        self.str_value = "\(sum!)"
        
        let c: Int? = Int(self.str_value)
        print(c as Any)
        
        let d: Int? = Int(self.str_value)
        print(d as Any)
        
        if (self.str_value < self.str_value) {
            print("1")
            cell.btn_minus.isHidden = false
        }
        
        self.tbleView.reloadData()
        
    }
    
    @objc func minus_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tbleView.cellForRow(at: indexPath) as! edit_logs_table_cell
        
        let a: Int? = Int(self.str_value)
        print(a as Any)
        
        var minus = a
        if minus != 0 {
            
            cell.btn_minus.isHidden = false
            
            minus! -= 1
            print(minus as Any)
            
            self.str_value = "\(minus!)"
            
            self.tbleView.reloadData()
        }
        
    }
   
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        if let currentText = textField.text as NSString? {
            let updatedText = currentText.replacingCharacters(in: range, with: string)
            //myString = updatedText
            print("Updated string: \(updatedText)")
            self.str_value = "\(updatedText)"
            
        }
        
        return true
    }
    
    @objc func edit_profile_WB() {
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
               
                if (self.str_title == "Add body fat") {
                    parameters = [
                        "action"        : "editprofile",
                        "userId"        : String(myString),
                        "body_fat"    : String(self.str_value),
                    ]
                } else if (self.str_title == "Hip") {
                    parameters = [
                        "action"        : "editprofile",
                        "userId"        : String(myString),
                        "body_Hip"    : String(self.str_value),
                    ]
                } else if (self.str_title == "Waist") {
                    parameters = [
                        "action"        : "editprofile",
                        "userId"        : String(myString),
                        "body_Waist"    : String(self.str_value),
                    ]
                } else if (self.str_title == "Add arm - Right") {
                    parameters = [
                        "action"        : "editprofile",
                        "userId"        : String(myString),
                        "body_right_arm"    : String(self.str_value),
                    ]
                } else if (self.str_title == "Add arm - left") {
                    parameters = [
                        "action"        : "editprofile",
                        "userId"        : String(myString),
                        "body_left_arm"    : String(self.str_value),
                    ]
                } else if (self.str_title == "Add chest") {
                    parameters = [
                        "action"        : "editprofile",
                        "userId"        : String(myString),
                        "body_chest"    : String(self.str_value),
                    ]
                } else if (self.str_title == "Add thigh") {
                    parameters = [
                        "action"        : "editprofile",
                        "userId"        : String(myString),
                        "body_thigh"    : String(self.str_value),
                    ]
                } else if (self.str_title == "Add calf") {
                    parameters = [
                        "action"        : "editprofile",
                        "userId"        : String(myString),
                        "body_calf"    : String(self.str_value),
                    ]
                }
                
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
                            
                            var strSuccessMSG : String!
                            strSuccessMSG = JSON["msg"] as? String
                            
                            if strSuccess.lowercased() == "success" {
                                ERProgressHud.sharedInstance.hide()
                                
                                var dict: Dictionary<AnyHashable, Any>
                                dict = JSON["data"] as! Dictionary<AnyHashable, Any>
                                
                                let defaults = UserDefaults.standard
                                defaults.setValue(dict, forKey: str_save_login_user_data)
                                
                                self.view.makeToast(String(strSuccessMSG))
                                
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
                        
                        self.edit_profile_WB()
                        
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


//MARK:- TABLE VIEW -
extension edit_logs: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:edit_logs_table_cell = tableView.dequeueReusableCell(withIdentifier: "edit_logs_table_cell") as! edit_logs_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        if (self.str_title == "Add body fat") {
            cell.lbl_subtitle.text = "%"
        } else {
            cell.lbl_subtitle.text = "CM"
        }
        
        cell.txt_text.delegate = self
        cell.txt_text.text = String(self.str_value)
        
        cell.lbl_title.text = String(self.str_title)
        cell.lbl_counter.text = String(self.str_value)
        cell.btn_add.addTarget(self, action: #selector(add_click_method), for: .touchUpInside)
        cell.btn_minus.addTarget(self, action: #selector(minus_click_method), for: .touchUpInside)
        cell.btn_save.addTarget(self, action: #selector(edit_profile_WB), for: .touchUpInside)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 228
    }

}
