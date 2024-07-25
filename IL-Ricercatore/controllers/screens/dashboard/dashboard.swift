//
//  dashboard.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 19/12/23.
//

import UIKit
import Alamofire
import UserNotifications
import SDWebImage

class dashboard: UIViewController, UNUserNotificationCenterDelegate {

    var items: [[String: Any]] = []
    
    var dict_dashboard:NSDictionary!
    
    var str_selected_level:String! = ""
    var str_level:String!
    
    var str_total_calories_id:String! = "0"
    
    var str_total_calories_count:String!
    
    let scrollView = UIScrollView()
    
    var images:NSArray!
    
    var currentPage = 0
    
    var arr_daily_q:NSMutableArray! = []
    var imageUrls: [String] = []
    @IBOutlet weak var btn_menu:UIButton!
    
    @IBOutlet weak var lbl_navigation_title:UILabel! {
        didSet {
            lbl_navigation_title.text = navigation_title_en
        }
    }
    
    @IBOutlet weak var tble_view:UITableView! {
        didSet {
            
            tble_view.layer.cornerRadius = 22
            tble_view.clipsToBounds = true
            tble_view.backgroundColor = .clear
        }
    }
    
    var lastScheduledBadgeCount = 0
    var exc_count:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.tble_view.separatorColor = .clear
        self.btn_menu.addTarget(self, action: #selector(menu_click_method), for: .touchUpInside)
        
        
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.my_profile(loader: "no")
        // self.general()
        
    }
    
