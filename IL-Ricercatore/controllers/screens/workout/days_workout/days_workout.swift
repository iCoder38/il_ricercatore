//
//  days_workout.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 20/12/23.
//

import UIKit
import Alamofire

class days_workout: UIViewController {

    var arr_mut_dashboard_data:NSMutableArray! = []
    
    @IBOutlet weak var txt_field:UITextField!
    @IBOutlet weak var btn_search:UIButton! {
        didSet {
            btn_search.addTarget(self, action: #selector(search_click_method), for: .touchUpInside)
        }
    }
    
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
        
        // Get the current date
        let (dayName, dayNumber) = getDayNameAndNumber()
        self.lbl_navigation_title.text = "\(dayName) - Workout"
        self.day_number = "\(dayNumber)"
        
        self.my_profile(loader: "yes")
        
        
        self.btn_add.addTarget(self, action: #selector(add_click_method), for: .touchUpInside)
    }
    
    @objc func add_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "type_of_excercise_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    @objc func search_click_method() {
        
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
                
                parameters = [
                    "action"    : "day_wise_excercis_list",
                    "userId"    : String(myString),
                    "day"       : String(self.day_number)
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
                                
                                var ar : NSArray!
                                ar = (JSON["data"] as! Array<Any>) as NSArray
                                print(ar as Any)
                                
                                self.arr_mut_dashboard_data.addObjects(from: ar as! [Any])
                                
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
        cell.lbl_title.text = (item!["excercise_name"] as! String)
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
         
        cell.btn_delete.tag = indexPath.row
        cell.btn_delete.addTarget(self, action: #selector(delete_button_click_method), for: .touchUpInside)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}
