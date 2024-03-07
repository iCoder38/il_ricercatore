//
//  set_up_water_tracker.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 19/12/23.
//

import UIKit
import Alamofire
import Toast_Swift

class set_up_water_tracker: UIViewController {
    
    var str_total_drink_water_count:String!
    var str_total_water_count:String!
    
    @IBOutlet weak var btn_back:UIButton! {
        didSet {
            btn_back.tintColor = .white
            btn_back.setImage(UIImage(systemName: "arrow.left"), for: .normal)
            btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        }
    }
    @IBOutlet weak var btn_reset:UIButton! {
        didSet {
            btn_reset.layer.cornerRadius = 8
            btn_reset.clipsToBounds = true
            // btn_reset.setTitle("reset", for: .normal)
            btn_reset.setTitleColor(.white, for: .normal)
        }
    }
    @IBOutlet weak var lbl_navigation_title:UILabel! {
        didSet {
            lbl_navigation_title.text = navigation_title_water_intake_en
        }
    }
    
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
        self.tble_view.separatorColor = .white
        
         
         btn_reset.addTarget(self, action: #selector(edit_calorie_budget_click_method), for: .touchUpInside)
        
    }
    
    @objc func edit_calorie_budget_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "water_reminder_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    @objc func add_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! water_tracker_table_cell
        
        let a: Int? = Int(self.str_total_water_count)
        //print(a as Any)
        
        var sum = a
        sum! += 1
        // print(sum as Any)
        
        self.str_total_water_count = "\(sum!)"
        
        let c: Int? = Int(self.str_total_water_count)
        print(c as Any)
        
        let d: Int? = Int(self.str_total_drink_water_count)
        print(d as Any)
        
        if (self.str_total_drink_water_count < self.str_total_water_count){
            print("1")
            cell.btn_minus.isHidden = false
        }
        
        self.tble_view.reloadData()
        
    }
    
    @objc func minus_click_method() {
         let indexPath = IndexPath.init(row: 0, section: 0)
         let cell = self.tble_view.cellForRow(at: indexPath) as! water_tracker_table_cell
        
        let a: Int? = Int(self.str_total_water_count)
        print(a as Any)
        
        let b: Int? = Int(self.str_total_drink_water_count)
        print(b as Any)
        
        if (a != b) {
            cell.btn_minus.isHidden = false

            var minus = a
            minus! -= 1
            print(minus as Any)
            
            self.str_total_water_count = "\(minus!)"
            
            self.tble_view.reloadData()
        } else {
            print("matched")
            cell.btn_minus.isHidden = true
        }
        
        
    }
    
    @objc func add_one_more_glass_WB(loader:String) {
        // let indexPath = IndexPath.init(row: 0, section: 0)
        // let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_table_cell
        
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
                    "action"        : "editprofile",
                    "userId"        : String(myString),
                    "water_goal"    : String(self.str_total_water_count),
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
                                
                                
                                self.view.makeToast("Saved")
                                
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
                        
                        self.add_one_more_glass_WB(loader: "no")
                        
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
extension set_up_water_tracker: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:water_tracker_table_cell = tableView.dequeueReusableCell(withIdentifier: "water_tracker_table_cell") as! water_tracker_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        cell.lbl_water_count.text = String(self.str_total_water_count)
        
        cell.btn_add.addTarget(self, action: #selector(add_click_method), for: .touchUpInside)
        cell.btn_minus.addTarget(self, action: #selector(minus_click_method), for: .touchUpInside)
        
         cell.btn_save.addTarget(self, action: #selector(save_click_method), for: .touchUpInside)
        
        return cell
        
    }
    
    @objc func  save_click_method() {
        self.add_one_more_glass_WB(loader: "yes")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 292
    }

}
