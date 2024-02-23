//
//  dashboard.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 19/12/23.
//

import UIKit
import Alamofire

class dashboard: UIViewController {

    var dict_dashboard:NSDictionary!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.tble_view.separatorColor = .clear
        self.btn_menu.addTarget(self, action: #selector(menu_click_method), for: .touchUpInside)
        
        self.my_profile(loader: "yes")
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
    
    @objc func water_track_click_method() {
        //
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "water_intake_id")
        self.navigationController?.pushViewController(push, animated: true)
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
        }
        
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
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 700
    }

}
