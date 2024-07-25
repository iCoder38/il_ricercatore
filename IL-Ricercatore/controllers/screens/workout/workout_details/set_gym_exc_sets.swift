//
//  set_gym_exc_sets.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 25/06/24.
//

import UIKit
import Alamofire

class set_gym_exc_sets: UIViewController {
    
    var str_submit_data_type:String!
    
    var str_date:String!
    
    var str_value:String! = "0"
    var dict_get_gym_exc_details:NSDictionary!
    
    var str_store_main_response:String!
    
    var arr_list_value:NSMutableArray! = []
    
    @IBOutlet weak var btn_add:UIButton!
    @IBOutlet weak var btn_minus:UIButton!
    
    @IBOutlet weak var btn_add2:UIButton!
    @IBOutlet weak var btn_minus2:UIButton!
    
    @IBOutlet weak var btn_add3:UIButton!
    @IBOutlet weak var btn_minus3:UIButton!
    
    @IBOutlet weak var btn_add4:UIButton!
    @IBOutlet weak var btn_minus4:UIButton!
    
    @IBOutlet weak var btn_back:UIButton! {
        didSet {
            btn_back.tintColor = .black
            btn_back.setImage(UIImage(systemName: "arrow.left"), for: .normal)
            btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var lbl_navigation_title:UILabel! {
        didSet {
            lbl_navigation_title.text = navigation_title_select_workout_en
        }
    }
    
    @IBOutlet weak var lbl_text: UILabel!
    var count: Int = 0
    
    @IBOutlet weak var lbl_text2: UILabel!
    var count2: Int = 0
    
    @IBOutlet weak var lbl_text3: UILabel!
    var count3: Int = 0
    
    @IBOutlet weak var lbl_text4: UILabel!
    var count4: Int = 0
    
    @IBOutlet weak var view_pop_up_bg:UIView! {
        didSet {
            view_pop_up_bg.layer.cornerRadius = 12
            view_pop_up_bg.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var btn_cancel:UIButton! {
        didSet {
            btn_cancel.layer.cornerRadius = 12
            btn_cancel.clipsToBounds = true
            btn_cancel.setTitle("Cancel", for: .normal)
        }
    }
    
    @IBOutlet weak var btn_submit:UIButton! {
        didSet {
            btn_submit.layer.cornerRadius = 12
            btn_submit.clipsToBounds = true
            btn_submit.setTitle("Submit", for: .normal)
        }
    }
    
    var str_value_one:String! = "0"
    var str_value_two:String! = "0"
    var str_value_3:String! = "0"
    var str_value_4:String! = "0"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.arr_list_value as Any)
        print(self.dict_get_gym_exc_details as Any)
        
        
        
        self.btn_submit.addTarget(self, action: #selector(add_gym_exc), for: .touchUpInside)
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        self.btn_add.addTarget(self, action: #selector(add_click_method), for: .touchUpInside)
        self.btn_minus.addTarget(self, action: #selector(minus_click_method), for: .touchUpInside)
        
        self.btn_add2.addTarget(self, action: #selector(add_click_method2), for: .touchUpInside)
        self.btn_minus2.addTarget(self, action: #selector(minus_click_method2), for: .touchUpInside)
        
        self.btn_add3.addTarget(self, action: #selector(add_click_method3), for: .touchUpInside)
        self.btn_minus3.addTarget(self, action: #selector(minus_click_method3), for: .touchUpInside)
        
        self.btn_add4.addTarget(self, action: #selector(add_click_method4), for: .touchUpInside)
        self.btn_minus4.addTarget(self, action: #selector(minus_click_method4), for: .touchUpInside)
        
        self.btn_cancel.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func add_click_method() {
        count += 1
        lbl_text.text = "\(count)"
        self.str_value_one = "\(count)"
    }
    
    @objc func minus_click_method() {
        if count > 0 {
            count -= 1
            lbl_text.text = "\(count)"
            self.str_value_one = "\(count)"
        }
    }
    
    @objc func add_click_method2() {
        count2 += 1
        lbl_text2.text = "\(count2)"
        self.str_value_two = "\(count2)"
    }
    
    @objc func minus_click_method2() {
        if count2 > 0 {
            count2 -= 1
            lbl_text2.text = "\(count2)"
            self.str_value_two = "\(count2)"
        }
    }
    
    @objc func add_click_method3() {
        count3 += 1
        lbl_text3.text = "\(count3)"
        self.str_value_3 = "\(count3)"
    }
    
    @objc func minus_click_method3() {
        if count3 > 0 {
            count3 -= 1
            lbl_text3.text = "\(count3)"
            self.str_value_3 = "\(count3)"
        }
    }
    
    @objc func add_click_method4() {
        count4 += 1
        lbl_text4.text = "\(count4)"
        self.str_value_4 = "\(count4)"
    }
    
    @objc func minus_click_method4() {
        if count4 > 0 {
            count4 -= 1
            lbl_text4.text = "\(count4)"
            self.str_value_4 = "\(count4)"
        }
    }
   
    @objc func add_gym_exc() {
        
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            print(person as Any)
            
            // current_wight_measurement
            // current_wight
            
            if (person["current_wight_measurement"] as! String == "KG") {
                
                if let weightDouble = Double("\(person["current_wight"]!)") {
                    print("The weight in Double is: \(weightDouble)")
                    // let weightInKg = ConversionUtils.convertLbsToKg(weightDouble)
                    // print(weightInKg as Any)
                    
                    // mit level
                    let MIT_LEVEL = self.str_value_3
                    print(MIT_LEVEL as Any)
                    
                    let SELECTED_MINUTES = self.str_value_4
                    print(SELECTED_MINUTES as Any)
                    
                    if let convertMitStringToDouble = Double(MIT_LEVEL!) {
                        print(convertMitStringToDouble as Any)
                        
                        let MULTIPLE_CONVERTED_MIT = convertMitStringToDouble * 3.5
                        print(MULTIPLE_CONVERTED_MIT as Any)
                        
                        // here we convert minute string into double
                        if let convertMinuteStringToDouble = Double(SELECTED_MINUTES!) {
                            print(convertMinuteStringToDouble as Any)
                            
                            // response * userWeight
                            let RESPONSE_x_USER_WEIGHT_x_MINUTE = MULTIPLE_CONVERTED_MIT * weightDouble * convertMinuteStringToDouble
                            print(RESPONSE_x_USER_WEIGHT_x_MINUTE as Any)
                            
                            // main response / 200
                            let MAIN_RESPONSE = RESPONSE_x_USER_WEIGHT_x_MINUTE / 200
                            print(MAIN_RESPONSE as Any)
                            
                            
                            self.str_store_main_response = "\(MAIN_RESPONSE)"
                        }
                        
                    }
                } else {
                    print("\(person["current_wight"]!)")
                }
                
            } else {
                // LBS
                if let weightDouble = Double("\(person["current_wight"]!)") {
                    print("The weight in Double is: \(weightDouble)")
                    let weightInKg = ConversionUtils.convertLbsToKg(weightDouble)
                    print(weightInKg as Any)
                    
                    
                    // mit level
                    let MIT_LEVEL = self.str_value_3
                    print(MIT_LEVEL as Any)
                    
                    
                    let SELECTED_MINUTES = self.str_value_4
                    print(SELECTED_MINUTES as Any)
                    
                    //
                    if let convertMitStringToDouble = Double(MIT_LEVEL!) {
                        print(convertMitStringToDouble as Any)
                        
                        
                        let MULTIPLE_CONVERTED_MIT = convertMitStringToDouble * 3.5
                        print(MULTIPLE_CONVERTED_MIT as Any)
                        
                        
                        // here we convert minute string into double
                        if let convertMinuteStringToDouble = Double(SELECTED_MINUTES!) {
                            print(convertMinuteStringToDouble as Any)
                            
                            // response * userWeight
                            let RESPONSE_x_USER_WEIGHT_x_MINUTE = MULTIPLE_CONVERTED_MIT * weightInKg * convertMinuteStringToDouble
                            print(RESPONSE_x_USER_WEIGHT_x_MINUTE as Any)
                            
                            // main response / 200
                            let MAIN_RESPONSE = RESPONSE_x_USER_WEIGHT_x_MINUTE / 200
                            print(MAIN_RESPONSE as Any)
                            
                            self.str_store_main_response = "\(MAIN_RESPONSE)"
                        }
                        
                        
                        
                    }
                } else {
                    print("\(person["current_wight"]!)")
                }
            }
            
            
            
            
        }
        
        
        
        
        
        let defaults = UserDefaults.standard
        if let myString = defaults.string(forKey: "key_save_dashboard_right_arrow") {
            print("defaults savedString: \(myString)")
            
            if let myStringgym = defaults.string(forKey: "key_save_gym") {
                print("defaults savedString: \(myStringgym)")
                
                self.add_gym_exc_dashboardRA(loader: "yes")
                return
            }
            
        } else {
            
            self.add_gym_exc_dashboard(loader: "yes")
            return
        }
    }
    
    @objc func add_gym_exc_dashboard(loader:String) {
        self.dismiss(animated: true, completion: nil)
        if (loader == "yes") {
            ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        }
        
        var parameters:Dictionary<AnyHashable, Any>!
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            
            if let token_id_is = UserDefaults.standard.string(forKey: str_save_last_api_token) {
                
                let headers: HTTPHeaders = [
                    "token":String(token_id_is),
                ]
                
                let x : Int = person["userId"] as! Int
                let myString = String(x)
                
                let (_, dayNumber) = getDayNameAndNumber()
                
                
                let custom2: [String: Any] = [
                    "category": self.dict_get_gym_exc_details["category"] as? String ?? "",
                    "equipment": self.dict_get_gym_exc_details["equipment"] as? String ?? "",
                    "force": self.dict_get_gym_exc_details["force"] as? String ?? "",
                    "id": self.dict_get_gym_exc_details["id"] as? String ?? "",
                    "level": self.dict_get_gym_exc_details["level"] as? String ?? "",
                    "mechanic": self.dict_get_gym_exc_details["mechanic"] as? String ?? "",
                    "reps": String(self.str_value_one!),
                    "sets": String(self.str_value_two!),
                    "name":self.dict_get_gym_exc_details["name"] as? String ?? "",
                    "images": self.dict_get_gym_exc_details["images"]!,
                    "instructions": self.dict_get_gym_exc_details["instructions"]!,
                    "DurationINmin":String(self.lbl_text4.text!),
                    "METLevel":String(self.lbl_text3.text!),
                    "burnCalories":String(self.str_store_main_response)
                ]
                
                self.arr_list_value.add(custom2)
                // print(custom2 as Any)
                // print(self.arr_list_value.count as Any)
                
                let immutableArray = NSArray(array: self.arr_list_value)
                // print(immutableArray)
                
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: immutableArray, options: .prettyPrinted)
                    
                    if let jsonString = String(data: jsonData, encoding: .utf8) {
                        print(jsonString)
                        
                        let defaults = UserDefaults.standard
                        if let currentDate = defaults.string(forKey: "key_gym_select_from_dashboard_push") {
                            print("defaults savedString: \(currentDate)")
                            
                            parameters = [
                                "action"                : "myworkoutadd_type",
                                "userId"                : String(myString),
                                "date"                  : String(currentDate),
                                "json_record_details"   : String(jsonString),
                            ]
                        }
                        
                        
                    }
                } catch {
                    print("Error converting to JSON: \(error)")
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
                            
                            if strSuccess.lowercased() == "success" {
                                ERProgressHud.sharedInstance.hide()
                                
                                let defaults = UserDefaults.standard
                                
                                defaults.set(nil, forKey: "key_save_dashboard_right_arrow")
                                defaults.set(nil, forKey: "key_save_aerobics")
                                defaults.set(nil, forKey: "key_save_gym")
                                defaults.set(nil, forKey: "key_save_day")
                                defaults.set(nil, forKey: "key_gym_select_from_dashboard_push")
                                
                                //                                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                //                                let myAlert = storyboard.instantiateViewController(withIdentifier: "dashboard_id") as? dashboard
                                //
                                //                                myAlert!.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                                //                                myAlert!.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                                //                                self.navigationController?.pushViewController(myAlert!, animated: true)
                                let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "dashboard_id") as? dashboard
                                self.navigationController?.pushViewController(push!, animated: true)
                                
                            } else {
                                if (JSON["msg"] as? String == your_are_not_auth) {
                                    TokenManager.shared.refresh_token_WB { token, error in
                                        if let token = token {
                                            print("Token received: \(token)")
                                            
                                            let str_token = "\(token)"
                                            UserDefaults.standard.set("", forKey: str_save_last_api_token)
                                            UserDefaults.standard.set(str_token, forKey: str_save_last_api_token)
                                            
                                            self.add_gym_exc_dashboard(loader: "no")
                                            
                                        } else if let error = error {
                                            print("Failed to refresh token: \(error.localizedDescription)")
                                            // Handle the error
                                        }
                                    }
                                } else {
                                    self.view.makeToast(JSON["msg"] as? String)
                                }
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
                TokenManager.shared.refresh_token_WB { token, error in
                    if let token = token {
                        print("Token received: \(token)")
                        
                        let str_token = "\(token)"
                        UserDefaults.standard.set("", forKey: str_save_last_api_token)
                        UserDefaults.standard.set(str_token, forKey: str_save_last_api_token)
                        
                        self.add_gym_exc_dashboard(loader: "no")
                        
                    } else if let error = error {
                        print("Failed to refresh token: \(error.localizedDescription)")
                        // Handle the error
                    }
                }
            }
        }
    }
    
    @objc func add_gym_exc_dashboardRA(loader:String) {
        self.dismiss(animated: true, completion: nil)
        if (loader == "yes") {
            ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        }
        
        var parameters:Dictionary<AnyHashable, Any>!
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            
            if let token_id_is = UserDefaults.standard.string(forKey: str_save_last_api_token) {
                
                let headers: HTTPHeaders = [
                    "token":String(token_id_is),
                ]
                
                let x : Int = person["userId"] as! Int
                let myString = String(x)
                
                let defaults = UserDefaults.standard
                if let myString2 = defaults.string(forKey: "key_save_day") {
                    print("defaults savedString: \(myString2)")
                    
                    parameters = [
                        "action"            : "day_wise_excercise_add",
                        "userId"            : String(myString),
                        "day"               : String(myString2),
                        "excercise_name"    : (self.dict_get_gym_exc_details["name"] as! String),
                        "excercise_id"      : (self.dict_get_gym_exc_details["id"] as! String),
                        "excercise_type"    : "2",
                        "reps"              : String(self.str_value_one),
                        "sets"              : String(self.str_value_two),
                        
                    ]
                     
                } else {
                    parameters = [
                        "action"            : "day_wise_excercise_add",
                        "userId"            : String(myString),
                        "day"               : String(self.str_date),
                        "excercise_name"    : (self.dict_get_gym_exc_details["name"] as! String),
                        "excercise_id"      : (self.dict_get_gym_exc_details["id"] as! String),
                        "excercise_type"    : "2",
                        "reps"              : String(self.str_value_one),
                        "sets"              : String(self.str_value_two),
                        
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
                            
                            if strSuccess.lowercased() == "success" {
                                ERProgressHud.sharedInstance.hide()
                                
                                let defaults = UserDefaults.standard
                                
                                defaults.set(nil, forKey: "key_save_dashboard_right_arrow")
                                defaults.set(nil, forKey: "key_save_aerobics")
                                defaults.set(nil, forKey: "key_save_gym")
                                defaults.set(nil, forKey: "key_save_day")
                                
                                let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "dashboard_id") as? dashboard
                                self.navigationController?.pushViewController(push!, animated: true)
                                
                            } else {
                                if (JSON["msg"] as? String == your_are_not_auth) {
                                    TokenManager.shared.refresh_token_WB { token, error in
                                        if let token = token {
                                            print("Token received: \(token)")
                                            
                                            let str_token = "\(token)"
                                            UserDefaults.standard.set("", forKey: str_save_last_api_token)
                                            UserDefaults.standard.set(str_token, forKey: str_save_last_api_token)
                                            
                                            self.add_gym_exc_dashboardRA(loader: "no")
                                            
                                        } else if let error = error {
                                            print("Failed to refresh token: \(error.localizedDescription)")
                                            // Handle the error
                                        }
                                    }
                                } else {
                                    self.view.makeToast(JSON["msg"] as? String)
                                }
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
                TokenManager.shared.refresh_token_WB { token, error in
                    if let token = token {
                        print("Token received: \(token)")
                        
                        let str_token = "\(token)"
                        UserDefaults.standard.set("", forKey: str_save_last_api_token)
                        UserDefaults.standard.set(str_token, forKey: str_save_last_api_token)
                        
                        self.add_gym_exc_dashboard(loader: "no")
                        
                    } else if let error = error {
                        print("Failed to refresh token: \(error.localizedDescription)")
                        // Handle the error
                    }
                }
            }
        }
    }
}
