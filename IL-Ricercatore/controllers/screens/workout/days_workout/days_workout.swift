//
//  days_workout.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 20/12/23.
//

import UIKit
import Alamofire

class days_workout: UIViewController {

    
    var str_what_day_user_select:String!
    
    var str_profile_select_from_dashboard:String!
    
    var arr_mut_dashboard_data:NSMutableArray! = []
    
    var workout_id:String!
    
    @IBOutlet weak var view_header:UIView! {
        didSet {
            view_header.backgroundColor = light_purple_color
            view_header.layer.cornerRadius = 8
            view_header.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var btn_date:UIButton!
    
    @IBOutlet weak var lbl_date:UILabel! {
        didSet {
            lbl_date.text = Date.getCurrentDateCustom()
        }
    }
    
    @IBOutlet weak var lbl_days_workout:UILabel! {
        didSet {
            lbl_days_workout.text = ""
        }
    }
    
    @IBOutlet weak var txt_field:UITextField!
    @IBOutlet weak var btn_search:UIButton! {
        didSet {
            btn_search.addTarget(self, action: #selector(search_click_method), for: .touchUpInside)
        }
    }
    
    var str_total_exc:String!
    
    @IBOutlet weak var lbl_navigation_title:UILabel! {
        didSet {
            lbl_navigation_title.text = navigation_title_workout_day_en
        }
    }
    
    @IBOutlet weak var tble_view:UITableView! {
        didSet {
            tble_view.layer.cornerRadius = 22
            tble_view.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var btn_add:UIButton!
    
    @IBOutlet weak var btn_menu:UIButton! {
        didSet {
            btn_menu.tintColor = .white
            btn_menu.setImage(UIImage(systemName: "arrow.left"), for: .normal)
            btn_menu.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        }
    }
    
    var day_number:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tble_view.separatorColor = .gray
        
        print(self.str_what_day_user_select as Any)
        print(self.str_profile_select_from_dashboard as Any)
        
        if (self.str_profile_select_from_dashboard == "1") {
            self.lbl_navigation_title.text = "Personalized - Workout"
            self.lbl_date.text = Date.getCurrentDateCustom()
        } else if (self.str_profile_select_from_dashboard == "3") {
            
            if (self.str_what_day_user_select != nil) {
                
                if (self.str_what_day_user_select == "1") {
                    self.lbl_navigation_title.text = "Monday - Workout"
                    self.day_number = String(self.str_what_day_user_select)
                } else if (self.str_what_day_user_select == "2") {
                    self.lbl_navigation_title.text = "Tuesday - Workout"
                    self.day_number = String(self.str_what_day_user_select)
                } else if (self.str_what_day_user_select == "3") {
                    self.lbl_navigation_title.text = "Wednesday - Workout"
                    self.day_number = String(self.str_what_day_user_select)
                } else if (self.str_what_day_user_select == "4") {
                    self.lbl_navigation_title.text = "Thursday - Workout"
                    self.day_number = String(self.str_what_day_user_select)
                } else if (self.str_what_day_user_select == "5") {
                    self.lbl_navigation_title.text = "Friday - Workout"
                    self.day_number = String(self.str_what_day_user_select)
                } else if (self.str_what_day_user_select == "6") {
                    self.lbl_navigation_title.text = "Saturday - Workout"
                    self.day_number = String(self.str_what_day_user_select)
                } else {
                    self.lbl_navigation_title.text = "Sunday - Workout"
                    self.day_number = String(self.str_what_day_user_select)
                }
                
            } else {
                let (dayName, dayNumber) = getDayNameAndNumber()
                self.lbl_navigation_title.text = "\(dayName) - Workout"
                self.day_number = "\(dayNumber)"
            }
            
            
        } else {
            
            
            
            
            
            // Get the current date
            let (dayName, dayNumber) = getDayNameAndNumber()
            self.lbl_navigation_title.text = "\(dayName) - Workout"
            self.day_number = "\(dayNumber)"
        }
        
        self.btn_date.addTarget(self, action: #selector(date_click_method), for: .touchUpInside)
        self.btn_add.addTarget(self, action: #selector(add_click_method), for: .touchUpInside)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.arr_mut_dashboard_data.removeAllObjects()
        self.my_profile(loader: "yes")
    }
    
    @objc func add_click_method() {
        if (self.str_profile_select_from_dashboard == "1") {
            
            let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "select_workout_id") as? select_workout
            push!.str_profile_dashboard = String(self.str_profile_select_from_dashboard)
            push!.str_get_date = self.lbl_date.text
            push!.get_details = self.arr_mut_dashboard_data
            push!.exc_type = "1"
            self.navigationController?.pushViewController(push!, animated: true)
            
            
        } else if (self.str_profile_select_from_dashboard == "2") {
            debugPrint(self.str_profile_select_from_dashboard as Any)
            
            let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "select_workout_id") as? select_workout
            push!.str_profile_dashboard = String(self.str_profile_select_from_dashboard)
            push!.str_get_date = self.lbl_date.text
            push!.get_details = self.arr_mut_dashboard_data
            self.navigationController?.pushViewController(push!, animated: true)
            
        } else {
            
            
            if (self.str_what_day_user_select != nil) {
                let defaults = UserDefaults.standard
                defaults.set(self.str_what_day_user_select, forKey: "key_save_day")
                
                let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "type_of_excercise_id") as? type_of_excercise
                push!.str_exc_profile = "2"
                self.navigationController?.pushViewController(push!, animated: true)
            } else {
                let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "type_of_excercise_id") as? type_of_excercise
                push!.str_exc_profile = "2"
                self.navigationController?.pushViewController(push!, animated: true)
            }
            
            
            
            
            /*let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "select_workout_id") as? select_workout
            push!.str_profile_dashboard = "3"
            push!.str_get_date = self.lbl_date.text
            push!.get_details = self.arr_mut_dashboard_data
            self.navigationController?.pushViewController(push!, animated: true)*/
        }
        
    }
    
    @objc func search_click_method() {
        
    }
    
    @objc func date_click_method() {
        RPicker.selectDate(title: "Select date", cancelText: "Cancel", datePickerMode: .date,maxDate: Date.now, didSelectDate: { (selectedDate) in
            self.lbl_date.text = selectedDate.dateString("yyyy-MM-dd")
            
            self.my_profile(loader: "yes")
        })
    }
    
    @objc func my_profile(loader:String) {
        
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
                
                if (self.str_profile_select_from_dashboard == "1") {
                    parameters = [
                        "action"    : "myworkoutlist",
                        "userId"    : String(myString),
                        "startDate" : String(self.lbl_date.text!),
                        "enddate"   : String(self.lbl_date.text!),
                    ]
                } else if (self.str_profile_select_from_dashboard == "2") {
                    parameters = [
                        "action"    : "myworkoutlist_type",
                        "userId"    : String(myString),
                        "startDate" : String(self.lbl_date.text!),
                        "enddate"   : String(self.lbl_date.text!),
                    ]
                } else {
                    
                    if (self.str_what_day_user_select != nil) {
                        parameters = [
                            "action"    : "day_wise_excercis_list",
                            "userId"    : String(myString),
                            "day"       : String(self.str_what_day_user_select)
                        ]
                    } else {
                        parameters = [
                            "action"    : "day_wise_excercis_list",
                            "userId"    : String(myString),
                            "day"       : String(self.day_number)
                        ]
                    }
                    
                }
                
                
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
                                
                                var ar : NSArray!
                                ar = (JSON["data"] as! Array<Any>) as NSArray
                                // print(ar as Any)
                                
                                if (self.str_profile_select_from_dashboard == "1") {
                                    self.arr_mut_dashboard_data.removeAllObjects()
                                    
                                    for indexx in 0..<ar.count {
                                        let item2 = ar[indexx] as? [String:Any]
                                        // print(item2 as Any)
                                        
                                        var ar2 : NSArray!
                                        ar2 = (item2!["json_record_details"] as! Array<Any>) as NSArray
                                        // print(ar2 as Any)
                                        // print(ar2.count as Any)
                                        
                                        self.arr_mut_dashboard_data.addObjects(from: ar2 as! [Any])
                                    }
                                    // print(self.self.arr_mut_dashboard_data as Any)
                                    // print(self.self.arr_mut_dashboard_data.count as Any)
                                    
                                } else if (self.str_profile_select_from_dashboard == "2") {
                                    if (ar.count != 0) {
                                        let item2 = ar[0] as? [String:Any]
                                        self.workout_id = "\(item2!["myworkoutId"]!)"
                                        self.arr_mut_dashboard_data.removeAllObjects()
                                        
                                        for indexx in 0..<ar.count {
                                            let item2 = ar[indexx] as? [String:Any]
                                            
                                            
                                            var ar2 : NSArray!
                                            ar2 = (item2!["json_record_details"] as! Array<Any>) as NSArray
                                            
                                            self.arr_mut_dashboard_data.addObjects(from: ar2 as! [Any])
                                        }
                                    }
                                    
                                } else {
                                    self.arr_mut_dashboard_data.addObjects(from: ar as! [Any])
                                }
                                
                                self.tble_view.delegate = self
                                self.tble_view.dataSource = self
                                self.tble_view.reloadData()
                            }
                            else {
                                TokenManager.shared.refresh_token_WB { token, error in
                                    if let token = token {
                                        print("Token received: \(token)")
                                        
                                        let str_token = "\(token)"
                                        UserDefaults.standard.set("", forKey: str_save_last_api_token)
                                        UserDefaults.standard.set(str_token, forKey: str_save_last_api_token)
                                        
                                        self.my_profile(loader: "no")
                                        
                                    } else if let error = error {
                                        print("Failed to refresh token: \(error.localizedDescription)")
                                        // Handle the error
                                    }
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
                        
                        self.my_profile(loader: "no")
                        
                    } else if let error = error {
                        print("Failed to refresh token: \(error.localizedDescription)")
                        // Handle the error
                    }
                }
            }
        }
    }
    
    //
    @objc func delete_button_click_method(_ sender:UIButton) {
        let item = self.arr_mut_dashboard_data[sender.tag] as? [String:Any]
        
        let alert = UIAlertController(title: "Are you sure you want to delete this workout?", message: nil, preferredStyle: .alert)
        
        // Create the confirm action
        let confirmAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            // Handle the deletion
            print("Workout deleted.")
            self.delete_api_hit(exc_id: ("\(item!["day_excercise_id"]!)"))
        }
        
        // Create the cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        // Add actions to the alert controller
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        // Present the alert
        self.present(alert, animated: true, completion: nil)
        
    }
    @objc func delete_button_click_methodGYM(_ sender:UIButton) {
        
        let item = self.arr_mut_dashboard_data[sender.tag] as? [String:Any]
        print(item as Any)
        
        let alert = UIAlertController(title: "Are you sure you want to delete this exercise?", message: nil, preferredStyle: .alert)
        
        // Create the confirm action
        let confirmAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            // Handle the deletion
            print("Workout deleted.")
            // self.delete_api_hit(exc_id: ("\(item!["day_excercise_id"]!)"))
            
            print(self.arr_mut_dashboard_data.count)
            self.arr_mut_dashboard_data.removeObject(at: sender.tag)
            print(self.arr_mut_dashboard_data.count)
            self.delete_api_hitGYM()
        }
        
        // Create the cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        // Add actions to the alert controller
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        
        // Present the alert
        self.present(alert, animated: true, completion: nil)
        
    }
    @objc func delete_api_hit(exc_id:String) {
        var parameters:Dictionary<AnyHashable, Any>!
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        if let token_id_is = UserDefaults.standard.string(forKey: str_save_last_api_token) {
            
            let headers: HTTPHeaders = [
                "token":String(token_id_is),
            ]
            
            parameters = [
                "action"            : "day_wise_excercisedetete",
                "userId"            : "\(UserUtility.getUserId()!)",
                "day_excercise_id"  : String(exc_id)
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
                            
                            self.arr_mut_dashboard_data.removeAllObjects()
                            self.my_profile(loader: "no")
                        }
                        else {
                            TokenManager.shared.refresh_token_WB { token, error in
                                if let token = token {
                                    print("Token received: \(token)")
                                    
                                    let str_token = "\(token)"
                                    UserDefaults.standard.set("", forKey: str_save_last_api_token)
                                    UserDefaults.standard.set(str_token, forKey: str_save_last_api_token)
                                    
                                    self.my_profile(loader: "no")
                                    
                                } else if let error = error {
                                    print("Failed to refresh token: \(error.localizedDescription)")
                                    // Handle the error
                                }
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
                    
                    self.my_profile(loader: "no")
                    
                } else if let error = error {
                    print("Failed to refresh token: \(error.localizedDescription)")
                    // Handle the error
                }
            }
        }
    }
    
    @objc func delete_api_hitGYM() {
        var parameters:Dictionary<AnyHashable, Any>!
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        if let token_id_is = UserDefaults.standard.string(forKey: str_save_last_api_token) {
            
            let headers: HTTPHeaders = [
                "token":String(token_id_is),
            ]
            let immutableArray = NSArray(array: self.arr_mut_dashboard_data)
            print(immutableArray)
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: immutableArray, options: .prettyPrinted)
                
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    print(jsonString)
                    
                    parameters = [
                        "action"            : "myworkoutadd_type",
                        "userId"            : "\(UserUtility.getUserId()!)",
                        "myworkoutId"       : String(self.workout_id),
                        "date"              : String(self.lbl_date.text!),
                        "json_record_details" : String(jsonString),
                         
                    ]
                    
                }
            } catch {
                print("Error converting to JSON: \(error)")
            }
            
            
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
                            
                            self.arr_mut_dashboard_data.removeAllObjects()
                            self.my_profile(loader: "no")
                        }
                        else {
                            TokenManager.shared.refresh_token_WB { token, error in
                                if let token = token {
                                    print("Token received: \(token)")
                                    
                                    let str_token = "\(token)"
                                    UserDefaults.standard.set("", forKey: str_save_last_api_token)
                                    UserDefaults.standard.set(str_token, forKey: str_save_last_api_token)
                                    
                                    self.my_profile(loader: "no")
                                    
                                } else if let error = error {
                                    print("Failed to refresh token: \(error.localizedDescription)")
                                    // Handle the error
                                }
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
                    
                    self.my_profile(loader: "no")
                    
                } else if let error = error {
                    print("Failed to refresh token: \(error.localizedDescription)")
                    // Handle the error
                }
            }
        }
    }
}

