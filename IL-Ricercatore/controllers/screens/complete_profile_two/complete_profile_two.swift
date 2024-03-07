//
//  complete_profile_two.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 16/12/23.
//

import UIKit
import Alamofire

class complete_profile_two: UIViewController, UITextFieldDelegate {
    
    var str_general_fitness_index = 0
    var str_special_option_index = 0
    
    var str_medicine_status:String! = ""
    var str_smoke_status:String! = ""
    var str_drink_status:String! = ""
    
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
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.tble_view.separatorColor = .white
        
          // self.general_WB()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let loadedString = UserDefaults.standard.string(forKey: "key_save_all_selected_disease") {
            print(loadedString)
            
            let indexPath = IndexPath.init(row: 0, section: 0)
            let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_two_table_cell
            
            cell.lbl_diseases_names.isHidden = false
            
            cell.txt_select_option.text = " "
            cell.lbl_diseases_names.text = String(loadedString)
            
            if (loadedString == "") {
                cell.btn_clear.isHidden = true
            } else {
                cell.btn_clear.isHidden = false
            }
            
            cell.btn_clear.addTarget(self, action: #selector(clear_click_method), for: .touchUpInside)
            
            UserDefaults.standard.removeObject(forKey: "key_save_all_selected_disease")
            
        } else {
            print("NO DISEASE SELECTED")
        }
        
    }
    
    @objc func clear_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_two_table_cell
        
        cell.txt_select_option.placeholder = "Select Option"
        cell.lbl_diseases_names.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("me call")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        print("me call 2")
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    /*@objc func male_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_table_cell
        
        cell.btn_male.setBackgroundImage(UIImage(named: "blue"), for: .normal)
        cell.btn_female.setBackgroundImage(UIImage(named: ""), for: .normal)
        cell.btn_other.setBackgroundImage(UIImage(named: ""), for: .normal)
        
        cell.btn_male.setTitleColor(.white, for: .normal)
        cell.btn_female.setTitleColor(.black, for: .normal)
        cell.btn_other.setTitleColor(.black, for: .normal)
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
        
    }*/
    
    
    
    @objc func fitness_goal_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_two_table_cell
        
        let dummyList = ["Shedding fat","Building muscles","Improving endurance","Increasing flexibility","Toning","General fitness"]
        RPicker.selectOption(title: "Select", cancelText: "Cancel", dataArray: dummyList, selectedIndex: self.str_general_fitness_index) { (selctedText, atIndex) in
             
             self.str_general_fitness_index = atIndex
            
            cell.txt_fitness_goal.text = String(selctedText)
            
        }
        
    }
    
    @objc func special_option_click_method() {
//        let indexPath = IndexPath.init(row: 0, section: 0)
//        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_two_table_cell
        
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "disease_list_id") as? disease_list
        self.navigationController?.pushViewController(push!, animated: false)
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let myAlert = storyboard.instantiateViewController(withIdentifier: "disease_list_id") as? disease_list
//        // myAlert!.dict_booking_details = self.get_booking_data_for_pickup
//        myAlert!.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//        myAlert!.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
//        present(myAlert!, animated: true, completion: nil)
        
        /*let dummyList = ["Diabetes",
                         "Pre-diabetes",
                         "Hypertension",
                         "Obesity",
                         "Thyroid",
                         "PCOD",
                         "Asthma",
                         "Heart attack and stroke",
                         "Kidney Disease",
        
        ]
        
        RPicker.selectOption(title: "Select", cancelText: "Cancel", dataArray: dummyList, selectedIndex: self.str_special_option_index) { (selctedText, atIndex) in
             
             self.str_special_option_index = atIndex
            
            cell.txt_select_option.text = String(selctedText)
            
        }*/
    }
    
    @objc func medicine_yes_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_two_table_cell
        
        cell.btn_medicine_yes.setImage(UIImage(named: "check"), for: .normal)
        cell.btn_medicine_no.setImage(UIImage(named: "uncheck"), for: .normal)
        
        self.str_medicine_status = "1"
    }
    
    @objc func medicine_no_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_two_table_cell
        
        cell.btn_medicine_no.setImage(UIImage(named: "check"), for: .normal)
        cell.btn_medicine_yes.setImage(UIImage(named: "uncheck"), for: .normal)
        
        self.str_medicine_status = "0"
    }
    
    // smoke
    @objc func smoke_yes_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_two_table_cell
        
        cell.btn_smoke_yes.setImage(UIImage(named: "check"), for: .normal)
        cell.btn_smoke_no.setImage(UIImage(named: "uncheck"), for: .normal)
        cell.btn_smoke_occasionally.setImage(UIImage(named: "uncheck"), for: .normal)
        
        self.str_smoke_status = "1"
    }
    
    @objc func smoke_no_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_two_table_cell
        
        cell.btn_smoke_yes.setImage(UIImage(named: "uncheck"), for: .normal)
        cell.btn_smoke_no.setImage(UIImage(named: "check"), for: .normal)
        cell.btn_smoke_occasionally.setImage(UIImage(named: "uncheck"), for: .normal)
        
        self.str_smoke_status = "0"
    }
    @objc func smoke_occasionally_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_two_table_cell
        
        cell.btn_smoke_yes.setImage(UIImage(named: "uncheck"), for: .normal)
        cell.btn_smoke_no.setImage(UIImage(named: "uncheck"), for: .normal)
        cell.btn_smoke_occasionally.setImage(UIImage(named: "check"), for: .normal)
        
        self.str_smoke_status = "2"
    }
    
    // drink
    @objc func drink_yes_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_two_table_cell
        
        cell.btn_drink_yes.setImage(UIImage(named: "check"), for: .normal)
        cell.btn_drink_no.setImage(UIImage(named: "uncheck"), for: .normal)
        cell.btn_drink_occasionally.setImage(UIImage(named: "uncheck"), for: .normal)
        
        self.str_drink_status = "1"
    }
    
    @objc func drink_no_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_two_table_cell
        
        cell.btn_drink_yes.setImage(UIImage(named: "uncheck"), for: .normal)
        cell.btn_drink_no.setImage(UIImage(named: "check"), for: .normal)
        cell.btn_drink_occasionally.setImage(UIImage(named: "uncheck"), for: .normal)
        
        self.str_drink_status = "0"
    }
    @objc func drink_occasionally_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_two_table_cell
        
        cell.btn_drink_yes.setImage(UIImage(named: "uncheck"), for: .normal)
        cell.btn_drink_no.setImage(UIImage(named: "uncheck"), for: .normal)
        cell.btn_drink_occasionally.setImage(UIImage(named: "check"), for: .normal)
        
        self.str_drink_status = "2"
    }
    
    
    @objc func general_WB() {
     
        var parameters:Dictionary<AnyHashable, Any>!
        
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
       
        parameters = [
            "action"            : "general",
            
        ]
        
        print("parameters-------\(String(describing: parameters))")
        
        AF.request(application_base_url, method: .post, parameters: parameters as? Parameters ).responseJSON {
            response in
            
            switch(response.result) {
            case .success(_):
                if let data = response.value {
                    
                    let JSON = data as! NSDictionary
                    print(JSON)
                    
                     var strSuccess : String!
                     strSuccess = JSON["status"] as? String
                    
//                    var ar : NSArray!
//                    ar = (JSON["home"] as! Array<Any>) as NSArray
//                    print(ar as Any)
                    // self.arr_address_list.addObjects(from: ar as! [Any])
                    
                    if strSuccess.lowercased() == "success" {
                        ERProgressHud.sharedInstance.hide()
                       
                        
                    }
                    else {
                         
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
    
    @objc func complete_profile_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_two_table_cell
        
        if (cell.txt_fitness_goal.text == "") {
            self.alert_show_error(field_name: "Fitness Goal")
        } else {
            self.create_an_account(loader: "yes")
        }
        
        
    }
    @objc func create_an_account(loader:String) {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_two_table_cell
        
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
                
                parameters = [
                    "action"            : "editprofile",
                    "userId"            : String(myString),
                    "Fitness_goal"      : String(cell.txt_fitness_goal.text!),
                    "disease"           : String(cell.lbl_diseases_names.text!),
                    "medicine_take"     : String(self.str_medicine_status),
                    "smoke"             : String(self.str_smoke_status),
                    "drink"             : String(self.str_drink_status),
                    
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
                                
                                let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "complete_profile_three_id")
                                self.navigationController?.pushViewController(push, animated: true)
                                
                                
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
}

//MARK:- TABLE VIEW -
extension complete_profile_two: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:complete_profile_two_table_cell = tableView.dequeueReusableCell(withIdentifier: "complete_profile_two_table_cell") as! complete_profile_two_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        cell.txt_fitness_goal.delegate = self
        cell.txt_select_option.delegate = self
        
        cell.btn_continue.addTarget(self, action: #selector(complete_profile_click_method), for: .touchUpInside)
        cell.btn_fitness_goal.addTarget(self, action: #selector(fitness_goal_click_method), for: .touchUpInside)
        cell.btn_select_option.addTarget(self, action: #selector(special_option_click_method), for: .touchUpInside)
        
        cell.btn_medicine_yes.addTarget(self, action: #selector(medicine_yes_click_method), for: .touchUpInside)
        cell.btn_medicine_no.addTarget(self, action: #selector(medicine_no_click_method), for: .touchUpInside)
        
        cell.btn_smoke_yes.addTarget(self, action: #selector(smoke_yes_click_method), for: .touchUpInside)
        cell.btn_smoke_no.addTarget(self, action: #selector(smoke_no_click_method), for: .touchUpInside)
        cell.btn_smoke_occasionally.addTarget(self, action: #selector(smoke_occasionally_click_method), for: .touchUpInside)
        
        cell.btn_drink_yes.addTarget(self, action: #selector(drink_yes_click_method), for: .touchUpInside)
        cell.btn_drink_no.addTarget(self, action: #selector(drink_no_click_method), for: .touchUpInside)
        cell.btn_drink_occasionally.addTarget(self, action: #selector(drink_occasionally_click_method), for: .touchUpInside)
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 510
    }

}
