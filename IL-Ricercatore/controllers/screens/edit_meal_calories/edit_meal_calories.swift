//
//  edit_meal_calories.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 19/12/23.
//

import UIKit
import Alamofire

class edit_meal_calories: UIViewController, UITextFieldDelegate {
    
    var dict_get_value:NSDictionary!
    
    @IBOutlet weak var btn_Submit:UIButton! {
        didSet {
            btn_Submit.layer.cornerRadius = 8
            btn_Submit.clipsToBounds = true
            btn_Submit.setTitle("Submit", for: .normal)
            btn_Submit.setTitleColor(.white, for: .normal)
        }
    }
    
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
            lbl_navigation_title.text = navigation_title_edit_meals_calories_en
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
        
        self.btn_Submit.addTarget(self, action: #selector(submit), for: .touchUpInside)
        
        btn_reset.addTarget(self, action: #selector(edit_calorie_budget_click_method), for: .touchUpInside)
        
    }
    
    @objc func edit_calorie_budget_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "track_meal_reminder_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! edit_meals_and_calories_table_cell
        
        if (textField == cell.txt_breakfast) {
            if let currentText = textField.text as NSString? {
                let updatedText = currentText.replacingCharacters(in: range, with: string)
                //myString = updatedText
                print("Updated string: \(updatedText)")
                
                self.calculate(value: "\(updatedText)",type: "1")
            }
            
        } else if (textField == cell.txt_morning_snack) {
            if let currentText = textField.text as NSString? {
                let updatedText = currentText.replacingCharacters(in: range, with: string)
                //myString = updatedText
                print("Updated string: \(updatedText)")
                
                self.calculate(value: "\(updatedText)",type: "2")
            }
            
        } else if (textField == cell.txt_lunch) {
            if let currentText = textField.text as NSString? {
                let updatedText = currentText.replacingCharacters(in: range, with: string)
                //myString = updatedText
                print("Updated string: \(updatedText)")
                
                self.calculate(value: "\(updatedText)",type: "3")
            }
            
        } else if (textField == cell.txt_eve_snack) {
            if let currentText = textField.text as NSString? {
                let updatedText = currentText.replacingCharacters(in: range, with: string)
                //myString = updatedText
                print("Updated string: \(updatedText)")
                
                self.calculate(value: "\(updatedText)",type: "4")
            }
            
        } else if (textField == cell.txt_dinner) {
            if let currentText = textField.text as NSString? {
                let updatedText = currentText.replacingCharacters(in: range, with: string)
                //myString = updatedText
                print("Updated string: \(updatedText)")
                
                self.calculate(value: "\(updatedText)",type: "5")
            }
            
        }
        return true
    }
    
    
    @objc func calculate(value:String,type:String) {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! edit_meals_and_calories_table_cell
        
        let userValueString = String(value)
        let serverValueString = "\(self.dict_get_value["cal_total"]!)"

        if let percentage = calculatePercentage(userValueString: userValueString, serverValueString: serverValueString) {
            // print("\(userValueString)% of \(serverValueString) is \(percentage)%")
            
            if (type == "1") {
                cell.lbl_break_fast_two.text = "\(percentage) Cal"
            } else if (type == "2") {
                cell.lbl_morning_snack_two.text = "\(percentage) Cal"
            } else if (type == "3") {
                cell.lbl_lunch_two.text = "\(percentage) Cal"
            } else if (type == "4") {
                cell.lbl_evening_snack_two.text = "\(percentage) Cal"
            } else {
                cell.lbl_dinner_two.text = "\(percentage) Cal"
            }
        } else {
            print("Failed to calculate percentage")
        }
    }
   
    
    @objc func submit() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! edit_meals_and_calories_table_cell
        
        let value1 = String(cell.txt_breakfast.text!)
        let value2 = String(cell.txt_morning_snack.text!)
        let value3 = String(cell.txt_lunch.text!)
        let value4 = String(cell.txt_eve_snack.text!)
        let value5 = String(cell.txt_dinner.text!)