//MARK:- TABLE VIEW -
extension days_workout: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_mut_dashboard_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:days_workout_table_cell = tableView.dequeueReusableCell(withIdentifier: "days_workout_table_cell") as! days_workout_table_cell
        
        let item = self.arr_mut_dashboard_data[indexPath.row] as? [String:Any]
        print(item as Any)
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        if (self.str_profile_select_from_dashboard == "1") { // dashboard > aerobics
            
            cell.lbl_title.text = (item!["name"] as! String)
            cell.lbl_cal.isHidden = true
            if item!["calories_per_hour"] == nil {
                cell.lbl_sub_title.text = "\(item!["duration_minutes"]!) Min"
            } else {
                cell.lbl_sub_title.text = "\(item!["duration_minutes"]!) Min (\(item!["calories_per_hour"]!) Cal)"
            }
            
            cell.btn_delete.isHidden = true
            
        } else if (self.str_profile_select_from_dashboard == "2") { // dashboard > gym
             
            if item!["name"] == nil {
                cell.lbl_title.text = "N.A."
            } else {
                cell.lbl_title.text = (item!["name"] as! String)
            }
            
            
            if item!["reps"] == nil {
                cell.lbl_sub_title.text = "N.A."
            } else {
                cell.lbl_sub_title.text = "Minute: \(item!["DurationINmin"]!) || \(item!["reps"]!) Reps (\(item!["sets"]!) Sets)"
            }
            
            cell.lbl_cal.text = "\(item!["burnCalories"]!) Cal"
            
            if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
                print(person as Any)
                
                let currentWeight = Double("\(person["current_wight"]!)")
                let height = Double("\(person["height"]!)")
                let age = Double("\(person["dob"]!)")
                let selectedLevel = String("")
                let weightUnit = "\(person["current_wight_measurement"]!)"
                let heightUnit = "\(person["height_measurement"]!)"
                let gender = "\(person["gender"]!)"
                
                let serverKeyData = "\(person["home_page_category"]!)"
                
                let result = calculateCaloriesWithBurn(currentWeight: currentWeight!,
                                                       weightUnit: weightUnit,
                                                       height: height!,
                                                       heightUnit: heightUnit,
                                                       age: age!,
                                                       gender: gender,
                                                       selectedLevel: selectedLevel,
                                                       serverKeyData: serverKeyData)
                
                print(result)
                
                self.lbl_days_workout.text = "Calories Burn: \(item!["burnCalories"]!) / \(result)"
                
            }
            
            cell.btn_delete.isHidden = false
            cell.btn_delete.tag = indexPath.row
            cell.btn_delete.addTarget(self, action: #selector(delete_button_click_methodGYM), for: .touchUpInside)
            
        } else {
            
            cell.btn_delete.isHidden = false
            cell.lbl_cal.isHidden = true
            cell.lbl_title.text = (item!["excercise_name"] as! String)
            if "\(item!["excercise_type"]!)" == "1" {
                cell.lbl_sub_title.text = "Aerobics"
            } else {
                cell.lbl_sub_title.text = "\(item!["reps"]!) Reps (\(item!["sets"]!) Sets)"
            }
            cell.lbl_sub_title.isHidden = false
            
            cell.btn_delete.tag = indexPath.row
            cell.btn_delete.addTarget(self, action: #selector(delete_button_click_method), for: .touchUpInside)
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         
        if (self.str_profile_select_from_dashboard == "2") {
         debugPrint("DASHBAORD > GYM")
            
            let item = self.arr_mut_dashboard_data[indexPath.row] as? [String:Any]
            print(item as Any)
            
            let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "workout_gym_exc_details_id") as? workout_gym_exc_details
            push!.str_edit = "yes"
            push!.exc_id = "\(item!["id"]!)"
            self.navigationController?.pushViewController(push!, animated: true)
            
        } else {
            let item = self.arr_mut_dashboard_data[indexPath.row] as? [String:Any]
            print(item as Any)
            
            if "\(item!["excercise_type"]!)" != "1" {
                let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "workout_gym_exc_details_id") as? workout_gym_exc_details
                push!.str_edit = "yes"
                push!.exc_id = "\(item!["excercise_id"]!)"
                self.navigationController?.pushViewController(push!, animated: true)
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}
