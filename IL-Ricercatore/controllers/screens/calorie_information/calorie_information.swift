//
//  calorie_information.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 19/12/23.
//

import UIKit
import Alamofire

class calorie_information: UIViewController, UITextFieldDelegate {

    var dict_get_value:NSDictionary!
    
    
    var store_protien:String!
    var store_carbs:String!
    var store_fats:String!
    
    @IBOutlet weak var btn_Submit:UIButton! {
        didSet {
            btn_Submit.layer.cornerRadius = 8
            btn_Submit.clipsToBounds = true
            btn_Submit.setTitle("Submit", for: .normal)
            btn_Submit.setTitleColor(.white, for: .normal)
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
            lbl_navigation_title.text = navigation_title_calorie_counter_en
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
        
        print(self.dict_get_value as Any)
        
        self.btn_Submit.addTarget(self, action: #selector(submit), for: .touchUpInside)
        
        self.tble_view.reloadData()
    }
    
    @objc func edit_calorie_budget_click_method() {
        /*let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "eat_meal_time_id")
        self.navigationController?.pushViewController(push, animated: true)*/
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! calorie_information_table_cell
        
        if (textField == cell.txt_protien) {
            if let currentText = textField.text as NSString? {
                let updatedText = currentText.replacingCharacters(in: range, with: string)
                //myString = updatedText
                print("Updated string: \(updatedText)")
                
                self.calculate_protien(protienValue: "\(updatedText)")
            }
            
        } else  if (textField == cell.txt_carbs) {
            if let currentText = textField.text as NSString? {
                let updatedText = currentText.replacingCharacters(in: range, with: string)
                //myString = updatedText
                print("Updated string: \(updatedText)")
                
                self.calculate_carbs(carbsValue: "\(updatedText)")
            }
            
        }  else  if (textField == cell.txt_fat) {
            if let currentText = textField.text as NSString? {
                let updatedText = currentText.replacingCharacters(in: range, with: string)
                //myString = updatedText
                print("Updated string: \(updatedText)")
                
                self.calculate_fat(carbsValue: "\(updatedText)")
            }
            
        }
        
        return true
    }
    
    @objc func calculate_protien(protienValue:String) {
        let userCaloriesString = "\(self.dict_get_value["cal_total"]!)"
        let userProteinPercentageString = String(protienValue)

        if let proteinGrams = calculateProteinGrams(caloriesString: userCaloriesString, proteinPercentageString: userProteinPercentageString) {
            print("one: \(userCaloriesString)")
            print("%: \(userProteinPercentageString)")
            print("Protein grams: \(proteinGrams)")
            
            let indexPath = IndexPath.init(row: 0, section: 0)
            let cell = self.tble_view.cellForRow(at: indexPath) as! calorie_information_table_cell
            cell.lbl_protien_cal.text = "\(proteinGrams) g"
            self.store_protien = "\(proteinGrams)"
        } else {
            print("Failed to calculate protein grams due to invalid input")
        }
    }
    
    @objc func calculate_carbs(carbsValue:String) {
        let userCaloriesString = "\(self.dict_get_value["cal_total"]!)"
        let userProteinPercentageString = String(carbsValue)

        if let proteinGrams = calculateCarbsGrams(caloriesString: userCaloriesString, proteinPercentageString: userProteinPercentageString) {
            print("one: \(userCaloriesString)")
            print("%: \(userProteinPercentageString)")
            print("carbs grams: \(proteinGrams)")
            
            let indexPath = IndexPath.init(row: 0, section: 0)
            let cell = self.tble_view.cellForRow(at: indexPath) as! calorie_information_table_cell
            cell.lbl_carbs_cal.text = "\(proteinGrams) g"
            self.store_carbs = "\(proteinGrams)"
        } else {
            print("Failed to calculate carbs grams due to invalid input")
        }
    }
    
    @objc func calculate_fat(carbsValue:String) {
        let userCaloriesString = "\(self.dict_get_value["cal_total"]!)"
        let userProteinPercentageString = String(carbsValue)

        if let proteinGrams = calculateFatsGrams(caloriesString: userCaloriesString, proteinPercentageString: userProteinPercentageString) {
            print("one: \(userCaloriesString)")
            print("%: \(userProteinPercentageString)")
            print("carbs grams: \(proteinGrams)")
            
            let indexPath = IndexPath.init(row: 0, section: 0)
            let cell = self.tble_view.cellForRow(at: indexPath) as! calorie_information_table_cell
            cell.lbl_fats_cal.text = "\(proteinGrams) g"
            self.store_fats = "\(proteinGrams)"
        } else {
            print("Failed to calculate carbs grams due to invalid input")
        }
    }
    
    
    @objc func submit() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! calorie_information_table_cell
        
        let value1 = String(cell.txt_fat.text!)
        let value2 = String(cell.txt_carbs.text!)
        let value3 = String(cell.txt_protien.text!)

        if let result = addThreeValues(value1: value1, value2: value2, value3: value3) {
            print("Sum of values: \(result)")
            
            if "\(result)" == "100" {
                self.edit_profile_WB()
            } else {
                self.view.makeToast("Please enter valid nutrition details.")
            }
        } else {
            print("Failed to add values due to invalid input")
        }
        
    }
    
    @objc func edit_profile_WB() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! calorie_information_table_cell
        
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
                    "action"            : "editprofile",
                    "userId"            : String(myString),
                    "cal_total"         : "\(self.dict_get_value["cal_total"]!)",
                    // "dailyBurnCal"      : String(cell.txt_phone.text!),
                    "protineInTake"     : String(cell.txt_protien.text!),
                    "fatInTake"         : String(cell.txt_fat.text!),
                    "varbsInTake"       : String(cell.txt_carbs.text!),
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
extension calorie_information: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:calorie_information_table_cell = tableView.dequeueReusableCell(withIdentifier: "calorie_information_table_cell") as! calorie_information_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        cell.lbl_recommended.text = "\(self.dict_get_value["cal_total"]!)"
        cell.btn_calories_budget.addTarget(self, action: #selector(edit_calorie_budget_click_method), for: .touchUpInside)
        
        cell.txt_fat.delegate = self
        cell.txt_carbs.delegate = self
        cell.txt_protien.delegate = self
        
        cell.txt_fat.text = "\(self.dict_get_value["fatInTake"]!)"
        cell.txt_carbs.text = "\(self.dict_get_value["varbsInTake"]!)"
        cell.txt_protien.text = "\(self.dict_get_value["protineInTake"]!)"
        
        
        if let fatGrams = calculateFatsGrams(caloriesString: "\(self.dict_get_value["cal_total"]!)", proteinPercentageString: "\(self.dict_get_value["fatInTake"]!)") {
            cell.lbl_fats_cal.text = "\(fatGrams) g"
            self.store_fats = "\(fatGrams)"
        } else {
            print("Failed to calculate carbs grams due to invalid input")
        }
        
        if let carbsGrams = calculateCarbsGrams(caloriesString: "\(self.dict_get_value["cal_total"]!)", proteinPercentageString: "\(self.dict_get_value["varbsInTake"]!)") {
            cell.lbl_carbs_cal.text = "\(carbsGrams) g"
            self.store_carbs = "\(carbsGrams)"
        } else {
            print("Failed to calculate carbs grams due to invalid input")
        }
        
        if let proteinGrams = calculateFatsGrams(caloriesString: "\(self.dict_get_value["cal_total"]!)", proteinPercentageString: "\(self.dict_get_value["protineInTake"]!)") {
            cell.lbl_protien_cal.text = "\(proteinGrams) g"
            self.store_protien = "\(proteinGrams)"
        } else {
            print("Failed to calculate carbs grams due to invalid input")
        }
        
        
        
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }

}
