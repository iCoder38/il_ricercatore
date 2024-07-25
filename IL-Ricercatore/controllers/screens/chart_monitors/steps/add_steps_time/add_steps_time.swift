//
//  add_steps_time.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 07/03/24.
//

import UIKit
import Alamofire

class add_steps_time: UIViewController {
    
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
            lbl_navigation_title.text = navigation_title_steps_add
        }
    }
    
    
    @IBOutlet weak var btn_went_to_bed_date:UIButton!
    @IBOutlet weak var btn_wake_up_date:UIButton!
    
    @IBOutlet weak var btn_went_to_bed_time:UIButton!
    @IBOutlet weak var btn_wake_up_time:UIButton!
    
    @IBOutlet weak var tble_view:UITableView! {
        didSet {
            tble_view.delegate = self
            tble_view.dataSource = self
            // tble_view.layer.cornerRadius = 22
            tble_view.clipsToBounds = true
            tble_view.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*self.btn_went_to_bed_time.addTarget(self, action: #selector(time_went_to_bed), for: .touchUpInside)
        self.btn_wake_up_time.addTarget(self, action: #selector(time_wake_up), for: .touchUpInside)
        
        self.btn_went_to_bed_date.addTarget(self, action: #selector(date_went_to_bed), for: .touchUpInside)
        self.btn_wake_up_date.addTarget(self, action: #selector(date_wake_up), for: .touchUpInside)*/
        
        // self.btn_submit.addTarget(self, action: #selector(submit_date_WB), for: .touchUpInside)
        
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
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! add_step_time_table_cell
        
        if (cell.txt_title.text! == "") {
            self.alert_show_error(field_name: "Title")
            return
        }
        if (cell.txt_select_date.text! == "") {
            self.alert_show_error(field_name: "Selected date")
            return
        }
        if (cell.txt_duration.text! == "") {
            self.alert_show_error(field_name: "Duration")
            return
        }
        if (cell.txt_distance.text! == "") {
            self.alert_show_error(field_name: "Distance")
            return
        }
        if (cell.txt_steps.text! == "") {
            self.alert_show_error(field_name: "Steps")
            return
        }
        if (cell.txt_note.text! == "") {
            self.alert_show_error(field_name: "Note")
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
                
                /*
                 [action] => stepadd
                 [userId] => 25
                 [title] => hsudb
                 [date] => 2024-03-07
                 [totalSteps] => 7
                 [duration] => bsbdh
                 [distance] => yey
                 [note] => hdhdgdv
                 */
                
                parameters = [
                    "action"        : "stepadd",
                    "userId"        : String(myString),
                    "title"         : String(cell.txt_title.text!),
                    "date"          : String(cell.txt_select_date.text!),
                    "totalSteps"    : String(cell.txt_steps.text!),
                    "duration"      : String(cell.txt_duration.text!),
                    "distance"      : String(cell.txt_distance.text!),
                    "note"          : String(cell.txt_note.text!),
                    
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
                                let alert = NewYorkAlertController(title: String("Success").uppercased(), message: JSON["msg"] as? String, style: .alert)
                                 
                                let cancel = NewYorkButton(title: "dismiss", style: .cancel) {
                                    _ in
                                    self.navigationController?.popViewController(animated: true)
                                }
                                alert.addButtons([cancel])
                                self.present(alert, animated: true)
                                
                                
                            } else {
                                if (JSON["msg"] as? String == your_are_not_auth) {
                                    self.refresh_token_WB()
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
    
    @objc func calendar_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! add_step_time_table_cell
        
        RPicker.selectDate(title: "Select date", cancelText: "Cancel", datePickerMode: .date,maxDate: Date.now, didSelectDate: { (selectedDate) in
            cell.txt_select_date.text = selectedDate.dateString("yyyy-MM-dd")
        })
    }
    
}

//MARK:- TABLE VIEW -
extension add_steps_time: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:add_step_time_table_cell = tableView.dequeueReusableCell(withIdentifier: "add_step_time_table_cell") as! add_step_time_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        cell.btn_calendar_click.addTarget(self, action: #selector(calendar_click_method), for: .touchUpInside)
        cell.btn_submit.addTarget(self, action: #selector(submit_date_WB), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 960
    }
    
}
