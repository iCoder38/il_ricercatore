//
//  add_blood_glucose.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 19/04/24.
//

import UIKit
import DGCharts
import Alamofire

class add_blood_glucose: UIViewController, UITextFieldDelegate {
    
    var arrSleep:NSMutableArray! = []
    
    var arr_7_days:NSMutableArray! = []
    var str_do_not_change:String! = "0"
    
    var str_selected_text:String!
    
    var str_selected_time:String! = "0"
    var str_selected_date:String! = "0"
    
    @IBOutlet weak var txt_mon:UITextField!
    
    @IBOutlet weak var btn_back:UIButton! {
        didSet {
            btn_back.tintColor = .white
            btn_back.setImage(UIImage(systemName: "arrow.left"), for: .normal)
            btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        }
    }
    @IBOutlet weak var btn_add:UIButton!
    
    @IBOutlet weak var lbl_navigation_title:UILabel! {
        didSet {
            lbl_navigation_title.text = navigation_title_sleep_monitor
        }
    }
    
    @IBOutlet weak var tble_view:UITableView! {
        didSet {
            
            // tble_view.layer.cornerRadius = 22
            tble_view.clipsToBounds = true
        }
    }
    
    var str_instake_status:String! = "0"
    @IBOutlet weak var btn_week:UIButton! {
        didSet {
            btn_week.setTitle("Week", for: .normal)
            btn_week.backgroundColor = .systemOrange
        }
    }
    
    @IBOutlet weak var btn_custom:UIButton!  {
        didSet {
            btn_custom.setTitle("Custom", for: .normal)
            btn_custom.backgroundColor = .systemOrange
        }
    }
    
    func findDateDiff(time1Str: String, time2Str: String) -> String {
        let timeformatter = DateFormatter()
        timeformatter.dateFormat = "hh:mm a"

        guard let time1 = timeformatter.date(from: time1Str),
            let time2 = timeformatter.date(from: time2Str) else { return "" }

        //You can directly use from here if you have two dates

        let interval = time2.timeIntervalSince(time1)
        let hour = interval / 3600;
        let minute = interval.truncatingRemainder(dividingBy: 3600) / 60
        _ = Int(interval)
        // return "\(intervalInt < 0 ? "-" : "+") \(Int(hour)).\(Int(minute))"
        return "\(Int(hour)).\(Int(minute))"
    }
    @IBOutlet weak var btn_date:UIButton!
    @IBOutlet weak var btn_time:UIButton!
    
    @IBOutlet weak var txt_select_meal_tim:UITextField! {
        didSet {
            txt_select_meal_tim.layer.cornerRadius = 8
            txt_select_meal_tim.clipsToBounds = true
            txt_select_meal_tim.backgroundColor = light_pink_color
            txt_select_meal_tim.placeholder = "Select Meal timing"
            txt_select_meal_tim.setLeftPaddingPoints(20)
        }
    }
    
    @IBOutlet weak var txt_select_meal_type:UITextField! {
        didSet {
            txt_select_meal_type.layer.cornerRadius = 8
            txt_select_meal_type.clipsToBounds = true
            txt_select_meal_type.backgroundColor = light_pink_color
            txt_select_meal_type.placeholder = "Select Meal type"
            txt_select_meal_type.setLeftPaddingPoints(20)
        }
    }
    
    @IBOutlet weak var txt_sleep_timi:UITextField! {
        didSet {
            txt_sleep_timi.layer.cornerRadius = 8
            txt_sleep_timi.clipsToBounds = true
            txt_sleep_timi.backgroundColor = light_pink_color
            txt_sleep_timi.placeholder = "Select Sleep timing"
            txt_sleep_timi.setLeftPaddingPoints(20)
        }
    }
    @IBOutlet weak var btn_one:UIButton!
    @IBOutlet weak var btn_two:UIButton!
    @IBOutlet weak var btn_three:UIButton!
    
    @IBOutlet weak var btn_continue:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.tble_view.separatorColor = .white
        
        self.txt_mon.delegate = self
        
        self.str_selected_time = Date.getCurrentTime()
        self.str_selected_date = Date.getCurrentDateCustom()
        
        self.btn_time.setTitle("Time: "+Date.getCurrentTime(), for: .normal)
        self.btn_date.setTitle("Date: Today", for: .normal)
        
