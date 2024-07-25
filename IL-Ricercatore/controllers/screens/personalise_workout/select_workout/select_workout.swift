//
//  select_workout.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 21/12/23.
//

import UIKit
import Alamofire

class select_workout: UIViewController, UITextFieldDelegate {

    var str_profile_dashboard:String!
    var str_get_date:String!
    var get_details:NSMutableArray! = []
    
    var exc_type:String!
    
    var arr_all_activities_data:Array<Any>!
    // var arr_add_custom_array:NSMutableArray! = []
    
    

    var arr_add_custom_array: [[String: Any]] = []
    var isItemSelected = false
    
    var selectedName: String?
    var custom: [[String: Any]] = []
    
    // all exercise
    var filteredExercises = [[String: Any]]()
    var customExercises: [[String: String]] = []
     
    let arr_dummy = ["Bench Press","Squats","Push-up","Bicep curl","Burpee","Overhead pass","Pull-up"]
    @IBOutlet weak var btn_back:UIButton! {
        didSet {
            btn_back.tintColor = .black
            btn_back.setImage(UIImage(systemName: "arrow.left"), for: .normal)
            btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var lbl_navigation_title:UILabel! {
        didSet {
            lbl_navigation_title.text = navigation_title_select_workout_en
        }
    }
    
    @IBOutlet weak var tble_view:UITableView! {
        didSet {
            // tble_view.delegate = self
            // tble_view.dataSource = self
            // tble_view.layer.cornerRadius = 22
            // tble_view.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var view_search:UIView! {
        didSet {
            view_search.layer.cornerRadius = 8
            view_search.clipsToBounds = true
            view_search.backgroundColor = .white
        }
    }
    
    @IBOutlet weak var txt_search:UITextField! {
        didSet {
            txt_search.layer.cornerRadius = 8
            txt_search.clipsToBounds = true
            txt_search.backgroundColor = .clear
            txt_search.placeholder = "Search..."
            // txt_search.setLeftPaddingPoints(20)
        }
    }
    
    @IBOutlet weak var btn_search:UIButton!
    
    @IBOutlet weak var btn_continue:UIButton! {
        didSet {
            btn_continue.layer.cornerRadius = 8
            btn_continue.clipsToBounds = true
            btn_continue.setTitle("Continue".uppercased(), for: .normal)
            btn_continue.setTitleColor(.white, for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tble_view.separatorColor = .gray
        
        self.updateContinueButtonVisibility()
        
        self.btn_search.addTarget(self, action: #selector(search_workout), for: .touchUpInside)
        self.btn_continue.addTarget(self, action: #selector(continue_click), for: .touchUpInside)
        
        // print(self.get_details as Any)
        // print(self.str_profile_dashboard as Any)
        
        self.txt_search.delegate = self
        if self.exc_type == "2" { // no dashboard but gym
            self.btn_search.isHidden = true
            self.txt_search.delegate = self
            self.all_exc_list()
        } else if (self.str_profile_dashboard == "2") {
            self.exc_type = "2"
            self.btn_search.isHidden = true
            self.txt_search.delegate = self
            self.all_exc_list()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Construct the full text field text after change
        if self.exc_type == "2" {
            if let text = textField.text as NSString? {
                let newText = text.replacingCharacters(in: range, with: string)
                filterContentForSearchText(newText)
            }
        }
        
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // Handle clearing the text field
        filterContentForSearchText("")
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    @objc func continue_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "workout_details_id") as? workout_details
        push!.str_type_before_submit = String(self.exc_type)
        self.navigationController?.pushViewController(push!, animated: true)
    }
    
    @objc func search_workout() {
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
        let activity = String(self.txt_search.text!).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: calories_burned_aerobics_URL+activity!)!
        var request = URLRequest(url: url)
        request.setValue(excercise_api_key, forHTTPHeaderField: "X-Api-Key")
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            
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
            
            do {
                // Try parsing JSON
                let json = try JSONSerialization.jsonObject(with: responseData, options: [])
                print("Response JSON: \(json)")
                // Handle the JSON response here
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    ERProgressHud.sharedInstance.hide()
                     self.arr_all_activities_data = (json as! Array<Any>)
                    
                    self.set_custom()
                    
                }
            } catch let error {
                ERProgressHud.sharedInstance.hide()
                print("Error parsing JSON: \(error.localizedDescription)")
                print("Response Data: \(String(data: responseData, encoding: .utf8) ?? "Empty")")
            }
            
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
        }
        task.resume()
        
    }
    
    @objc func set_custom() {
        
        for indexx in 0..<self.arr_all_activities_data.count {
            let item = self.arr_all_activities_data[indexx] as? [String:Any]
            
            let custom = [
                "name":(item!["name"] as! String),
                "duration_minutes":"\(item!["duration_minutes"]!)",
                "total_calories":"\(item!["total_calories"]!)",
                "status":"no",
            ]
            // self.arr_add_custom_array.add(custom)
            self.arr_add_custom_array.append(custom)
        }
        
        // print(self.arr_add_custom_array as Any)
        self.tble_view.delegate = self
        self.tble_view.dataSource = self
        self.tble_view.reloadData()
        
    }
    
    func updateContinueButtonVisibility() {
        self.btn_continue.isHidden = !isItemSelected
    }
    
    func checkSelectionState() {
        if (self.exc_type == "2") {
            isItemSelected = filteredExercises.contains { $0["status"] as! String == "yes" }
        } else {
            isItemSelected = arr_add_custom_array.contains { $0["status"] as? String == "yes" }
        }
        
        updateContinueButtonVisibility()
    }
    
    @objc func continue_click() {
        
        debugPrint(self.str_profile_dashboard as Any)
        debugPrint(self.exc_type as Any)
        
        if (self.str_profile_dashboard == "2") {
            let (_, dayNumber) = getDayNameAndNumber()
            let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "workout_gym_exc_details_id") as? workout_gym_exc_details
            push!.exc_id = self.selectedName
            push!.str_get_date = "\(dayNumber)"
            push!.arr_get_details = self.get_details
            self.navigationController?.pushViewController(push!, animated: true)
            
            return
        } else {
            if (self.exc_type == "2") {
                let (_, dayNumber) = getDayNameAndNumber()
                let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "workout_gym_exc_details_id") as? workout_gym_exc_details
                push!.exc_id = self.selectedName
                push!.str_get_date = "\(dayNumber)"
                push!.arr_get_details = self.get_details
                push!.str_submit_data_type = "NEW"
                self.navigationController?.pushViewController(push!, animated: true)
                
                return
            } else {
                for indexx in 0..<self.arr_add_custom_array.count {
                    let item = self.arr_add_custom_array[indexx] as? [String:Any]
                    
                    if (item!["status"] as! String) == "yes" {
                        print(item as Any)
                        
                        let custom = [
                            "total_calories":"\(item!["total_calories"]!)",
                            "calories_per_hour":"\(item!["total_calories"]!)",
                            "duration_minutes":"\(item!["duration_minutes"]!)",
                            "name":"\(item!["name"]!)",
                        ]
                        
                        self.get_details.add(custom)
                    }
                }
                
                print(self.get_details as Any)
                
                
                self.add_aerobic_exc_WB(loader: "yes")
            }
            
        }
            /*debugPrint("SHOW DETAILS")
            
        if (self.str_get_date == nil) {
            
            
            
        } else if (self.str_get_date == "") {
            
            for indexx in 0..<self.arr_add_custom_array.count {
                let item = self.arr_add_custom_array[indexx] as? [String:Any]
                
                if (item!["status"] as! String) == "yes" {
                    print(item as Any)
                    
                    let custom = [
                        "total_calories":"\(item!["total_calories"]!)",
                        "calories_per_hour":"\(item!["total_calories"]!)",
                        "duration_minutes":"\(item!["duration_minutes"]!)",
                        "name":"\(item!["name"]!)",
                    ]
                    
                    self.get_details.add(custom)
                }
            }
            
            print(self.get_details as Any)
            
            
            self.add_aerobic_exc_WB(loader: "yes")
            
        } else {
            let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "workout_gym_exc_details_id") as? workout_gym_exc_details
            push!.exc_id = self.selectedName
            push!.str_get_date = String(self.str_get_date)
            push!.arr_get_details = self.get_details
            self.navigationController?.pushViewController(push!, animated: true)
        }*/
            
            
            // return
        // }
        
        // print(self.arr_add_custom_array as Any)
        
        /*for indexx in 0..<self.arr_add_custom_array.count {
            let item = self.arr_add_custom_array[indexx] as? [String:Any]
            
            if (item!["status"] as! String) == "yes" {
                print(item as Any)
                
                let custom = [
                    "total_calories":"\(item!["total_calories"]!)",
                    "calories_per_hour":"\(item!["total_calories"]!)",
                    "duration_minutes":"\(item!["duration_minutes"]!)",
                    "name":"\(item!["name"]!)",
                ]
                
                self.get_details.add(custom)
            }
        }
        
        print(self.get_details as Any)
        
        
        self.add_aerobic_exc_WB(loader: "yes")
        */
    }
    
    @objc func add_aerobic_exc_WB(loader:String) {
        
        if (loader == "yes") {
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
                
                let (_, dayNumber) = getDayNameAndNumber()
                
                if (self.str_profile_dashboard == "1") {
                    
                    
                        let immutableArray = NSArray(array: self.get_details)
                        print(immutableArray)
                        
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: immutableArray, options: .prettyPrinted)
                            
                            if let jsonString = String(data: jsonData, encoding: .utf8) {
                                print(jsonString)
                                
                                parameters = [
                                    "action"                : "myworkoutadd",
                                    "userId"                : String(myString),
                                    "date"                  : String(self.str_get_date),
                                    "json_record_details"   : String(jsonString),
                                ]
                                
                            }
                        } catch {
                            print("Error converting to JSON: \(error)")
                        }
                    
                    
                    
                } else {
                    
                    let defaults = UserDefaults.standard
                    if let myString2 = defaults.string(forKey: "key_save_day") {
                        print("defaults savedString: \(myString2)")
                        
                        parameters = [
                            "action"            : "day_wise_excercise_add",
                            "userId"            : String(myString),
                            "day"               : String(myString2),
                            "excercise_name"    : String(self.selectedName!),
                            "excercise_id"      : String(self.selectedName!),
                            "excercise_type"    : String("1"),
                            
                        ]
                        
                    } else {
                        parameters = [
                            "action"            : "day_wise_excercise_add",
                            "userId"            : String(myString),
                            "day"               : String(dayNumber),
                            "excercise_name"    : String(self.selectedName!),
                            "excercise_id"      : String(self.selectedName!),
                            "excercise_type"    : String("1"),
                            
                        ]
                    }
                    
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
                                ERProgressHud.sharedInstance.hide()
                                
                                let defaults = UserDefaults.standard
                                
                                defaults.set(nil, forKey: "key_save_dashboard_right_arrow")
                                defaults.set(nil, forKey: "key_save_aerobics")
                                defaults.set(nil, forKey: "key_save_gym")
                                defaults.set(nil, forKey: "key_save_day")
                                
                                if let navigationController = self.navigationController {
                                    for viewController in navigationController.viewControllers {
                                        if let screen1VC = viewController as? days_workout {
                                            navigationController.popToViewController(screen1VC, animated: true)
                                            break
                                        }
                                    }
                                }
                            } else {
                                if (JSON["msg"] as? String == your_are_not_auth) {
                                    TokenManager.shared.refresh_token_WB { token, error in
                                        if let token = token {
                                            print("Token received: \(token)")
                                            
                                            let str_token = "\(token)"
                                            UserDefaults.standard.set("", forKey: str_save_last_api_token)
                                            UserDefaults.standard.set(str_token, forKey: str_save_last_api_token)
                                            
                                            self.add_aerobic_exc_WB(loader: "no")
                                            
                                        } else if let error = error {
                                            print("Failed to refresh token: \(error.localizedDescription)")
                                            // Handle the error
                                        }
                                    }
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
                TokenManager.shared.refresh_token_WB { token, error in
                    if let token = token {
                        print("Token received: \(token)")
                        
                        let str_token = "\(token)"
                        UserDefaults.standard.set("", forKey: str_save_last_api_token)
                        UserDefaults.standard.set(str_token, forKey: str_save_last_api_token)
                        
                        self.add_aerobic_exc_WB(loader: "no")
                        
                    } else if let error = error {
                        print("Failed to refresh token: \(error.localizedDescription)")
                        // Handle the error
                    }
                }
            }
        }
    }
    
    
    // all exc
    @objc func all_exc_list() {
       
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
          
        let headers = [
            "x-rapidapi-key": all_exercise_api_key,
            "x-rapidapi-host": all_exercise_host
        ]

        let request = NSMutableURLRequest(url: NSURL(string: all_exercise_list_URL)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if let httpResponse = response as? HTTPURLResponse, let data = data {
                if httpResponse.statusCode == 200 {
                    do {
                        // Print the raw data as a string for debugging
                        if let rawString = String(data: data, encoding: .utf8) {
                            // print("Raw response string: \(rawString)")
                        }
                        
                        // Try to parse the JSON data
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        
                        // Initialize the array to hold the custom dictionaries
                        
                        
                        // Check if the parsed JSON is a dictionary
                        if let jsonObject = json as? [String: Any],
                           let exercisesIds = jsonObject["excercises_ids"] as? [String] {
                            
                            print(jsonObject as Any)
                            
                            self.customExercises.removeAll()
                            
                            for exercise in exercisesIds {
                                let custom = [
                                    "name": exercise,
                                    "status": "no"
                                ]
                                self.customExercises.append(custom)
                            }
                            
                            self.filteredExercises = self.customExercises
                            
                            // Print the customExercises array to check the result
                            print(self.customExercises)
                            DispatchQueue.main.async {
                                // Update the table view data and reload
                                ERProgressHud.sharedInstance.hide()
                                self.tble_view.delegate = self
                                self.tble_view.dataSource = self
                                self.tble_view.reloadData()
                            }
                            
                        } else {
                            print("JSON is neither an array nor a dictionary")
                        }
                    } catch let parseError {
                        print("JSON Error: \(parseError.localizedDescription)")
                    }
 
                } else {
                    print("HTTP Error: \(httpResponse.statusCode)")
                }
            }
        })

        dataTask.resume()

    }
    