        if let result = addFiveValues(value1: value1, value2: value2, value3: value3, value4: value4, value5: value5) {
            // print("Sum of values: \(result)")
            
            if "\(result)" == "100" {
                self.edit_profile_WB()
            } else {
                self.view.makeToast("Please enter valid meal details.")
            }
        } else {
            print("Failed to add values due to invalid input")
        }
        
    }
    
    @objc func edit_profile_WB() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! edit_meals_and_calories_table_cell
        
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
                    "action"                    : "editprofile",
                    "userId"                    : String(myString),
                    "calbudget_breakfast"       : "\(self.dict_get_value["calbudget_breakfast"]!)",
                    "calbudget_morningSnack"    : "\(self.dict_get_value["calbudget_morningSnack"]!)",
                    "calbudget_lunch"           : "\(self.dict_get_value["calbudget_lunch"]!)",
                    "calbudget_eveningSnack"    : "\(self.dict_get_value["calbudget_eveningSnack"]!)",
                    "calbudget_dinner"          : "\(self.dict_get_value["calbudget_dinner"]!)",
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
                               
                                self.navigationController?.popViewController(animated: true)
                            }
                            else {
                                self.refresh_token_WB3()
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
                        
                        self.edit_profile_WB()
                        
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
extension edit_meal_calories: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:edit_meals_and_calories_table_cell = tableView.dequeueReusableCell(withIdentifier: "edit_meals_and_calories_table_cell") as! edit_meals_and_calories_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        cell.txt_lunch.delegate = self
        cell.txt_dinner.delegate = self
        cell.txt_breakfast.delegate = self
        cell.txt_eve_snack.delegate = self
        cell.txt_morning_snack.delegate = self
        // cell.btn_continue.addTarget(self, action: #selector(complete_profile_click_method), for: .touchUpInside)
        
        cell.lbl_total_cal.text = "\(self.dict_get_value["cal_total"]!)"
        
        if "\(self.dict_get_value["calbudget_breakfast"]!)" == "" {
            debugPrint("test")
            
            cell.txt_breakfast.text = "25"
            cell.txt_morning_snack.text = "12.5"
            cell.txt_lunch.text = "25"
            cell.txt_eve_snack.text = "12.5"
            cell.txt_dinner.text = "25"
            
            
            if let percentage1 = calculatePercentage(userValueString: "25", serverValueString: "\(self.dict_get_value["cal_total"]!)") {
                cell.lbl_break_fast_two.text = "\(percentage1) Cal"
            } else {
                print("Failed to calculate percentage")
            }
            
            
            if let percentage2 = calculatePercentage(userValueString: "12.5", serverValueString: "\(self.dict_get_value["cal_total"]!)") {
                cell.lbl_morning_snack_two.text = "\(percentage2) Cal"
            } else {
                print("Failed to calculate percentage")
            }
            
            if let percentage3 = calculatePercentage(userValueString: "25", serverValueString: "\(self.dict_get_value["cal_total"]!)") {
                cell.lbl_lunch_two.text = "\(percentage3) Cal"
            } else {
                print("Failed to calculate percentage")
            }
            
            if let percentage4 = calculatePercentage(userValueString: "12.5", serverValueString: "\(self.dict_get_value["cal_total"]!)") {
                cell.lbl_evening_snack_two.text = "\(percentage4) Cal"
            } else {
                print("Failed to calculate percentage")
            }
            
            
            if let percentage5 = calculatePercentage(userValueString: "25", serverValueString: "\(self.dict_get_value["cal_total"]!)") {
                cell.lbl_dinner_two.text = "\(percentage5) Cal"
            } else {
                print("Failed to calculate percentage")
            }

        } else {
        
            cell.txt_breakfast.text = "\(self.dict_get_value["calbudget_breakfast"]!)"
            cell.txt_morning_snack.text = "\(self.dict_get_value["calbudget_morningSnack"]!)"
            cell.txt_lunch.text = "\(self.dict_get_value["calbudget_lunch"]!)"
            cell.txt_eve_snack.text = "\(self.dict_get_value["calbudget_eveningSnack"]!)"
            cell.txt_dinner.text = "\(self.dict_get_value["calbudget_dinner"]!)"
            
            //
            if let percentage1 = calculatePercentage(userValueString: "\(self.dict_get_value["calbudget_breakfast"]!)", serverValueString: "\(self.dict_get_value["cal_total"]!)") {
                cell.lbl_break_fast_two.text = "\(percentage1) Cal"
            } else {
                print("Failed to calculate percentage")
            }
            
            
            if let percentage2 = calculatePercentage(userValueString: "\(self.dict_get_value["calbudget_morningSnack"]!)", serverValueString: "\(self.dict_get_value["cal_total"]!)") {
                cell.lbl_morning_snack_two.text = "\(percentage2) Cal"
            } else {
                print("Failed to calculate percentage")
            }
            
            if let percentage3 = calculatePercentage(userValueString: "\(self.dict_get_value["calbudget_lunch"]!)", serverValueString: "\(self.dict_get_value["cal_total"]!)") {
                cell.lbl_lunch_two.text = "\(percentage3) Cal"
            } else {
                print("Failed to calculate percentage")
            }
            
            if let percentage4 = calculatePercentage(userValueString: "\(self.dict_get_value["calbudget_eveningSnack"]!)", serverValueString: "\(self.dict_get_value["cal_total"]!)") {
                cell.lbl_evening_snack_two.text = "\(percentage4) Cal"
            } else {
                print("Failed to calculate percentage")
            }
            
            
            if let percentage5 = calculatePercentage(userValueString: "\(self.dict_get_value["calbudget_dinner"]!)", serverValueString: "\(self.dict_get_value["cal_total"]!)") {
                cell.lbl_dinner_two.text = "\(percentage5) Cal"
            } else {
                print("Failed to calculate percentage")
            }
            
        }
        
        
        
        
        
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 434
    }

}
