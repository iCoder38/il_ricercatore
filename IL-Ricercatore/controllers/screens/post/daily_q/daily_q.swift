//
//  daily_q.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 22/03/24.
//

import UIKit
import Alamofire
import AVKit
import AVFoundation
import SDWebImage

class daily_q: UIViewController {

    var str_post_type:String!
    
    var arr_daily_q:NSMutableArray! = []
    
    var page : Int! = 1
    var loadMore : Int! = 1;
    var str_like_status:String!
    
    @IBOutlet weak var btn_back:UIButton! {
        didSet {
            btn_back.tintColor = .white
            btn_back.setImage(UIImage(systemName: "arrow.left"), for: .normal)
            btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        }
    }
     
    @IBOutlet weak var lbl_navigation_title:UILabel! {
        didSet {
            lbl_navigation_title.text = navigation_title_all_post
        }
    }
    @IBOutlet weak var tble_view:UITableView! {
        didSet {
            
            // tble_view.layer.cornerRadius = 22
            tble_view.clipsToBounds = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tble_view.separatorColor = .clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.daily_q_WB(status: "yes", pageNumber: 1)
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
                    
                    self.daily_q_WB(status: "no", pageNumber: page)
                    
                }
            }
        }
    }
    
    @objc func daily_q_WB(status:String,pageNumber: Int) {
        
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
                    "action"        : "postlist",
                    "userId"        : String(myString),
                    "posttype"      : String(str_post_type),
                    "key_word"      : "",
                    "pageNo"        : pageNumber,
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
                                
                                var ar : NSArray!
                                ar = (JSON["data"] as! Array<Any>) as NSArray
                                self.arr_daily_q.addObjects(from: ar as! [Any])
                                
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
                        
                        self.daily_q_WB(status: "no", pageNumber: 1)
                        
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
    
    @objc func read_more_click_method(_ sender:UIButton) {
        let item = self.arr_daily_q[sender.tag] as? [String:Any]
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "post_details_id") as? post_details
        push!.dictDetails = (item! as NSDictionary)
        self.navigationController?.pushViewController(push!, animated: true)
    }
    @objc func like_click_method(_ sender:UIButton) {
        
        let item = self.arr_daily_q[sender.tag] as? [String:Any]
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        var parameters:Dictionary<AnyHashable, Any>!
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            
            if let token_id_is = UserDefaults.standard.string(forKey: str_save_last_api_token) {
                
                let headers: HTTPHeaders = [
                    "token":String(token_id_is),
                ]
                
                let x : Int = person["userId"] as! Int
                let myString = String(x)
                
                if "\(item!["you_liked"]!)" == "No" {
                     
                    self.str_like_status = "1"
                } else {
                     
                    self.str_like_status = "0"
                }
                
                parameters = [
                    "action"    : "likeadd",
                    "userId"    : String(myString),
                    "postId"    : "\(item!["postId"]!)",
                    "status"    : String(self.str_like_status),
                ]
                
                print("parameters-------\(String(describing: parameters))")
                
                AF.request(application_base_url, method: .post, parameters: parameters as? Parameters,headers: headers).responseJSON {[self]
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
                                self.arr_daily_q.removeAllObjects()
                                self.view.makeToast(JSON["msg"] as? String)
                                self.daily_q_WB(status: "yes", pageNumber: 1)
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
                        
                        
                        // self.like_click_method()
                       
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
    
    @objc func comment_click_method(_ sender:UIButton) {
        let item = self.arr_daily_q[sender.tag] as? [String:Any]
        
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "comments_id") as? comments
        push!.str_post_id = "\(item!["postId"]!)"
        self.navigationController?.pushViewController(push!, animated: true)
    }
    
}

//MARK:- TABLE VIEW -
extension daily_q: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_daily_q.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:daily_q_table_cell = tableView.dequeueReusableCell(withIdentifier: "daily_q_table_cell") as! daily_q_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        let item = self.arr_daily_q[indexPath.row] as? [String:Any]
        print(item as Any)
        
        cell.lbl_title.text = (item!["name"] as! String)
        cell.lbl_sub_title.text = (item!["description"] as! String)
        cell.lbl_comments_like.text = "Comments  (\(item!["total_comment"]!))     Like  (\(item!["total_Like"]!))"
        
        cell.btn_read_more.addTarget(self, action: #selector(read_more_click_method), for: .touchUpInside)
        
        if "\(item!["you_liked"]!)" == "No" {
            cell.btn_like.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
            cell.btn_like.tintColor = .black
        } else {
            cell.btn_like.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
            cell.btn_like.tintColor = .systemPink
        }
        
        
        if (item!["imageType"] as! String) == "Video" {
            cell.btn_play.isHidden = false
            cell.img_profile.isHidden = false
            cell.img_profile.sd_imageIndicator = SDWebImageActivityIndicator.whiteLarge
            cell.img_profile.sd_setImage(with: URL(string: (item!["video_cover_image"] as! String)), placeholderImage: UIImage(named: "logo"))
        } else {
            cell.btn_play.isHidden = true
            cell.img_profile.isHidden = false
            cell.img_profile.sd_imageIndicator = SDWebImageActivityIndicator.whiteLarge
            cell.img_profile.sd_setImage(with: URL(string: (item!["image"] as! String)), placeholderImage: UIImage(named: "logo"))
        }
        cell.btn_play.isUserInteractionEnabled = false
        
        cell.btn_like.tag = indexPath.row
        cell.btn_like.addTarget(self, action: #selector(like_click_method), for: .touchUpInside)
        // cell.btn_comment.addTarget(self, action: #selector(comment_click_method), for: .touchUpInside)
        // cell.btn_play.addTarget(self, action: #selector(play_video), for: .touchUpInside)
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         
        let item = self.arr_daily_q[indexPath.row] as? [String:Any]
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "post_details_id") as? post_details
        push!.dictDetails = (item! as NSDictionary)
        self.navigationController?.pushViewController(push!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 318
    }

}
