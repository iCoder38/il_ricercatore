//
//  complete_profile.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 16/12/23.
//

import UIKit
import Alamofire

class complete_profile: UIViewController, UITextFieldDelegate {
    
    var dict_get_user_full_data:NSDictionary!
    
    var str_height:String! = "0"
    
    var str_current_weight:String! = "0"
    var str_target_weight:String! = "0"
    
    var activity:NSMutableArray! = []
    var activity2 = [String]()
    var ar : NSArray!
    
    @IBOutlet weak var btn_back:UIButton! {
        didSet {
            btn_back.isHidden = true
            btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        }
    }
    @IBOutlet weak var tble_view:UITableView! {
        didSet {
            
            tble_view.layer.cornerRadius = 22
            tble_view.clipsToBounds = true
        }
    }
    
    var str_gender_select:String! = ""
    
    var height_drop_down_select_index = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.tble_view.separatorColor = .white
        
        self.general_WB()
        
        
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
                    
                    self.ar = (JSON["Daily_Activity"] as! Array<Any>) as NSArray
                    self.activity.addObjects(from: ar as! [Any])
                     
                    ERProgressHud.sharedInstance.hide()
                    self.parse_data_for_edit()
                }
                
            case .failure(_):
                print("Error message:\(String(describing: response.error))")
                ERProgressHud.sharedInstance.hide()
                self.please_check_your_internet_connection()
                
                break
            }
        }
    }
    
    @objc func parse_data_for_edit() {
        if (self.dict_get_user_full_data != nil) {
            btn_back.isHidden = false
            print(self.dict_get_user_full_data as Any)
            
            self.tble_view.delegate = self
            self.tble_view.dataSource = self
            self.tble_view.reloadData()
            
            let indexPath = IndexPath.init(row: 0, section: 0)
            let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_table_cell
            
            cell.txt_age.text = (self.dict_get_user_full_data["dob"] as! String)
            cell.txt_height.text = (self.dict_get_user_full_data["height"] as! String)
            cell.txt_current_weight.text = "\(self.dict_get_user_full_data["current_wight"]!)"
            cell.txt_target_weight.text = "\(self.dict_get_user_full_data["target_wight"]!)"
            cell.txt_daily_activity.text = "\(self.dict_get_user_full_data["daily_activity"]!)"
            
            if (self.dict_get_user_full_data["gender"] as! String) == "Female" {
                self.str_gender_select = "Female"
                // cell.btn_male.setBackgroundImage(UIImage(named: ""), for: .normal)
                cell.btn_female.setBackgroundImage(UIImage(named: "blue"), for: .normal)
                // cell.btn_other.setBackgroundImage(UIImage(named: ""), for: .normal)
             
                cell.btn_male.setTitleColor(.black, for: .normal)
                cell.btn_female.setTitleColor(.white, for: .normal)
                cell.btn_other.setTitleColor(.black, for: .normal)
            } else if (self.dict_get_user_full_data["gender"] as! String) == "Male" {
                self.str_gender_select = "Male"
                cell.btn_male.setBackgroundImage(UIImage(named: "blue"), for: .normal)
                // cell.btn_female.setBackgroundImage(UIImage(named: ""), for: .normal)
                // cell.btn_other.setBackgroundImage(UIImage(named: ""), for: .normal)
                
                cell.btn_male.setTitleColor(.white, for: .normal)
                cell.btn_female.setTitleColor(.black, for: .normal)
                cell.btn_other.setTitleColor(.black, for: .normal)
            } else {
                self.str_gender_select = "Other"
                // cell.btn_male.setBackgroundImage(UIImage(named: ""), for: .normal)
                // cell.btn_female.setBackgroundImage(UIImage(named: ""), for: .normal)
                cell.btn_other.setBackgroundImage(UIImage(named: "blue"), for: .normal)
                
                cell.btn_male.setTitleColor(.black, for: .normal)
                cell.btn_female.setTitleColor(.black, for: .normal)
                cell.btn_other.setTitleColor(.white, for: .normal)
            }
            
            if (self.dict_get_user_full_data["height_measurement"] as! String) == "ft&in" {
                self.str_height = "0"
                cell.lbl_height_message.text = "Click for cm"
            } else {
                self.str_height = "1"
                cell.lbl_height_message.text = "Click for ft & in"
            }
            
            
            // current weight
            if (self.dict_get_user_full_data["current_wight_measurement"] as! String) == "KG" {
                self.str_current_weight = "1"
                cell.lbl_current_weight_message.text = "Click for LBS"
                cell.lbl_current_weight_text.text = "LBS"
            } else {
                self.str_current_weight = "0"
                cell.lbl_current_weight_message.text = "Click for KG"
                cell.lbl_current_weight_text.text = "KG"
            }
            
            // target weight
            if (self.dict_get_user_full_data["target_wight_measurement"] as! String) == "KG" {
                self.str_target_weight = "1"
                cell.lbl_target_weight_message.text = "Click for LBS"
                cell.lbl_target_weight_text.text = "LBS"
            } else {
                self.str_target_weight = "0"
                cell.lbl_target_weight_message.text = "Click for KG"
                cell.lbl_target_weight_text.text = "KG"
            }
            
        } else {
            self.tble_view.delegate = self
            self.tble_view.dataSource = self
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    @objc func male_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_table_cell
        
        cell.btn_male.setBackgroundImage(UIImage(named: "blue"), for: .normal)
        cell.btn_female.setBackgroundImage(UIImage(named: ""), for: .normal)
        cell.btn_other.setBackgroundImage(UIImage(named: ""), for: .normal)
        
        cell.btn_male.setTitleColor(.white, for: .normal)
        cell.btn_female.setTitleColor(.black, for: .normal)
        cell.btn_other.setTitleColor(.black, for: .normal)
        
        self.str_gender_select = "Male"
    }
    
    @objc func female_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_table_cell
        
        cell.btn_male.setBackgroundImage(UIImage(named: ""), for: .normal)
        cell.btn_female.setBackgroundImage(UIImage(named: "blue"), for: .normal)
        cell.btn_other.setBackgroundImage(UIImage(named: ""), for: .normal)
     
        cell.btn_male.setTitleColor(.black, for: .normal)
        cell.btn_female.setTitleColor(.white, for: .normal)
        cell.btn_other.setTitleColor(.black, for: .normal)
        
        self.str_gender_select = "Female"
    }
    
    @objc func other_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_table_cell
        
        cell.btn_male.setBackgroundImage(UIImage(named: ""), for: .normal)
        cell.btn_female.setBackgroundImage(UIImage(named: ""), for: .normal)
        cell.btn_other.setBackgroundImage(UIImage(named: "blue"), for: .normal)
        
        cell.btn_male.setTitleColor(.black, for: .normal)
        cell.btn_female.setTitleColor(.black, for: .normal)
        cell.btn_other.setTitleColor(.white, for: .normal)
        
        self.str_gender_select = "Other"
    }
    
    @objc func complete_profile_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_table_cell
        
        if (self.str_gender_select == "") {
            self.alert_show_error(field_name: "Gender")
        } else if (cell.txt_age.text == "") {
            self.alert_show_error(field_name: "Age")
        }else if (cell.txt_daily_activity.text == "") {
            self.alert_show_error(field_name: "Daily Activity")
        }else if (cell.txt_height.text == "") {
            self.alert_show_error(field_name: "Height")
        }else if (cell.txt_current_weight.text == "") {
            self.alert_show_error(field_name: "Current Weight")
        }else if (cell.txt_target_weight.text == "") {
            self.alert_show_error(field_name: "Target Weight")
        } else {
            self.create_an_account(loader: "yes")
        }
    }
    
    @objc func daily_activity_click_method() {
        
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_table_cell
        
        // Array to store the names
        var names: [String] = []

        // Safely unwrap and cast the NSMutableArray
        if let array = self.activity as? [[String: Any]] {
            // Iterate over the array of dictionaries
            for item in array {
                // Safely extract the name value
                if let name = item["name"] as? String {
                    names.append(name)
                    print(names)
                } else {
                    print("Invalid data in dictionary")
                }
            }
            
            // Print the names array to verify the result
            print(names)
            
            RPicker.selectOption(title: "Select", cancelText: "Cancel", dataArray: names, selectedIndex: 0) { (selctedText, atIndex) in
                cell.txt_daily_activity.text = String(selctedText)
            }
            
        } else {
            print("Failed to cast objcArray to array of dictionaries")
        }
            
    }
    
    @objc func height_click_method() {
        
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_table_cell
        
        let dummyList = [
            "4 ft 0 inch",
            "4 ft 1 inch",
            "4 ft 2 inch",
            "4 ft 3 inch",
            "4 ft 4 inch",
            "4 ft 5 inch",
            "4 ft 6 inch",
            "4 ft 7 inch",
            "4 ft 8 inch",
            "4 ft 9 inch",
            "4 ft 10 inch",
            "4 ft 11 inch",
            "5 ft 0 inch",
            "5 ft 1 inch",
            "5 ft 2 inch",
            "5 ft 3 inch",
            "5 ft 4 inch",
            "5 ft 5 inch",
            "5 ft 6 inch",
            "5 ft 7 inch",
            "5 ft 8 inch",
            "5 ft 9 inch",
            "5 ft 10 inch",
            "5 ft 11 inch",
            "6 ft 0 inch",
            "6 ft 1 inch",
            "6 ft 2 inch",
            "6 ft 3 inch",
            "6 ft 4 inch",
            "6 ft 5 inch",
            "6 ft 6 inch",
            "6 ft 7 inch",
            "6 ft 8 inch",
            "6 ft 9 inch",
            "6 ft 10 inch",
            "6 ft 11 inch",
        
        ]
        
        RPicker.selectOption(title: "Select", cancelText: "Cancel", dataArray: dummyList, selectedIndex: self.height_drop_down_select_index) { (selctedText, atIndex) in
             
            self.height_drop_down_select_index = atIndex
            
            cell.txt_height.text = String(selctedText)
            
        }
        
    }
    
    @objc func create_an_account(loader:String) {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_table_cell
        
        var parameters:Dictionary<AnyHashable, Any>!
        
        if (loader == "yes") {
            ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        }
        
        /*
         action:editprofile
         userId:
         gender:
         dob:
         address:
         zipCode:
         deviceToken
         device:
         daily_activity:
         height:
         height_magerment:
         current_wight:
         current_wight_magerment:
         target_wight:
         target_wight_magerment:
         Fitness_goal:
         disease:
         medicine_take:
         smoke:
         drink:
         food_preference:
         breakfast:
         breakfast_time:
         morning_snack:
         morning_snack_time:
         lunch:
         lunch_time:
         evening_snack:
         evening_snack_time:
         dinner:
         dinner_time:
         */
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            print(person)
            
            let x : Int = person["userId"] as! Int
            let myString = String(x)
            
            if let token_id_is = UserDefaults.standard.string(forKey: str_save_last_api_token) {
                
                let headers: HTTPHeaders = [
                    "token":String(token_id_is),
                ]
                
                //
                
                parameters = [
                    "action"            : "editprofile",
                    "userId"            : String(myString),
                    "dob"               : String(cell.txt_age.text!),
                    "gender"            : String(self.str_gender_select),
                    "daily_activity"    : String(cell.txt_daily_activity.text!),
                    "height"            : String(cell.txt_height.text!),
                    "current_wight"     : String(cell.txt_current_weight.text!),
                    "target_wight"      : String(cell.txt_target_weight.text!),
                    "height_magerment"  : String(cell.lbl_height_select_popup.text!),
                    "current_wight_magerment"  : String(cell.lbl_current_weight_text.text!),
                    "target_wight_magerment"  : String(cell.lbl_target_weight_text.text!)
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
                                
                                
                                 if (self.dict_get_user_full_data == nil) {
                                     let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "complete_profile_two_id") as? complete_profile_two
                                     self.navigationController?.pushViewController(push!, animated: true)
                                 } else {
                                     DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                         let actionSheet = NewYorkAlertController(title: "Edit", message: nil, style: .actionSheet)
                                         
                                         let cameraa = NewYorkButton(title: "Disease / Medicine / Smoke / Drink", style: .default) { _ in
                                             
                                             let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "complete_profile_two_id") as? complete_profile_two
                                             push!.dict_get_data = self.dict_get_user_full_data
                                             self.navigationController?.pushViewController(push!, animated: true)
                                             
                                         }
                                         
                                         let cancel = NewYorkButton(title: "Cancel", style: .cancel)
                                         actionSheet.addButtons([cameraa, cancel])
                                         self.present(actionSheet, animated: true)
                                     }
                                 }
                                
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
                        
                        self.create_an_account(loader: "no")
                        
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
    
    
    @objc func height_pop_up_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_table_cell
        
        if (self.str_height == "0") {
            self.str_height = "1"
            cell.lbl_height_select_popup.text = "cm"
            cell.btn_height.isHidden = true
            
            cell.txt_height.text = ""
            cell.lbl_height_message.text = "Click for ft & in"
            
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            
        } else {
            self.str_height = "0"
            cell.lbl_height_select_popup.text = "ft & in"
            cell.btn_height.isHidden = false
            
            cell.lbl_height_message.text = ""
            
            cell.txt_height.text = ""
            cell.lbl_height_message.text = "Click for cm"
            
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            
        }
        
        self.tble_view.reloadData()
    }
    
    @objc func current_weight_pop_up_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_table_cell
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        
        if (self.str_current_weight == "0") {
            self.str_current_weight = "1"
            
            cell.lbl_current_weight_message.text = "Click for KG"
            cell.lbl_current_weight_text.text = "LBS"
            
            cell.txt_current_weight.placeholder = "Current Weight ( LBS )"
            
        } else {
            self.str_current_weight = "0"
            
            cell.lbl_current_weight_message.text = "Click for LBS"
            cell.lbl_current_weight_text.text = "KG"
            
            cell.txt_current_weight.placeholder = placeholder_current_weight
            
        }
        
    }
    
    @objc func target_weight_pop_up_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_table_cell
        
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        
        if (self.str_target_weight == "0") {
            self.str_target_weight = "1"
            
            cell.lbl_target_weight_message.text = "Click for KG"
            cell.lbl_target_weight_text.text = "LBS"
            
            cell.txt_target_weight.placeholder = "Target Weight ( LBS )"
        } else {
            self.str_target_weight = "0"
            
            cell.lbl_target_weight_message.text = "Click for LBS"
            cell.lbl_target_weight_text.text = "KG"
            
            cell.txt_target_weight.placeholder = placeholder_target_weight
        }
        
    }
    
}

//MARK:- TABLE VIEW -
extension complete_profile: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:complete_profile_table_cell = tableView.dequeueReusableCell(withIdentifier: "complete_profile_table_cell") as! complete_profile_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        cell.btn_male.addTarget(self, action: #selector(male_click_method), for: .touchUpInside)
        cell.btn_female.addTarget(self, action: #selector(female_click_method), for: .touchUpInside)
        cell.btn_other.addTarget(self, action: #selector(other_click_method), for: .touchUpInside)
        
        cell.btn_continue.addTarget(self, action: #selector(complete_profile_click_method), for: .touchUpInside)
        
        cell.btn_daily_activity.addTarget(self, action: #selector(daily_activity_click_method), for: .touchUpInside)
        cell.btn_height.addTarget(self, action: #selector(height_click_method), for: .touchUpInside)
        
        cell.btn_height_select_popup.addTarget(self, action: #selector(height_pop_up_click_method), for: .touchUpInside)
        
        cell.btn_current_weight.addTarget(self, action: #selector(current_weight_pop_up_click_method), for: .touchUpInside)
        cell.btn_target_weight.addTarget(self, action: #selector(target_weight_pop_up_click_method), for: .touchUpInside)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 800
    }

}
