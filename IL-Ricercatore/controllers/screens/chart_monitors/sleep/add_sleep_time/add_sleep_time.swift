//
//  add_sleep_time.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 07/03/24.
//

import UIKit
import Alamofire

class add_sleep_time: UIViewController {
    
    var str_sleep_time:String! = "0"
    var str_wake_up_time:String! = "0"
    
    var str_went_to_bed_date:String! = "0"
    var str_wake_up_date:String! = "0"
    
    @IBOutlet weak var btn_back:UIButton! {
        didSet {
            btn_back.tintColor = .white
            btn_back.setImage(UIImage(systemName: "arrow.left"), for: .normal)
            btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var lbl_navigation_title:UILabel! {
        didSet {
            lbl_navigation_title.text = navigation_title_sleep_add
        }
    }
    @IBOutlet weak var btn_submit:UIButton! {
        didSet {
            btn_submit.layer.cornerRadius = 12
            btn_submit.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var btn_went_to_bed_date:UIButton!
    @IBOutlet weak var btn_wake_up_date:UIButton!
    
    @IBOutlet weak var btn_went_to_bed_time:UIButton!
    @IBOutlet weak var btn_wake_up_time:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btn_went_to_bed_time.addTarget(self, action: #selector(time_went_to_bed), for: .touchUpInside)
        self.btn_wake_up_time.addTarget(self, action: #selector(time_wake_up), for: .touchUpInside)
        
        self.btn_went_to_bed_date.addTarget(self, action: #selector(date_went_to_bed), for: .touchUpInside)
        self.btn_wake_up_date.addTarget(self, action: #selector(date_wake_up), for: .touchUpInside)
        
        self.btn_submit.addTarget(self, action: #selector(submit_date_WB), for: .touchUpInside)
    }
    
    @objc func date_went_to_bed() {
        
        RPicker.selectDate(title: "Went to bed time", cancelText: "Cancel", datePickerMode: .date, maxDate: Date.now, didSelectDate: { (selectedDate) in
            self.btn_went_to_bed_date.setTitle(selectedDate.dateString("yyyy-MM-dd"), for: .normal)
            self.str_went_to_bed_date = selectedDate.dateString("yyyy-MM-dd")
        })
    }
    @objc func date_wake_up() {
        
        RPicker.selectDate(title: "Went to bed time", cancelText: "Cancel", datePickerMode: .date,maxDate: Date.now, didSelectDate: { (selectedDate) in
            self.btn_wake_up_date.setTitle(selectedDate.dateString("yyyy-MM-dd"), for: .normal)
            self.str_wake_up_date = selectedDate.dateString("yyyy-MM-dd")
        })
    }
    
    @objc func time_went_to_bed() {
        
        RPicker.selectDate(title: "Went to bed time", cancelText: "Cancel", datePickerMode: .time, didSelectDate: { (selectedDate) in
            self.btn_went_to_bed_time.setTitle(selectedDate.dateString("HH:mm"), for: .normal)
            self.str_sleep_time = selectedDate.dateString("HH:mm")
        })
    }
    
    @objc func time_wake_up() {
        
        RPicker.selectDate(title: "Wake up time", cancelText: "Cancel", datePickerMode: .time, didSelectDate: { (selectedDate) in
            self.btn_wake_up_time.setTitle(selectedDate.dateString("HH:mm"), for: .normal)
            self.str_wake_up_time = selectedDate.dateString("HH:mm")
        })
    }
    
    @objc func submit_date_WB() {
        
        if (self.str_went_to_bed_date == "0") {
            self.alert_show_error(field_name: "Went to bed date")
            return
        }
        
        if (self.str_wake_up_date == "0") {
            self.alert_show_error(field_name: "Wake up date")
            return
        }
        
        if (self.str_sleep_time == "0") {
            self.alert_show_error(field_name: "Went to bed sleep time")
            return
        }
        
        if (self.str_wake_up_time == "0") {
            self.alert_show_error(field_name: "Wake up sleept time")
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
                    "action"        : "sleepadd",
                    "userId"        : String(myString),
                    "sleep_date"    : String(self.str_went_to_bed_date),
                    "sleepTime"     : String(self.str_sleep_time),
                    "wakeup_date"   : String(self.str_wake_up_date),
                    "wakeupTime"    : String(self.str_wake_up_time),
                    
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