        self.btn_time.addTarget(self, action: #selector(time_click), for: .touchUpInside)
        self.btn_date.addTarget(self, action: #selector(date_click), for: .touchUpInside)
        
        self.btn_one.addTarget(self, action: #selector(one_click), for: .touchUpInside)
        self.btn_two.addTarget(self, action: #selector(two_click), for: .touchUpInside)
        self.btn_three.addTarget(self, action: #selector(three_click), for: .touchUpInside)
         self.btn_continue.addTarget(self, action: #selector(submit_date_WB), for: .touchUpInside)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))

            //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
            //tap.cancelsTouchesInView = false

            view.addGestureRecognizer(tap)
        
        // self.caluclate_last_7_days()
    }
    
    override func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    
    @objc func caluclate_last_7_days() {
        
        for indexx in 1...7 {
            let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -indexx, to: Date())
            
            let separate_time = "\(sevenDaysAgo!)".components(separatedBy: " ")
            let before_space_value = separate_time[0]
            
            self.arr_7_days.add(before_space_value as Any)
        }
        print(self.arr_7_days.lastObject as Any)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // self.arrSleep.removeAllObjects()
        // self.submit_date_WB(status: "yes")
    }
    
    @objc func one_click() {
        
        let dummyList = ["Not set","While fasting","Before meal","After meal"]
        RPicker.selectOption(title: "Select", cancelText: "Cancel", dataArray: dummyList, selectedIndex: 0) { (selctedText, atIndex) in
             
            self.txt_select_meal_tim.text = String(selctedText)
            
        }
        
    }
    
    @objc func two_click() {
        
        let dummyList = ["Unknown","Breakfast","Lunch","Dinner","Snack"]
        RPicker.selectOption(title: "Select", cancelText: "Cancel", dataArray: dummyList, selectedIndex: 0) { (selctedText, atIndex) in
             
            self.txt_select_meal_type.text = String(selctedText)
            
        }
        
    }
    
    @objc func three_click() {
        
        let dummyList = ["While awake","Just before sleep","Just after waking up"]
        RPicker.selectOption(title: "Select", cancelText: "Cancel", dataArray: dummyList, selectedIndex: 0) { (selctedText, atIndex) in
             
            self.txt_sleep_timi.text = String(selctedText)
            
        }
        
    }
    
    
    @objc func time_click() {
        RPicker.selectDate(title: "Select Time", cancelText: "Cancel", datePickerMode: .time, didSelectDate: { (selectedDate) in
            self.btn_time.setTitle("Time: "+selectedDate.dateString("HH:mm"), for: .normal)
            self.str_selected_time = selectedDate.dateString("HH:mm")
        })
    }
    
    @objc func date_click() {
        RPicker.selectDate(title: "Select date", cancelText: "Cancel", datePickerMode: .date,maxDate: Date.now, didSelectDate: { (selectedDate) in
            
            self.str_selected_date = selectedDate.dateString(date_fomatter_yyyy_MM_dd)
            if (selectedDate.dateString(date_fomatter) == Date.getCurrentDateCustom()) {
                self.btn_date.setTitle("Date: Today", for: .normal)
            } else {
                self.btn_date.setTitle("Date: "+selectedDate.dateString(date_fomatter_yyyy_MM_dd), for: .normal)
            }
        })
    }
    
    
    
    
    @objc func submit_date_WB() {
        
        
         
        if (self.txt_mon.text) == "" {
            return
        }
        if (self.txt_select_meal_tim.text) == "" {
            return
        }
        if (self.txt_select_meal_type.text) == "" {
            return
        }
        if (self.txt_sleep_timi.text) == "" {
            return
        } 
        
        if (self.txt_mon.text) == "" {
            return
        }
        
        let a: Double? = Double(self.txt_mon.text!)
        if (a! > 1000) {
            print("big")
            return
        } else {
            print("small")
            
        }
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
        var parameters:Dictionary<AnyHashable, Any>!
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            
            if let token_id_is = UserDefaults.standard.string(forKey: str_save_last_api_token) {
                
                let headers: HTTPHeaders = [
                    "token":String(token_id_is),
                ]
                
                let x : Int = person["userId"] as! Int
                let myString = String(x)
                 
                /*
                 [action] => glucoseadd
                     [userId] => 37
                     [bloodGlucose] => 100
                     [date] => 2024-04-19
                     [time] => 17:49
                     [meal_timing] => Not set
                     [meal_type] => Lunch
                     [sleep_timing] => Just before sleep
                 */
                    parameters = [
                        "action"        : "glucoseadd",
                        "userId"        : String(myString),
                        "date"          : String(self.str_selected_date),
                        "time"          : String(self.str_selected_time),
                        "bloodGlucose"  : String(self.txt_mon.text!),
                        "meal_timing"   : String(self.txt_select_meal_tim.text!),
                        "meal_type"     : String(self.txt_select_meal_type.text!),
                        "sleep_timing"  : String(self.txt_sleep_timi.text!),
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
                                
                                self.view.makeToast(JSON["msg"] as? String)
                                self.success_with_back_show_alert(message: (JSON["msg"] as? String)!)
                                
                                // self.view.makeToast(JSON["msg"] as? String)
                                // self.success_with_back_show_alert(message: (JSON["msg"] as? String)!)
                                
                                /*self.arrSleep.removeAllObjects()
                                
                                var ar : NSArray!
                                ar = (JSON["data"] as! Array<Any>) as NSArray
                                self.arrSleep.addObjects(from: ar as! [Any])
                                
                                self.tble_view.delegate = self
                                self.tble_view.dataSource = self
                                self.tble_view.reloadData()*/
                            } else {
                                if (JSON["msg"] as? String == your_are_not_auth) {
                                    self.refresh_token_WB()
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
                        
                        self.submit_date_WB()
                        
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
extension add_blood_glucose: UITableViewDataSource , UITableViewDelegate, ChartViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:add_blood_glucose_table_cell = tableView.dequeueReusableCell(withIdentifier: "one_table_cell") as! add_blood_glucose_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        return cell
        
        
    }
      
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if (self.str_instake_status == "0") {
            
        }
        // self.arrSleep.count+2
        // delete_sleep_click_method
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (self.str_instake_status == "0") {
            if indexPath.row == 0 {
                return 350
            } else if indexPath.row == 1 {
                return 0
            } else {
                return 70
            }
        } else {
            if indexPath.row == 0 {
                return 0
            } else if indexPath.row == 1 {
                return 330
            } else {
                return 70
            }
        }
    }

}