    @objc func edit_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "edit_profile_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    func getAllReminders() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { (requests) in
            for request in requests {
                print("Identifier: \(request.identifier)")
                print("Content: \(request.content)")
                print("Trigger: \(request.trigger)")
                print("---------")
            }
        }
    }
    
    func disableReminder() {
            let center = UNUserNotificationCenter.current()
            center.removePendingNotificationRequests(withIdentifiers: ["07D26954-F24B-4F0D-890A-3829C3AEFFDD"])
        }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func appDidBecomeActive() {
        scheduleCustomDateNotification()
    }
    
    func requestNotificationAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                print("Notification permission granted")
            } else {
                print("Notification permission denied: \(error?.localizedDescription ?? "")")
            }
        }
    }
    
    func updateBadgeCount() {
        // Fetch the current badge count
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.lastScheduledBadgeCount = UIApplication.shared.applicationIconBadgeNumber
                UIApplication.shared.applicationIconBadgeNumber = self.lastScheduledBadgeCount
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // Decrease the badge count by 1 if user interacts with the notification
        lastScheduledBadgeCount -= 1
        UIApplication.shared.applicationIconBadgeNumber = lastScheduledBadgeCount
        
        // Call the completion handler when finished processing the notification
        completionHandler()
    }
    
    func scheduleCustomDateNotification() {
        
        /*let content = UNMutableNotificationContent()
         content.title = "Reminder"
         content.body = "Don't forget your task!"
         
         let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false) // Notification will be delivered after 10 seconds
         
         let request = UNNotificationRequest(identifier: "reminderNotification", content: content, trigger: trigger)
         
         UNUserNotificationCenter.current().add(request) { (error) in
         if let error = error {
         print("Error scheduling notification: \(error.localizedDescription)")
         } else {
         print("Notification scheduled successfully!")
         }
         }*/
        
        let content = UNMutableNotificationContent()
        content.title = "Water Intake"
        content.body = "Don't forget your task!"
        content.badge = 1
        content.sound = .default
        
        // Define the date and time components for the trigger
        var dateComponents = DateComponents()
        dateComponents.year = 2024
        dateComponents.month = 5
        dateComponents.day = 6
        dateComponents.hour = 16 // 24 hour format
        dateComponents.minute = 48
        
        // Create a trigger with the specified date and time
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        // Create a request for the notification
        let request = UNNotificationRequest(identifier: "reminderNotification", content: content, trigger: trigger)
        
        // Add the request to the notification center
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully!")
                self.updateBadgeCount()
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Show the notification banner even when the app is open
        completionHandler([.alert, .sound, .badge])
    }
    
    func scheduleHourlyNotificationsBetween(startTime: Int, endTime: Int) {
        let content = UNMutableNotificationContent()
        content.title = "Hourly Reminder"
        content.body = "Don't forget your task!"
        content.sound = .default
        
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        let calendar = Calendar.current
        let now = Date()
        
        var dateComponents = calendar.dateComponents([.year, .month, .day, .hour], from: now)
        dateComponents.minute = 0 // Start from the top of the hour
        
        for hour in startTime..<endTime {
            dateComponents.hour = hour
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
    }
    
    
    @objc func my_profile(loader:String) {
//        let indexPath = IndexPath.init(row: 0, section: 0)
//        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_three_table_cell
        
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
                    "action"            : "profile",
                    "userId"            : String(myString),
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
                                
                                self.dict_dashboard = dict as NSDictionary
//                                
//                                
                                self.str_selected_level = "\(self.dict_dashboard["daily_activity"]!)"
                                self.str_level = "4"
//                                
//                                
//                                
//                                print(self.dict_dashboard["home_page_category"] as! String)
//                                
//                                let arr = (self.dict_dashboard["home_page_category"] as! String).components(separatedBy: ",")
//                                print(arr as Any)
                               
                                /*if arr.contains("3") && arr.contains("4") {
                                    // print("Both 3 and 4 are present in the array.")
                                    self.str_selected_level = (self.dict_dashboard["daily_activity"] as! String)
                                    
                                } else if arr.contains("3") {
                                    self.str_selected_level = (self.dict_dashboard["daily_activity"] as! String)
                                    self.str_level = "3"
                                    // print("Either 3 or 4 (or both) are not present in the array.")
                                } else if arr.contains("4") {
                                    self.str_selected_level = (self.dict_dashboard["daily_activity"] as! String)
                                    self.str_level = "4"
                                    // print("Either 3 or 4 (or both) are not present in the array.")
                                } else {
                                    
                                }*/
                                
                                self.exc_list_WB()
                                
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
    
    @objc func exc_list_WB() {
       
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
                
                let (dayName, dayNumber) = getDayNameAndNumber()
                
                parameters = [
                    "action"    : "day_wise_excercis_list",
                    "userId"    : String(myString),
                    "day"       : "\(dayNumber)"
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
                                 
                                
                                var ar : NSArray!
                                ar = (JSON["data"] as! Array<Any>) as NSArray
                                print(ar as Any)
                                
                                self.exc_count = "\(ar.count)"
                                
                                self.general()
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
    
    @objc func general() {
        
        var parameters:Dictionary<AnyHashable, Any>!
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
        parameters = [
            "action"    : "general",
        ]
        
        print("parameters-------\(String(describing: parameters))")
        
        AF.request(application_base_url, method: .post, parameters: parameters as? Parameters ).responseJSON {
            response in
            
            switch(response.result) {
            case .success(_):
                if let data = response.value {
                    
                    let JSON = data as! NSDictionary
                    print(JSON)
                    self.calculateCalBurnt()
//                    var ar : NSArray!
//                    ar = (JSON["Daily_Activity"] as! Array<Any>) as NSArray
//                    // self.activity.addObjects(from: ar as! [Any])
//                    print(ar as Any)
//                    
//                    for indexx in 0..<ar.count {
//                        let item = ar[indexx] as? [String:Any]
//                        print(item as Any)
//                        print(item!["name"] as Any)
//                        
//                        if "\(item!["name"]!)" == (self.str_selected_level!) {
//                             print(item as Any)
//                            
//                            self.str_selected_level = "level_\(item!["key"]!)"
//                              print(self.str_selected_level as Any)
//                            
//                            // self.get_level_from_rapid()
//                            
//                        } else {
//                            self.get_level_from_rapid()
//                        }
//                    }
                }
                
            case .failure(_):
                print("Error message:\(String(describing: response.error))")
                ERProgressHud.sharedInstance.hide()
                self.please_check_your_internet_connection()
                
                break
            }
        }
    }
    
    @objc func calculateCalBurnt() {
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            print(person)
            
            print("\(person["current_wight"]!)")
            print("\(person["current_wight_measurement"]!)")
            
            let currentWeight = Double("\(person["current_wight"]!)")
            let height = Double("\(person["height"]!)")
            let age = Double("\(person["dob"]!)")
            let selectedLevel = String(self.str_selected_level)
            let weightUnit = "\(person["current_wight_measurement"]!)"
            let heightUnit = "\(person["height_measurement"]!)"
            let gender = "\(person["gender"]!)"
            
            let result = calculateCalories(currentWeight: currentWeight!,
                                           weightUnit: weightUnit,
                                           height: height!,
                                           heightUnit: heightUnit,
                                           age: age!,
                                           gender: gender,
                                           selectedLevel: selectedLevel)
            print(result)
            
            self.str_total_calories_count = "\(result)"
            
            
            daily_q_WB()
            
            
        }
        
    }
    
    @objc func get_level_from_rapid() {
        
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        // Define headers
        let headers = [
            // "content-type": "application/x-www-form-urlencoded",
            "X-RapidAPI-Key": "a549c19e42msh291ffe0591026cep1d1f1ejsnea1fdd0d9fc8",
            "X-RapidAPI-Host": "fitness-calculator.p.rapidapi.com"
        ]
       
        var calculate:Double!
        
        // print(self.dict_dashboard["height_measurement"])
        if (self.dict_dashboard["height_measurement"] as! String) != "cm" {
            // 5 ft = 5 x 30.48
            
            // self.dict_dashboard["height"] as! String
            
            
            let fullNameArr = (self.dict_dashboard["height"] as! String).components(separatedBy: " ")
            print(fullNameArr as Any)
            
            let value = 30.48
            let myDouble = Double(fullNameArr[0])
            print(myDouble as Any)
            
            calculate = value * myDouble!
            print(calculate as Any)
            
        } else {
            print("\(self.dict_dashboard["height"]!)")
            calculate = Double("\(self.dict_dashboard["height"]!)")
        }
    
        var gender = (self.dict_dashboard["gender"] as! String).lowercased()
        let dynamic_URL =
        //"https://fitness-calculator.p.rapidapi.com/dailycalorie?age=25&gender=male&height=180.08&weight=70&activitylevel=level_1"
        
        "https://fitness-calculator.p.rapidapi.com/dailycalorie?age=\(self.dict_dashboard["dob"] as! String)&gender=\(gender)&height=\(calculate!)&weight=\(self.dict_dashboard["current_wight"] as! String)&activitylevel=\(String(self.str_selected_level))"
        //
        
        debugPrint(dynamic_URL)
        
        guard let url = URL(string: dynamic_URL) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        // Perform the request
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            // Check for errors
            if let error = error {
                print("Error: \(error.localizedDescription)")
                ERProgressHud.sharedInstance.hide()
                return
            }
            
            // Check if a response was received
            guard let httpResponse = response as? HTTPURLResponse else {
                print("No response received")
                ERProgressHud.sharedInstance.hide()
                return
            }
            
            // Check for valid status code
            guard (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response: \(httpResponse.statusCode)")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    ERProgressHud.sharedInstance.hide()
                    self.tble_view.delegate = self
                    self.tble_view.dataSource = self
                    self.tble_view.reloadData()
                }
                
                return
            }
            
            // Check if data was received
            guard let responseData = data else {
                print("No data received")
                ERProgressHud.sharedInstance.hide()
                return
            }
            
            // Parse the JSON data
            do {
                // Try parsing JSON
                let json = try JSONSerialization.jsonObject(with: responseData, options: [])
                print("Response JSON: \(json)")
                // Handle the JSON response here
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    ERProgressHud.sharedInstance.hide()
                    
                    
                    if let jsonDictionary = json as? [String: Any] {
                        print(jsonDictionary["data"] as Any)
                        
                        if let data = jsonDictionary["data"] as? [String: Any] {
                            print(data["BMR"] as Any)
                            // Access other values inside "data" if needed
                            if (self.str_level == "3") {
                                // self.str_total_calories_id = "\(data["BMR"]!)"
                                
                                do {
                                    // Assuming `responseData` is your Data object containing the JSON response
                                    let json = try JSONSerialization.jsonObject(with: responseData, options: [])

                                    if let jsonResponse = json as? [String: Any],
                                       let data = jsonResponse["data"] as? [String: Any],
                                       let goals = data["goals"] as? [String: Any],
                                       let weightLossData = goals["Weight loss"] as? [String: Any],
                                       let calory = weightLossData["calory"] as? Double {
                                        
                                        // Accessing the loss weight data
                                        print("calory: \(calory)")
                                        // Handle the loss weight data here
                                        self.str_total_calories_id = "\(calory)"
                                    } else {
                                        print("Failed to extract 'loss weight' from 'Weight loss' data or 'Weight loss' data from 'goals'")
                                    }
                                } catch {
                                    print("Error parsing JSON: \(error)")
                                }
                                
                            } else if (self.str_level == "4") {
                                // self.str_total_calories_id = "\(data["BMR"]!)"
                                
                                do {
                                    // Assuming `responseData` is your Data object containing the JSON response
                                    let json = try JSONSerialization.jsonObject(with: responseData, options: [])

                                    if let jsonResponse = json as? [String: Any],
                                       let data = jsonResponse["data"] as? [String: Any],
                                       let goals = data["goals"] as? [String: Any],
                                       let weightLossData = goals["Weight loss"] as? [String: Any],
                                       let calory = weightLossData["calory"] as? Double {
                                        
                                        // Accessing the loss weight data
                                        print("calory: \(calory)")
                                        // Handle the loss weight data here
                                        self.str_total_calories_id = "\(calory)"
                                    } else {
                                        print("Failed to extract 'loss weight' from 'Weight loss' data or 'Weight loss' data from 'goals'")
                                    }
                                } catch {
                                    print("Error parsing JSON: \(error)")
                                }
                                
                            } else {
                                self.str_total_calories_id = "\(data["BMR"]!)"
                            }
                            
                            
                            self.tble_view.delegate = self
                            self.tble_view.dataSource = self
                            self.tble_view.reloadData()
                            
                        } else {
                            print("Failed to extract 'data' dictionary from JSON response")
                        }
                    } else {
                        print("JSON is not in expected dictionary format")
                    }
                }
                    
                    
                    
                    
            } catch let error {
                ERProgressHud.sharedInstance.hide()
                print("Error parsing JSON: \(error.localizedDescription)")
                print("Response Data: \(String(data: responseData, encoding: .utf8) ?? "Empty")")
            }
        }
        
        dataTask.resume()
        
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
    
    @objc func water_track_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "water_intake_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    @objc func sleep_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "sleep_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    @objc func steps_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "steps_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    @objc func heart_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "heart_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    @objc func weight_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "weight_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    @objc func blood_pressure_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "blood_pressure_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    @objc func view_more_post_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "all_post_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    @objc func nut_plus_click_methd() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "meal_track_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    @objc func add_glucose_click_methd() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "blood_glucose_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    @objc func cal_burnt_click_method() {
        
        let defaults = UserDefaults.standard
        
        defaults.set(nil, forKey: "key_save_dashboard_right_arrow")
        defaults.set(nil, forKey: "key_save_aerobics")
        defaults.set(nil, forKey: "key_save_gym")
        
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "type_of_excercise_id") as? type_of_excercise
        push!.str_exc_profile = "1"
        self.navigationController?.pushViewController(push!, animated: true)
    }
    
    @objc func right_arrow_click_methd() {
        
        let defaults = UserDefaults.standard
        defaults.set("dashboard_right_arrow", forKey: "key_save_dashboard_right_arrow")
        
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "days_workout_id") as? days_workout
        push!.str_profile_select_from_dashboard = "3"
        self.navigationController?.pushViewController(push!, animated: true)
    }
    
    
    
    @objc func daily_q_WB( ) {
        
       
        
        var parameters:Dictionary<AnyHashable, Any>!
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            
            if let token_id_is = UserDefaults.standard.string(forKey: str_save_last_api_token) {
                
                let headers: HTTPHeaders = [
                    "token":String(token_id_is),
                ]
                
                let x : Int = person["userId"] as! Int
                let myString = String(x)
                
                parameters = [
                    "action"        : "postlist",
                    "userId"        : String(myString),
                    "posttype"      : String("DailyQ"),
                    "pageNo"        : String("1"),
                     
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
                                
                                
                                var ar : NSArray!
                                ar = (JSON["data"] as! Array<Any>) as NSArray
                                self.arr_daily_q.addObjects(from: ar as! [Any])
                                
                                for i in 0..<self.arr_daily_q.count {
                                    let item = self.arr_daily_q[i] as? [String:Any]
                                    
                                    if (item!["imageType"] as! String) == "Video" {
                                        self.imageUrls.append(item!["video_cover_image"] as! String)
                                    } else {
                                        self.imageUrls.append(item!["image"] as! String)
                                    }
                                    
                                    
                                }
                                
                                print(self.imageUrls as Any)
                                
                                self.tble_view.delegate = self
                                self.tble_view.dataSource = self
                                self.tble_view.reloadData()
                                 
                                
                            } else {
                                if (JSON["msg"] as? String == your_are_not_auth) {
                                    self.refresh_token_WB4()
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
                self.refresh_token_WB4()
            }
        }
    }
    
    @objc func refresh_token_WB4() {
        
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
                        
                        self.daily_q_WB()
                        
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
extension dashboard: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:dashboard_table_cell = tableView.dequeueReusableCell(withIdentifier: "dashboard_table_cell") as! dashboard_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            print(person)
            
            cell.lbl_name.text = (person["fullName"] as! String)
            cell.lbl_email.text = (person["email"] as! String)
            
            cell.lbl_weight.text = "Current : \(person["current_wight"]!) \(person["current_wight_measurement"]!)"
            cell.lbl_weight_status.text = "Target : \(person["target_wight"]!) \(person["target_wight_measurement"]!)"
            
            cell.img_view_profile.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            cell.img_view_profile.sd_setImage(with: URL(string: (person["image"] as! String)), placeholderImage: UIImage(named: "logo"))
            
            cell.lbl_exc_count.text = String(self.exc_count)+" Excercises"
        }
        
        if (self.str_total_calories_id == "") {
            cell.lbl_cal_eaten.text = "0 to \(self.str_total_calories_id!)"
        } else {
            cell.lbl_cal_eaten.text = "0 to \(self.str_total_calories_id!)"
        }
        
        cell.lbl_cal_eaten.text = "0 to \(self.str_total_calories_count!)"
        
        
        cell.btn_edit.addTarget(self, action: #selector(edit_click_method), for: .touchUpInside)
        
        cell.lbl_protein.text = "Protein \(self.dict_dashboard["protine"]!) %"
        
        let result: Double = Double("\(self.dict_dashboard["protine"]!)")! / 100
        print(result as Any)
        cell.progress_view_protein.setProgress(Float(result), animated: true)
        
        if (result > 0.5) {
            cell.progress_view_protein.tintColor = .systemBlue
        } else {
            cell.progress_view_protein.tintColor = .systemRed
        }
        
        cell.lbl_fat.text = "Fat \(self.dict_dashboard["fats"]!) %"
        let result_fats: Double = Double("\(self.dict_dashboard["fats"]!)")! / 100
        print(result_fats as Any)
        cell.progress_view_fats.setProgress(Float(result_fats), animated: true)
        
        if (result_fats > 0.5) {
            cell.progress_view_fats.tintColor = .systemBlue
        } else {
            cell.progress_view_fats.tintColor = .systemRed
        }
        
        cell.lbl_curbs.text = "Curbs \(self.dict_dashboard["carbs"]!) %"
        let result_curbs: Double = Double("\(self.dict_dashboard["carbs"]!)")! / 100
        print(result_curbs as Any)
        cell.progress_view_curbs.setProgress(Float(result_curbs), animated: true)
        
        if (result_curbs > 0.5) {
            cell.progress_view_curbs.tintColor = .systemBlue
        } else {
            cell.progress_view_curbs.tintColor = .systemRed
        }
        
        cell.lbl_fiber.text = "Fiber \(self.dict_dashboard["fiber"]!) %"
        let result_fiber: Double = Double("\(self.dict_dashboard["fiber"]!)")! / 100
        print(result_fiber as Any)
        cell.progress_view_fiber.setProgress(Float(result_fiber), animated: true)
        
        if (result_fiber > 0.5) {
            cell.progress_view_fiber.tintColor = .systemBlue
        } else {
            cell.progress_view_fiber.tintColor = .systemRed
        }
        
        
        // water intake
        cell.btn_track.addTarget(self, action: #selector(water_track_click_method), for: .touchUpInside)
        
        // cell.btn_continue.addTarget(self, action: #selector(complete_profile_click_method), for: .touchUpInside)
        
        cell.btn_sleep.addTarget(self, action: #selector(sleep_click_method), for: .touchUpInside)
        cell.btn_steps.addTarget(self, action: #selector(steps_click_method), for: .touchUpInside)
        cell.btn_heart.addTarget(self, action: #selector(heart_click_method), for: .touchUpInside)
        cell.btn_weight.addTarget(self, action: #selector(weight_click_method), for: .touchUpInside)
        cell.btn_blood_pressure.addTarget(self, action: #selector(blood_pressure_click_method), for: .touchUpInside)
        cell.btn_blood_glucose.addTarget(self, action: #selector(add_glucose_click_methd), for: .touchUpInside)
        
        cell.view_more_post.addTarget(self, action: #selector(view_more_post_click_method), for: .touchUpInside)
        
        cell.btn_nut_plus.addTarget(self, action: #selector(nut_plus_click_methd), for: .touchUpInside)
        cell.btn_cal_burn.addTarget(self, action: #selector(cal_burnt_click_method), for: .touchUpInside)
        
        cell.btn_exc_right_arrow.addTarget(self, action: #selector(right_arrow_click_methd), for: .touchUpInside)
        
        // Create a UIScrollView
        
//        for item in arr_daily_q {
//            if let dict = item as? [String: Any],
//               let imageUrl = dict["image"] as? String {
//                imageUrls.append(imageUrl)
//            }
//        }
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        cell.image_view.addSubview(scrollView)
        
        // Set scrollView constraints
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: cell.image_view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: cell.image_view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: cell.image_view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: cell.image_view.bottomAnchor)
        ])
        scrollView.backgroundColor = .white

        var contentWidth: CGFloat = 0
        
        for (index, imageUrl) in imageUrls.enumerated() {
            guard let url = URL(string: imageUrl) else { continue }
            
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.frame = CGRect(x: CGFloat(index) * cell.image_view.frame.width, y: 0, width: cell.image_view.frame.width, height: cell.image_view.frame.height)
            
            scrollView.addSubview(imageView)
            
            // Load image asynchronously
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data, error == nil {
                    DispatchQueue.main.async {
                        imageView.image = UIImage(data: data)
                    }
                }
            }.resume()
            
            contentWidth += cell.image_view.frame.width
        }
        
        // Set the content size of the scrollView
        scrollView.contentSize = CGSize(width: contentWidth, height: 150)
        scrollView.isPagingEnabled = true
        
        // Add target actions for buttons
        cell.leftButton.addTarget(self, action: #selector(scrollLeft), for: .touchUpInside)
        cell.rightButton.addTarget(self, action: #selector(scrollRight), for: .touchUpInside)
        
        return cell
        
    }
    
    
    @objc func scrollLeft() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! dashboard_table_cell
        if currentPage > 0 {
            currentPage -= 1
            let offset = CGPoint(x: CGFloat(currentPage) * cell.image_view.frame.width, y: 0)
            scrollView.setContentOffset(offset, animated: true)
        }
    }
    
    @objc func scrollRight() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! dashboard_table_cell
        
        if currentPage < images.count - 1 {
            currentPage += 1
            let offset = CGPoint(x: CGFloat(currentPage) * cell.image_view.frame.width, y: 0)
            scrollView.setContentOffset(offset, animated: true)
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 1254
        // return 1296
    }
    
}
