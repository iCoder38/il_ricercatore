//
//  show_all_cal_burnt_ctivity.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 10/05/24.
//

import UIKit
import SwiftyJSON
import Alamofire

class show_all_cal_burnt_ctivity: UIViewController {

    var get_array:Array<Any>!
    
    var indexx:Int!
    
    @IBOutlet weak var btn_back:UIButton! {
        didSet {
            btn_back.tintColor = .white
            btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        }
    }
   
    @IBOutlet weak var view_navigation_title:UILabel! {
        didSet {
            view_navigation_title.text = "SELECT"
            view_navigation_title.textColor = .white
        }
    }
    
    @IBOutlet weak var tbleView: UITableView! {
        didSet {
            tbleView.tableFooterView = UIView.init(frame: CGRect(origin: .zero, size: .zero))
            tbleView.backgroundColor = .white
            tbleView.delegate = self
            tbleView.dataSource = self
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tbleView.reloadData()
    }
}


//MARK:- TABLE VIEW -
extension show_all_cal_burnt_ctivity: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.get_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:show_all_cal_burnt_ctivity_table_cell = tableView.dequeueReusableCell(withIdentifier: "show_all_cal_burnt_ctivity_table_cell") as! show_all_cal_burnt_ctivity_table_cell
        
        let item = self.get_array[indexPath.row] as? [String:Any]
        // print(item as Any)
        
        cell.lbl_title.text = (item!["name"] as! String)
        
        cell.lbl_calories_per_hr.text = "Calories per hour: \(item!["calories_per_hour"]!)"
        cell.lbl_duration.text = "Duration: \(item!["duration_minutes"]!)"
        cell.lbl_total_calories.text = "Total calories: \(item!["total_calories"]!)"
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.indexx = indexPath.row
        self.my_profile()
        
    }
    
    @objc func my_profile() {
        
        let item = self.get_array[self.indexx] as? [String:Any]
        
        var array: [[String: Any]] = []
        
        // Append dictionaries to the array
        array.append([
            "calories_per_hour" : "\(item!["calories_per_hour"]!)",
            "duration_minutes"  : "\(item!["duration_minutes"]!)",
            "name"              : (item!["name"] as! String),
            "total_calories"    : "\(item!["total_calories"]!)",
            "image"             : ""
        ])
        
        // Convert array to JSON data
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: array, options: .prettyPrinted)
            
            // Convert JSON data to string (optional)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
                
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
                        
                        parameters = [
                            "action"            : "myworkoutadd",
                            "userId"            : String(myString),
                            "date"              :Date.getCurrentDateCustom(),
                            "json_record_details":jsonString,
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
        } catch {
            print("Error converting to JSON: \(error)")
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
                        
                        self.my_profile()
                        
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 166
    }

}
 
