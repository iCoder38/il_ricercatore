//
//  user_profile.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 18/04/24.
//

import UIKit
import Alamofire
import SDWebImage

class user_profile: UIViewController {
    
    var arr_friends:NSMutableArray! = []
    
    var str_friend_id:String!
    
    var dict_user_profile:NSDictionary!
    
    @IBOutlet weak var btn_menu:UIButton! {
        didSet {
            btn_menu.tintColor = .white
            btn_menu.setImage(UIImage(systemName: "arrow.left"), for: .normal)
            btn_menu.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var lbl_navigation_title:UILabel! {
        didSet {
            lbl_navigation_title.text = navigation_title_user_profile_en
        }
    }
    
    @IBOutlet weak var tble_view:UITableView! {
        didSet {
            tble_view.layer.cornerRadius = 22
            tble_view.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var view_search:UIView! {
        didSet {
            view_search.layer.cornerRadius = 8
            view_search.clipsToBounds = true
            view_search.backgroundColor = .white
        }
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tble_view.separatorColor = .white
        
        self.friend_profile_WB()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    @objc func friend_profile_WB() {
        
        
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
                    "action"    : "profile",
                    "ownId"     : String(myString),
                    "userId"    : String(self.str_friend_id)
                    
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
                                
                                self.dict_user_profile = dict as NSDictionary
                                
                                
                                
                                self.tble_view.delegate = self
                                self.tble_view.dataSource = self
                                self.tble_view.reloadData()
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
                        
                        self.friend_profile_WB()
                       
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
extension user_profile: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:user_friends_table_cell = tableView.dequeueReusableCell(withIdentifier: "user_friends_table_cell") as! user_friends_table_cell
        
        /*let item = self.arr_friends[indexPath.row] as? [String:Any]
        print(item as Any)
        
        */
        
        cell.img_profile.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        cell.img_profile.sd_setImage(with: URL(string: (self.dict_user_profile["image"] as! String)), placeholderImage: UIImage(named: "logo"))
        
        cell.lbl_name.text = (self.dict_user_profile["fullName"] as! String)
        cell.lbl_email.text = (self.dict_user_profile["email"] as! String)
        
        cell.lbl_sex.text = (self.dict_user_profile["gender"] as! String)
        cell.lbl_dob.text = (self.dict_user_profile["dob"] as! String)
        cell.lbl_alcohol.text = ""
        
        if "\(self.dict_user_profile["drink"]!)" == "2" {
            cell.lbl_alcohol.text = "Occasionally"
        } else {
            cell.lbl_alcohol.text = "No"
        }
        
        if "\(self.dict_user_profile["smoke"]!)" == "2" {
            cell.lbl_smoke.text = "Occasionally"
        } else {
            cell.lbl_smoke.text = "No"
        }
        
        
        if "\(self.dict_user_profile["medicine_take"]!)" == "" {
            cell.lbl_taking_med.text = "No"
        } else {
            if "\(self.dict_user_profile["medicine_take"]!)" == "1" {
                cell.lbl_taking_med.text = "Yes"
            } else {
                cell.lbl_taking_med.text = "No"
            }
            
        }
        
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        /*let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "calorie_information_id")
        self.navigationController?.pushViewController(push, animated: true)*/
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 440
    }

}
