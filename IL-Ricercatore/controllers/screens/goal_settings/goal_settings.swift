//
//  goal_settings.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 03/04/24.
//

import UIKit
import Alamofire

class goal_settings: UIViewController {
    
    var dict_profile:NSDictionary!
    
    
    @IBOutlet weak var lbl_navigation_title:UILabel! {
        didSet {
            lbl_navigation_title.text = navigation_title_goal_setting
        }
    }
    
    @IBOutlet weak var btn_back:UIButton! {
        didSet {
            btn_back.tintColor = .white
            btn_back.setImage(UIImage(systemName: "list.bullet"), for: .normal)
            // btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var tble_view:UITableView! {
        didSet {
            
            tble_view.layer.cornerRadius = 22
            tble_view.clipsToBounds = true
            tble_view.backgroundColor = .white
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btn_back.addTarget(self, action: #selector(menu_click_method), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.my_profile(loader: "yes")
    }
    
    @objc func my_profile(loader:String) {
        //  let indexPath = IndexPath.init(row: 0, section: 0)
        //  let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_three_table_cell
        
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
                                
                                var dict: Dictionary<AnyHashable, Any>
                                dict = JSON["data"] as! Dictionary<AnyHashable, Any>
                                
                                let defaults = UserDefaults.standard
                                defaults.setValue(dict, forKey: str_save_login_user_data)
                                
                                self.dict_profile = dict as NSDictionary
                                
                                self.tble_view.delegate = self
                                self.tble_view.dataSource = self
                                self.tble_view.reloadData()
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
    
    @objc func edit_weight_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "weight_goal_id") as? weight_goal
        self.navigationController?.pushViewController(push!, animated: true)
    }
    
    @objc func edit_water_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "goal_settings_water_id") as? goal_settings_water
        
        push!.str_value = "\(self.dict_profile["water_goal"]!)"
        push!.type = "water"
        
        self.navigationController?.pushViewController(push!, animated: true)
    }
    @objc func edit_steps_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "goal_settings_water_id") as? goal_settings_water
        
        push!.str_value = "\(self.dict_profile["step_goal"]!)"
        push!.type = "step"
        
        self.navigationController?.pushViewController(push!, animated: true)
    }
    @objc func edit_nut_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "calorie_information_id") as? calorie_information
        
        /*push!.str_value = "\(self.dict_profile["nutrition_goal"]!)"
        push!.type = "nutrition_goal"*/
        push!.dict_get_value = self.dict_profile
        
        self.navigationController?.pushViewController(push!, animated: true)
    }
    
    @objc func edit_meal_cal_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "edit_meal_calories_id") as? edit_meal_calories
        
        push!.dict_get_value = self.dict_profile
        
        self.navigationController?.pushViewController(push!, animated: true)
    }
    
    
}

//MARK:- TABLE VIEW -
extension goal_settings: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:goal_settings_table_cell = tableView.dequeueReusableCell(withIdentifier: "goal_settings_table_cell") as! goal_settings_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        cell.lbl_current_weight.text = (self.dict_profile["current_wight"] as! String)+" "+(self.dict_profile["current_wight_measurement"] as! String)
        cell.lbl_goal_weight.text = (self.dict_profile["target_wight"] as! String)+" "+(self.dict_profile["target_wight_measurement"] as! String)
        cell.lbl_activity_weight.text = (self.dict_profile["daily_activity"] as! String)
        
        if "\(self.dict_profile["water_goal"]!)" == "0" {
            cell.lbl_daily_water_goal.text = "\(self.dict_profile["water_goal"]!) Glass"
        } else if "\(self.dict_profile["water_goal"]!)" == "1" {
            cell.lbl_daily_water_goal.text = "\(self.dict_profile["water_goal"]!) Glass"
        } else if "\(self.dict_profile["water_goal"]!)" == "" {
            cell.lbl_daily_water_goal.text = "\(self.dict_profile["water_goal"]!) Glass"
        } else {
            cell.lbl_daily_water_goal.text = "\(self.dict_profile["water_goal"]!) Glasses"
        }
        
         // steps
        if "\(self.dict_profile["step_goal"]!)" == "0" {
            cell.lbl_daily_step_goal.text = "\(self.dict_profile["step_goal"]!) Step"
        } else if "\(self.dict_profile["step_goal"]!)" == "1" {
            cell.lbl_daily_step_goal.text = "\(self.dict_profile["step_goal"]!) Step"
        } else if "\(self.dict_profile["step_goal"]!)" == "" {
            cell.lbl_daily_step_goal.text = "\(self.dict_profile["step_goal"]!) Step"
        } else {
            cell.lbl_daily_step_goal.text = "\(self.dict_profile["step_goal"]!) Steps"
        }
        
        
        cell.lbl_meal_calories_info.text = "100 %"
        
        cell.lbl_calorie_budget.text = "\(self.dict_profile["nutrition_goal"]!) Cal"
        
        cell.lbl_calorie_budget.text = "\(self.dict_profile["cal_total"]!) Cal"
        
        cell.btn_edit_weight.addTarget(self, action: #selector(edit_weight_click_method), for: .touchUpInside)
        cell.btn_edit_water.addTarget(self, action: #selector(edit_water_click_method), for: .touchUpInside)
        cell.btn_edit_steps.addTarget(self, action: #selector(edit_steps_click_method), for: .touchUpInside)
        cell.btn_edit_nut.addTarget(self, action: #selector(edit_nut_click_method), for: .touchUpInside)
        cell.btn_edit_meal_cal.addTarget(self, action: #selector(edit_meal_cal_click_method), for: .touchUpInside)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 512
    }

}
