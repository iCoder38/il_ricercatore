//
//  add_heart_rate.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 22/03/24.
//

import UIKit
import Alamofire

class add_heart_rate: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var pickerView: UIPickerView!
    
    var arrayFruits:NSMutableArray! = []
    var dummy:NSMutableArray! = []
    
    var str_selected_text:String!
    
    var str_selected_time:String! = "0"
    var str_selected_date:String! = "0"
    
    @IBOutlet weak var btn_back:UIButton! {
        didSet {
            btn_back.tintColor = .white
            btn_back.setImage(UIImage(systemName: "arrow.left"), for: .normal)
            btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var btn_date:UIButton!
    @IBOutlet weak var btn_time:UIButton!
    
    @IBOutlet weak var lbl_navigation_title:UILabel! {
        didSet {
            lbl_navigation_title.text = navigation_title_add_heart_rate_en
        }
    }
    
    @IBOutlet weak var lbl_heart_rate:UILabel! {
        didSet {
            lbl_heart_rate.text = "0"
        }
    }
    @IBOutlet weak var btn_continue:UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for index in 0...299 {
            arrayFruits.add("\(index)")
        }
        
        for index in 0...10 {
            dummy.add("\(index)")
        }
        
        self.pickerView.tag = 1
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        
        self.btn_time.setTitle("Time: "+Date.getCurrentTime(), for: .normal)
        self.btn_date.setTitle("Date: Today", for: .normal)
        
        self.str_selected_time = Date.getCurrentTime()
        self.str_selected_date = Date.getCurrentDateCustom()
        
        self.btn_time.addTarget(self, action: #selector(time_click), for: .touchUpInside)
        self.btn_date.addTarget(self, action: #selector(date_click), for: .touchUpInside)
        
        self.btn_continue.addTarget(self, action: #selector(submit_date_WB), for: .touchUpInside)
        
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
                self.btn_date.setTitle("Date: "+selectedDate.dateString(date_fomatter), for: .normal)
            }
        })
    }
    
    //MARK: - Pickerview method -
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if component == 0 {
            return arrayFruits.count
        } else {
            return dummy.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            return (arrayFruits[row] as! String)
        } else {
            return (dummy[row] as! String)
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            print(arrayFruits[row] as! String)
            self.lbl_heart_rate.text = (self.arrayFruits[row] as! String)
        } else {
            print(dummy[row] as! String)
        }
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "Avenir Next", size: 22.0)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = (self.arrayFruits[row] as! String)
        pickerLabel?.textColor = UIColor.black
        
        return pickerLabel!
    }
    
    
    @objc func submit_date_WB() {
        
        if (self.str_selected_date == "0") {
            self.alert_show_error(field_name: "Date")
            return
        }
        
        if (self.str_selected_time == "0") {
            self.alert_show_error(field_name: "Time")
            return
        }
        
        if (self.lbl_heart_rate.text == "") {
            self.alert_show_error(field_name: "Heart rate")
            return
        }
        
        if (self.lbl_heart_rate.text == "0") {
            self.alert_show_error(field_name: "Heart rate")
            return
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
                
                parameters = [
                    "action"        : "heartadd",
                    "userId"        : String(myString),
                    "date"          : String(self.str_selected_date),
                    "time"          : String(self.str_selected_time),
                    "bmp"           : String(self.lbl_heart_rate.text!),
                    "bmp_measurement"   :"BPM",
                     
                    
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