    func filterContentForSearchText(_ searchText: String) {
        if searchText.isEmpty {
            filteredExercises = self.customExercises
        } else {
            filteredExercises = self.customExercises.filter { exercise in
                guard let exerciseName = exercise["name"] else { return false }
                return exerciseName.lowercased().contains(searchText.lowercased())
            }
        }
        
        tble_view.reloadData()
    }


    
}

//MARK:- TABLE VIEW -
extension select_workout: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (self.exc_type == "2") {
            return self.filteredExercises.count
        } else {
            return self.arr_add_custom_array.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:select_workout_table_cell = tableView.dequeueReusableCell(withIdentifier: "select_workout_table_cell") as! select_workout_table_cell
        
        if (self.exc_type == "2") {
            
            let item = self.filteredExercises[indexPath.row] as? [String:Any]
            print(item as Any)
            
            cell.lbl_title.text = (item!["name"] as! String)
            cell.lbl_sub_title.text = ""
            cell.lbl_cal.text = ""
            
            if (item!["status"] as! String) == "yes" {
                cell.btn_add.setImage(UIImage(named: "plus"), for: .normal)
            } else {
                cell.btn_add.setImage(UIImage(named: "plus1"), for: .normal)
            }
            
            cell.backgroundColor = .clear
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            
        } else {
            let item = self.arr_add_custom_array[indexPath.row] as? [String:Any]
            cell.lbl_title.text = (item!["name"] as! String)
            cell.lbl_sub_title.text = "\(item!["duration_minutes"]!) Min"
            cell.lbl_cal.text = "\(item!["total_calories"]!) Cal"
            
            if (item!["status"] as! String) == "yes" {
                cell.btn_add.setImage(UIImage(named: "plus"), for: .normal)
            } else {
                cell.btn_add.setImage(UIImage(named: "plus1"), for: .normal)
            }
            
            cell.backgroundColor = .clear
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            
        }
        
        // self.btn_continue.addTarget(self, action: #selector(continue_click_method), for: .touchUpInside)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if self.exc_type == "2" {
            for (index, var item) in filteredExercises.enumerated() {
                if index == indexPath.row {
                    item["status"] = "yes"
                    selectedName = (item["name"] as? String)
                } else {
                    item["status"] = "no"
                }
                filteredExercises[index] = item
            }
            
            // Update filteredExercises if filtered
            if !self.txt_search.text!.isEmpty {
                for (index, var item) in filteredExercises.enumerated() {
                    if index == indexPath.row {
                        item["status"] = "yes"
                        selectedName = (item["name"] as? String)
                    } else {
                        item["status"] = "no"
                    }
                    filteredExercises[index] = item
                }
            }
            
            checkSelectionState()
        } else {
            for (index, var item) in arr_add_custom_array.enumerated() {
                if index == indexPath.row {
                    item["status"] = "yes"
                    selectedName = item["name"] as? String
                } else {
                    item["status"] = "no"
                }
                arr_add_custom_array[index] = item
            }
            
            checkSelectionState()
        }
        
        self.tble_view.reloadData()
    }

    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        // Update status of the deselected item
        
        if (self.exc_type == "2") {
            var item = customExercises[indexPath.row]
            item["status"] = "no"
            customExercises[indexPath.row] = item
            
            selectedName = nil
            
            // Check if any item is selected
            checkSelectionState()
        } else {
            var item = arr_add_custom_array[indexPath.row]
            item["status"] = "no"
            arr_add_custom_array[indexPath.row] = item
            
            selectedName = nil
            
            // Check if any item is selected
            checkSelectionState()
        }
       
        
        // Reload the table view to reflect updated selection state
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}
