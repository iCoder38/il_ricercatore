//
//  invite_friends.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 20/12/23.
//

import UIKit
import Alamofire
import SDWebImage

class invite_friends: UIViewController {

    var arr_friends:NSMutableArray! = []
    var str_Friend_id:String!
    
    @IBOutlet weak var btn_menu:UIButton! {
        didSet {
            btn_menu.tintColor = .white
            btn_menu.addTarget(self, action: #selector(menu_click_method), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var lbl_navigation_title:UILabel! {
        didSet {
            lbl_navigation_title.text = navigation_title_invite_friends_en
        }
    }
    
    @IBOutlet weak var tble_view:UITableView! {
        didSet {
            tble_view.layer.cornerRadius = 22
            tble_view.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var btn_add:UIButton!
    var str_login_userId:String!
    
    var str_status:String!
    
    var page : Int! = 1
    var loadMore : Int! = 1;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tble_view.separatorColor = .white
        
        self.btn_add.addTarget(self, action: #selector(friend_click_method), for: .touchUpInside)
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            
            let x : Int = person["userId"] as! Int
            let myString = String(x)
            
            self.str_login_userId = "\(myString)"
        }
        self.friends_list_WB(status: "yes", pageNumber: 1)
    }
    
    @objc func friend_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "search_friends_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
                
        if scrollView == self.tble_view {
            let isReachingEnd = scrollView.contentOffset.y >= 0
                && scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)
            if(isReachingEnd) {
                if(loadMore == 1) {
                    loadMore = 0
                    page += 1
                    print(page as Any)
                    
                    self.friends_list_WB(status:"no",pageNumber: page)
                    
                }
            }
        }
    }
    
    @objc func friends_list_WB(status:String,pageNumber:Int) {
        
        if (status == "yes") {
            ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        }
        
        var parameters:Dictionary<AnyHashable, Any>!
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            
            if let token_id_is = UserDefaults.standard.string(forKey: str_save_last_api_token) {
                
                let headers: HTTPHeaders = [
                    "token":String(token_id_is),
                ]
                
                let x : Int = person["userId"] as! Int
                let myString = String(x)
                
                
                parameters = [
//                    "action"    : "frinedlist",
//                    "userId"    : String(myString),
//                    "status"    : "1",
                    "action"    : "userlist",
                    "userId"    : String(myString),
                    "pageNo"    :pageNumber,
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
                                
                                // self.view.makeToast(JSON["msg"] as? String)
                                // self.success_with_back_show_alert(message: (JSON["msg"] as? String)!)
                                
                                // self.arr_friends.removeAllObjects()
                                
                                var ar : NSArray!
                                ar = (JSON["data"] as! Array<Any>) as NSArray
                                self.arr_friends.addObjects(from: ar as! [Any])
                                
                                self.tble_view.delegate = self
                                self.tble_view.dataSource = self
                                self.tble_view.reloadData()
                                self.loadMore = 1
                                
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
                        
                        
                        self.friends_list_WB(status: "no", pageNumber: 1)
                       
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
    
    
    @objc func validation_check_before_send_request(_ sender:UIButton) {
        print(self.arr_friends[sender.tag])
        
        let item = self.arr_friends[sender.tag] as? [String:Any]
        
        self.str_Friend_id = "\(item!["userId"]!)"
        
        self.add_friend_click_method()
    }
    @objc func add_friend_click_method() {
        
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "sending...")
        var parameters:Dictionary<AnyHashable, Any>!
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            
            if let token_id_is = UserDefaults.standard.string(forKey: str_save_last_api_token) {
                
                let headers: HTTPHeaders = [
                    "token":String(token_id_is),
                ]
                
                let x : Int = person["userId"] as! Int
                let myString = String(x)
                
                
                parameters = [
                    
                    "action"    : "frinedrequest",
                    "senderId"    : String(myString),
                    "receiverId"    : String(self.str_Friend_id),
                    "status"    : "1",
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
                                self.friends_list_WB(status: "no", pageNumber: 1)
                            } else {
                                if (JSON["msg"] as? String == your_are_not_auth) {
                                    self.refresh_token_WB2()
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
                self.refresh_token_WB2()
            }
        }
    }
    
    @objc func refresh_token_WB2() {
        
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
                        
                        
                        self.add_friend_click_method()
                       
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
    
    @objc func validation_check_before_accept_decline(_ sender:UIButton) {
        print(self.arr_friends[sender.tag])
        
        let item = self.arr_friends[sender.tag] as? [String:Any]
        print(item as Any)
        
        let alert = NewYorkAlertController(title: String("Friend request").uppercased(), message: nil, style: .alert)
        let accept = NewYorkButton(title: "Accept", style: .default) {
            _ in
            
            self.str_Friend_id = "\(item!["senderId"]!)"
            self.str_status = "2"
            self.new_request_click_method()
            
        }
        let decline = NewYorkButton(title: "Decline", style: .default) {
            _ in
            
            self.str_Friend_id = "\(item!["senderId"]!)"
            self.str_status = "3"
            self.new_request_click_method()
        }
        alert.addButtons([accept,decline])
        self.present(alert, animated: true)
        
        
    }
    @objc func new_request_click_method() {
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "accepting...")
        var parameters:Dictionary<AnyHashable, Any>!
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            
            if let token_id_is = UserDefaults.standard.string(forKey: str_save_last_api_token) {
                
                let headers: HTTPHeaders = [
                    "token":String(token_id_is),
                ]
                
                let x : Int = person["userId"] as! Int
                let myString = String(x)
                
                if String(self.str_status) == "3" {
                    parameters = [
                        "action"        : "frinedrequestdelete",
                        "senderId"      : String(myString),
                        "receiverId"    : String(self.str_Friend_id),
                    ]
                } else {
                    parameters = [
                        
                        "action"        : "frinedrequest",
                        "senderId"      : String(myString),
                        "receiverId"    : String(self.str_Friend_id),
                        "status"        : String(self.str_status),
                    ]
                }
                
                
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
                                self.view.makeToast(JSON["msg"] as? String)
                                self.friends_list_WB(status: "no", pageNumber: 1)
                            } else {
                                if (JSON["msg"] as? String == your_are_not_auth) {
                                    self.refresh_token_WB3()
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
                self.refresh_token_WB3()
            }
        }
    }
    
    @objc func refresh_token_WB3() {
        
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
                        
                        
                        self.new_request_click_method()
                       
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
extension invite_friends: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:invite_friends_table_cell = tableView.dequeueReusableCell(withIdentifier: "invite_friends_table_cell") as! invite_friends_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        let item = self.arr_friends[indexPath.row] as? [String:Any]
        print(item as Any)

        cell.lbl_title.text = (item!["userName"] as! String)
        cell.lbl_sub_title.text = (item!["userEmail"] as! String)
        
        cell.img_profile.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        cell.img_profile.sd_setImage(with: URL(string: (item!["profile_picture"] as! String)), placeholderImage: UIImage(named: "logo"))
        
        
        if "\(item!["friend_status"]!)" == "" {
            cell.btn_add_friend.setTitle("  + Add friend  ", for: .normal)
            cell.btn_add_friend.setTitleColor(.systemOrange, for: .normal)
            cell.btn_add_friend.backgroundColor = .black
            
            cell.btn_add_friend.tag = indexPath.row
            cell.btn_add_friend.addTarget(self, action: #selector(validation_check_before_send_request), for: .touchUpInside)
            
        } else if "\(item!["friend_status"]!)" == "1" {
            
            if "\(item!["senderId"]!)" == "\(item!["userId"]!)" {
                
                cell.btn_add_friend.setTitle(" New request ", for: .normal)
                cell.btn_add_friend.setTitleColor(.white, for: .normal)
                cell.btn_add_friend.backgroundColor = .systemOrange
                
                cell.btn_add_friend.tag = indexPath.row
                cell.btn_add_friend.addTarget(self, action: #selector(validation_check_before_accept_decline), for: .touchUpInside)
                
            } else {
                cell.btn_add_friend.setTitle(" Request sent ", for: .normal)
                cell.btn_add_friend.setTitleColor(.black, for: .normal)
                cell.btn_add_friend.backgroundColor = .clear
                cell.btn_add_friend.isUserInteractionEnabled = false
            }
            
        } else {
            cell.btn_add_friend.setTitle(" Friend ", for: .normal)
            cell.btn_add_friend.setTitleColor(.black, for: .normal)
            cell.btn_add_friend.backgroundColor = .clear
            cell.btn_add_friend.isUserInteractionEnabled = false
        }
        
        
        
        cell.btn_add_friend.layer.cornerRadius = 8
        cell.btn_add_friend.clipsToBounds = true
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = self.arr_friends[indexPath.row] as? [String:Any]
        print(item as Any)
        
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "user_profile_id") as? user_profile
        
        if "\(item!["receiverId"]!)" == "" {
            push!.str_friend_id = "\(item!["userId"]!)"
        } else {
            push!.str_friend_id = "\(item!["receiverId"]!)"
        }
        
        self.navigationController?.pushViewController(push!, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

}
