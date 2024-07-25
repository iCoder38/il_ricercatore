//
//  goal_settings_water.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 04/04/24.
//

import UIKit
import Alamofire

class goal_settings_water: UIViewController, UITextFieldDelegate {
    
    var str_value:String!
    // var str_total_water_count:String!
    
    var type:String!
    
    @IBOutlet weak var btn_back:UIButton! {
        didSet {
            btn_back.tintColor = .white
            btn_back.setImage(UIImage(systemName: "arrow.left"), for: .normal)
            btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        }
    }
    @IBOutlet weak var btn_reset:UIButton! {
        didSet {
            btn_reset.layer.cornerRadius = 8
            btn_reset.clipsToBounds = true
            // btn_reset.setTitle("reset", for: .normal)
            btn_reset.setTitleColor(.white, for: .normal)
        }
    }
    @IBOutlet weak var lbl_navigation_title:UILabel! {
        didSet {
            
            if (type == "step") {
                lbl_navigation_title.text = "Edit Step Goals"
            } else {
                lbl_navigation_title.text = navigation_title_water_intake_en
            }
            
        }
    }
    
    @IBOutlet weak var tble_view:UITableView! {
        didSet {
            tble_view.delegate = self
            tble_view.dataSource = self
            tble_view.layer.cornerRadius = 22
            tble_view.clipsToBounds = true
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tble_view.separatorColor = .white
        
         
         btn_reset.addTarget(self, action: #selector(edit_calorie_budget_click_method), for: .touchUpInside)
        
    }
    
    @objc func edit_calorie_budget_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "water_reminder_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    @objc func add_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! goal_settings_water_table_cell
        
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
        
        if (self.str_value < self.str_value){
            print("1")
            cell.btn_minus_steps.isHidden = false
        }
        
        self.tble_view.reloadData()
        
    }
    
    @objc func minus_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! goal_settings_water_table_cell
        
        let a: Int? = Int(self.str_value)
        print(a as Any)
        
        var minus = a
        if minus != 0 {
            if String(self.type) == "water" {
                cell.btn_minus.isHidden = false
            } else if String(self.type) == "step" {
                cell.btn_minus_steps.isHidden = false
            }
            
            
            minus! -= 1
            print(minus as Any)
            
            self.str_value = "\(minus!)"
            
            self.tble_view.reloadData()
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            
            print("Updated string: \(text)")
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let currentText = textField.text as NSString? {
            let updatedText = currentText.replacingCharacters(in: range, with: string)
            self.str_value = updatedText
            print(self.str_value as Any)
        }
        return true
    }
    
    @objc func add_one_item_WB(loader:String,key:String,value:String) {
        // let indexPath = IndexPath.init(row: 0, section: 0)
        // let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_table_cell
        
        var parameters:Dictionary<AnyHashable, Any>!
        
        if (loader == "yes") {
            ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
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
                    "action"        : "editprofile",
                    "userId"        : String(myString),
                    String(key)     : String(value),
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
                                
                                self.view.makeToast("Saved")
                                
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
                        
                        if String(self.type) == "water" {
                            self.add_one_item_WB(loader: "no", key: "water_goal", value: String(self.str_value))
                        } else if String(self.type) == "step" {
                            self.add_one_item_WB(loader: "no", key: "step_goal", value: String(self.str_value))
                        } else {
                            self.add_one_item_WB(loader: "no", key: "nutrition_goal", value: String(self.str_value))
                        }
                        
                        
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
extension goal_settings_water: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if String(self.type) == "water" {
            let cell:goal_settings_water_table_cell = tableView.dequeueReusableCell(withIdentifier: "goal_settings_water_table_cell") as! goal_settings_water_table_cell
            
            cell.backgroundColor = .clear
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            
            if self.str_value == nil {
                cell.lbl_water_count.text = "0"
            } else if self.str_value == "" {
                cell.lbl_water_count.text = "0"
            } else {
                cell.lbl_water_count.text = String(self.str_value)
            }
            
            
            cell.btn_add.addTarget(self, action: #selector(add_click_method), for: .touchUpInside)
            cell.btn_minus.addTarget(self, action: #selector(minus_click_method), for: .touchUpInside)
            
            cell.btn_save.addTarget(self, action: #selector(save_click_method), for: .touchUpInside)
            return cell
        } else if String(self.type) == "step" {
            let cell:goal_settings_water_table_cell = tableView.dequeueReusableCell(withIdentifier: "goal_settings_steps_table_cell") as! goal_settings_water_table_cell
            
            cell.backgroundColor = .clear
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            
            cell.txt_field_data.delegate = self
            
            if self.str_value == nil {
                cell.txt_field_data.text = "0"
            } else if self.str_value == "" {
                cell.txt_field_data.text = "0"
            } else {
                cell.txt_field_data.text = String(self.str_value)
            }
            
            
            
            cell.btn_add_steps.addTarget(self, action: #selector(add_click_method), for: .touchUpInside)
            cell.btn_minus_steps.addTarget(self, action: #selector(minus_click_method), for: .touchUpInside)
            
            cell.btn_save_steps.addTarget(self, action: #selector(save_click_method), for: .touchUpInside)
            return cell
        } else {
            let cell:goal_settings_water_table_cell = tableView.dequeueReusableCell(withIdentifier: "goal_settings_nut_table_cell") as! goal_settings_water_table_cell
            
            cell.backgroundColor = .clear
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            
            if self.str_value == nil {
                cell.lbl_water_count_nut.text = "0"
            } else if self.str_value == "" {
                cell.lbl_water_count_nut.text = "0"
            } else {
                cell.lbl_water_count_nut.text = String(self.str_value)
            }
            
            
            cell.btn_add_nut.addTarget(self, action: #selector(add_click_method), for: .touchUpInside)
            cell.btn_minus_nut.addTarget(self, action: #selector(minus_click_method), for: .touchUpInside)
            
            cell.btn_save_nut.addTarget(self, action: #selector(save_click_method), for: .touchUpInside)
            return cell
        }
        
        
        
    }
    
    @objc func  save_click_method() {
        if String(self.type) == "water" {
            self.add_one_item_WB(loader: "yes", key: "water_goal", value: String(self.str_value))
        } else if String(self.type) == "step" {
            self.add_one_item_WB(loader: "yes", key: "step_goal", value: String(self.str_value))
        } else {
            self.add_one_item_WB(loader: "yes", key: "nutrition_goal", value: String(self.str_value))
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 292
    }
    
}

