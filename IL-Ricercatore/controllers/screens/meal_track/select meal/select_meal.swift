//
//  select_meal.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 14/05/24.
//

import UIKit
import Alamofire

class select_meal: UIViewController {

    var getData:NSMutableArray! = []
    var array: [[String: Any]] = []
    var arr_all_activities_data:Array<Any>!
    
    var str_param_key:String!
    
    @IBOutlet weak var txt_field:UITextField!
    @IBOutlet weak var btn_search:UIButton! {
        didSet {
            btn_search.addTarget(self, action: #selector(search_click_method), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var btn_menu:UIButton! {
        didSet {
            btn_menu.tintColor = .white
            btn_menu.addTarget(self, action: #selector(menu_click_method), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var lbl_navigation_title:UILabel! {
        didSet {
            lbl_navigation_title.text = "Select meal"
        }
    }
    
    @IBOutlet weak var tble_view:UITableView! {
        didSet {
            
            tble_view.layer.cornerRadius = 22
            tble_view.clipsToBounds = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @objc func search_click_method() {
        self.search_food()
    }
    
    @objc func search_food() {
         
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        // Define headers
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "X-Api-Key": "iMmbLV8e289ZG4nuTVCkwg==R8dlRkgN6D60YrAC",
            // "X-RapidAPI-Host": str_rapid_api_host
        ]
        
        var dynamic_URL = "\(search_food_query_URL)\(self.txt_field.text!)"
        // Create the request
        
        debugPrint(dynamic_URL)
        
        guard let url = URL(string: dynamic_URL) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        // Perform the request
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            // Check for errors
            if let error = error {
                print("Error: \(error.localizedDescription)")
                ERProgressHud.sharedInstance.hide()
                return
            }
            
            // Check if a response was received
            guard let httpResponse = response as? HTTPURLResponse else {
                print("No response received")
                ERProgressHud.sharedInstance.hide()
                return
            }
            
            // Check for valid status code
            guard (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response: \(httpResponse.statusCode)")
                ERProgressHud.sharedInstance.hide()
                return
            }
            
            // Check if data was received
            guard let responseData = data else {
                print("No data received")
                ERProgressHud.sharedInstance.hide()
                return
            }
            
            // Parse the JSON data
            do {
                // Try parsing JSON
                var json = try JSONSerialization.jsonObject(with: responseData, options: [])
                print("Response JSON: \(json)")
                // Handle the JSON response here
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    ERProgressHud.sharedInstance.hide()
                    self.arr_all_activities_data = (json as! Array<Any>)
                    
                    self.tble_view.delegate = self
                    self.tble_view.dataSource = self
                    self.tble_view.reloadData()
                }
            } catch let error {
                ERProgressHud.sharedInstance.hide()
                print("Error parsing JSON: \(error.localizedDescription)")
                print("Response Data: \(String(data: responseData, encoding: .utf8) ?? "Empty")")
            }
        }
        
        dataTask.resume()
        
    }
    
    @objc func my_profile() {
        
        let immutableArray = NSArray(array: self.getData)
        print(immutableArray)
     
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: immutableArray, options: .prettyPrinted)
            
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
                            "action"            : "foodadd",
                            "userId"            : String(myString),
                            "date"              : Date.getCurrentDateCustom(),
                            str_param_key  : jsonString,
                            
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
                                        
                                        self.navigationController?.popViewController(animated: true)
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
}


//MARK:- TABLE VIEW -
extension select_meal: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_all_activities_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:select_meal_table_cell = tableView.dequeueReusableCell(withIdentifier: "select_meal_table_cell") as! select_meal_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        let item = self.arr_all_activities_data[indexPath.row] as? [String:Any]
        // print(item as Any)
        cell.lbl_title.text = (item!["name"] as! String)
        cell.lbl_sub_title.text = "\(item!["serving_size_g"]!) g"
        cell.lbl_calories.text = "\(item!["calories"]!)"
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let alert = NewYorkAlertController(title: String("Select").uppercased(), message: String("Are you sure your want to select ?"), style: .alert)
        let yes = NewYorkButton(title: "Yes", style: .default) {
            _ in
            let item = self.arr_all_activities_data[indexPath.row] as? [String:Any]
            
            self.array.append(item!)
            self.getData.add(item!)
            
            
            self.my_profile()
            
        }
        let no = NewYorkButton(title: "dismiss", style: .cancel) {
            _ in
            
        }
        alert.addButtons([yes,no])
        self.present(alert, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}
