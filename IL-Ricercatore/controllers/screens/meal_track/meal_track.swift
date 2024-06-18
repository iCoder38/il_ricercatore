//
//  meal_track.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 03/04/24.
//

import UIKit
import Alamofire
import SDWebImage

class meal_track: UIViewController {
    
    var arr_meal_track:NSMutableArray! = []
    var arr_all_mutable_array:NSMutableArray! = []
    
    // Data for sections and rows
    let sections = ["Breakfast", "Morning Snack","Lunch","Evening Snack","Dinner"]
    var section1Data:NSMutableArray! = []// = ["Row 1", "Row 2", "Row 3"]
    let section2Data:NSMutableArray! = []// = ["Row A", "Row B"]
    let section3Data:NSMutableArray! = []//
    let section4Data:NSMutableArray! = []//
    let section5Data:NSMutableArray! = []//
    
    @IBOutlet weak var lbl_navigation_title:UILabel! {
        didSet {
            lbl_navigation_title.text = navigation_title_meal_track
        }
    }
    
    @IBOutlet weak var btn_back:UIButton! {
        didSet {
            btn_back.tintColor = .white
            btn_back.setImage(UIImage(systemName: "arrow.left"), for: .normal)
            btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        }
    }
    @IBOutlet weak var btn_add:UIButton! {
        didSet {
            btn_add.isHidden = true
            btn_add.addTarget(self, action: #selector(add_click_method), for: .touchUpInside)
        }
    }
    @IBOutlet weak var tble_view:UITableView! {
        didSet {
            
            tble_view.layer.cornerRadius = 22
            tble_view.clipsToBounds = true
            tble_view.backgroundColor = .white
        }
    }
    
    @IBOutlet weak var view_one:UIView! {
        didSet {
            view_one.layer.cornerRadius = 8
            view_one.clipsToBounds = true
            view_one.backgroundColor = light_purple_color
             
            
        }
    }
    @IBOutlet weak var view_two:UIView! {
        didSet {
            view_two.layer.cornerRadius = 8
            view_two.clipsToBounds = true
            view_two.backgroundColor = light_purple_color
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
          
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.meal_track_record_WB(loader: "yes")
    }
    
    @objc func add_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "select_meal_id") as? select_meal
        push!.array = section1Data as! [[String : Any]]
        push?.getData = section1Data
        self.navigationController?.pushViewController(push!, animated: true)
    }
    @objc func meal_track_record_WB(loader:String) {
        // let indexPath = IndexPath.init(row: 0, section: 0)
        // let cell = self.tble_view.cellForRow(at: indexPath) as! meal_track_table_cell
        
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
                    "action"        : "foodlist",
                    "userId"        : String(myString),
                    "startDate"     : Date.getCurrentDateCustom(),
                    "enddate"       : Date.getCurrentDateCustom(),
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
                                
                                self.arr_meal_track.removeAllObjects()
                                self.section1Data.removeAllObjects()
                                self.section2Data.removeAllObjects()
                                self.section3Data.removeAllObjects()
                                self.section4Data.removeAllObjects()
                                self.section5Data.removeAllObjects()
                                var ar : NSArray!
                                ar = (JSON["data"] as! Array<Any>) as NSArray
                                self.arr_meal_track.addObjects(from: ar as! [Any])
                                
                                // print(self.arr_meal_track as Any)
                                
                                var ar2 : NSArray!
                                var ar_morning_snack : NSArray!
                                var ar_lunch : NSArray!
                                var ar_evening_snack : NSArray!
                                var ar_dinner : NSArray!
                                
                                
                                for indexx in 0..<self.arr_meal_track.count {
                                    print(indexx as Any)
                                    let item = self.arr_meal_track[indexx] as? [String:Any]
                                    
                                    
                                    ar2 = (item!["breakfast_json"] as! Array<Any>) as NSArray
                                    print(ar2 as Any)
                                    // one more loop for morning
                                    for morning_indexx in 0..<ar2.count {
                                        let item = ar2[morning_indexx] as? [String:Any]
                                        // print(morning_indexx as Any)
                                        
                                        
                                        let custom = [
                                            
                                            "calories":"\(item!["calories"]!)",
                                            "carbohydrates_total_g":"\(item!["carbohydrates_total_g"]!)",
                                            "cholesterol_mg":"\(item!["cholesterol_mg"]!)",
                                            "fat_saturated_g":"\(item!["fat_saturated_g"]!)",
                                            "fat_total_g":"\(item!["fat_total_g"]!)",
                                            "fiber_g":"\(item!["fiber_g"]!)",
                                            "name":"\(item!["name"]!)",
                                            "potassium_mg":"\(item!["potassium_mg"]!)",
                                            "protein_g":"\(item!["protein_g"]!)",
                                            "serving_size_g":"\(item!["serving_size_g"]!)",
                                            "sodium_mg":"\(item!["sodium_mg"]!)",
                                            "sugar_g":"\(item!["sugar_g"]!)",
                                        ]
                                        section1Data.add(custom)//append(contentsOf: custom)
                                        
                                        
                                    }
                                    
                                    // loop for morning snack
                                    ar_morning_snack = (item!["morning_snack_json"] as! Array<Any>) as NSArray
                                    print(ar_morning_snack as Any)
                                    for morning_snack_indexx in 0..<ar_morning_snack.count {
                                        let item = ar_morning_snack[morning_snack_indexx] as? [String:Any]
                                        // print(morning_indexx as Any)
                                     
                                        
                                        let custom = [
                                            
                                            "calories":"\(item!["calories"]!)",
                                            "carbohydrates_total_g":"\(item!["carbohydrates_total_g"]!)",
                                            "cholesterol_mg":"\(item!["cholesterol_mg"]!)",
                                            "fat_saturated_g":"\(item!["fat_saturated_g"]!)",
                                            "fat_total_g":"\(item!["fat_total_g"]!)",
                                            "fiber_g":"\(item!["fiber_g"]!)",
                                            "name":"\(item!["name"]!)",
                                            "potassium_mg":"\(item!["potassium_mg"]!)",
                                            "protein_g":"\(item!["protein_g"]!)",
                                            "serving_size_g":"\(item!["serving_size_g"]!)",
                                            "sodium_mg":"\(item!["sodium_mg"]!)",
                                            "sugar_g":"\(item!["sugar_g"]!)",
                                        ]
                                        
                                        section2Data.add(custom)
                                        
                                    }
                                    // loop for lunch
                                    ar_lunch = (item!["lunch_json"] as! Array<Any>) as NSArray
                                    print(ar_lunch as Any)
                                    for lunch_indexx in 0..<ar_lunch.count {
                                        let item = ar_lunch[lunch_indexx] as? [String:Any]
                                        // print(morning_indexx as Any)
                                     
                                        
                                        let custom = [
                                            
                                            "calories":"\(item!["calories"]!)",
                                            "carbohydrates_total_g":"\(item!["carbohydrates_total_g"]!)",
                                            "cholesterol_mg":"\(item!["cholesterol_mg"]!)",
                                            "fat_saturated_g":"\(item!["fat_saturated_g"]!)",
                                            "fat_total_g":"\(item!["fat_total_g"]!)",
                                            "fiber_g":"\(item!["fiber_g"]!)",
                                            "name":"\(item!["name"]!)",
                                            "potassium_mg":"\(item!["potassium_mg"]!)",
                                            "protein_g":"\(item!["protein_g"]!)",
                                            "serving_size_g":"\(item!["serving_size_g"]!)",
                                            "sodium_mg":"\(item!["sodium_mg"]!)",
                                            "sugar_g":"\(item!["sugar_g"]!)",
                                        ]
                                        
                                        section3Data.add(custom)
                                        
                                    }
                                    
                                    // loop for evening snack
                                    ar_evening_snack = (item!["evening_snack_json"] as! Array<Any>) as NSArray
                                    print(ar_evening_snack as Any)
                                    for evening_snack_indexx in 0..<ar_evening_snack.count {
                                        let item = ar_evening_snack[evening_snack_indexx] as? [String:Any]
                                        // print(morning_indexx as Any)
                                        
                                        
                                        let custom = [
                                            
                                            "calories":"\(item!["calories"]!)",
                                            "carbohydrates_total_g":"\(item!["carbohydrates_total_g"]!)",
                                            "cholesterol_mg":"\(item!["cholesterol_mg"]!)",
                                            "fat_saturated_g":"\(item!["fat_saturated_g"]!)",
                                            "fat_total_g":"\(item!["fat_total_g"]!)",
                                            "fiber_g":"\(item!["fiber_g"]!)",
                                            "name":"\(item!["name"]!)",
                                            "potassium_mg":"\(item!["potassium_mg"]!)",
                                            "protein_g":"\(item!["protein_g"]!)",
                                            "serving_size_g":"\(item!["serving_size_g"]!)",
                                            "sodium_mg":"\(item!["sodium_mg"]!)",
                                            "sugar_g":"\(item!["sugar_g"]!)",
                                        ]
                                        
                                        section4Data.add(custom)
                                        
                                    }
                                    
                                    // loop for dinner
                                    ar_dinner = (item!["dinner_json"] as! Array<Any>) as NSArray
                                    print(ar_dinner as Any)
                                    for dinner_indexx in 0..<ar_dinner.count {
                                        let item = ar_dinner[dinner_indexx] as? [String:Any]
                                        // print(morning_indexx as Any)
                                       
                                        
                                        let custom = [
                                            
                                            "calories":"\(item!["calories"]!)",
                                            "carbohydrates_total_g":"\(item!["carbohydrates_total_g"]!)",
                                            "cholesterol_mg":"\(item!["cholesterol_mg"]!)",
                                            "fat_saturated_g":"\(item!["fat_saturated_g"]!)",
                                            "fat_total_g":"\(item!["fat_total_g"]!)",
                                            "fiber_g":"\(item!["fiber_g"]!)",
                                            "name":"\(item!["name"]!)",
                                            "potassium_mg":"\(item!["potassium_mg"]!)",
                                            "protein_g":"\(item!["protein_g"]!)",
                                            "serving_size_g":"\(item!["serving_size_g"]!)",
                                            "sodium_mg":"\(item!["sodium_mg"]!)",
                                            "sugar_g":"\(item!["sugar_g"]!)",
                                        ]
                                        
                                        section5Data.add(custom)
                                        
                                    }
                                    
                                }
                                
                                
                                // print(arr_all_mutable_array as Any)
                                
                                
                                
                                
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
                        
                        self.meal_track_record_WB(loader: "no")
                        
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
    
    @objc func date_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! meal_track_table_cell
        
        RPicker.selectDate(title: "Select date", cancelText: "Cancel", datePickerMode: .date,maxDate: Date.now, didSelectDate: { (selectedDate) in
            cell.lbl_time.text = selectedDate.dateString("yyyy-MM-dd")
            self.meal_track_record_WB(loader: "yes")
        })
        
        
    }
}

//MARK:- TABLE VIEW -
extension meal_track: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = CustomHeaderView()
        print(section)
        
        // Set the title of the button based on the section
            switch section {
            case 0:
                headerView.button.setTitle("    Breakfast", for: .normal)
            case 1:
                headerView.button.setTitle("    Morning Snack", for: .normal)
            case 2:
                headerView.button.setTitle("    Lunch", for: .normal)
            case 3:
                headerView.button.setTitle("    Evening Snack", for: .normal)
            case 4:
                headerView.button.setTitle("    Dinner", for: .normal)
            // Add cases for other sections if needed
            default:
                break
            }
        
        headerView.buttonr.tag = section
        headerView.buttonr.addTarget(self, action: #selector(button_r_click_method), for: .touchUpInside)
        return headerView
    }
    
    @objc func button_r_click_method(_ sender:UIButton) {
        // print(sender.tag)
        
        
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "select_meal_id") as? select_meal
        push!.array = section1Data as! [[String : Any]]
        
        if (sender.tag == 0) {
            push!.str_param_key = "breakfast_json"
            push?.getData = section1Data
        } else if (sender.tag == 1) {
            push!.str_param_key = "morning_snack_json"
            push?.getData = section2Data
        } else if (sender.tag == 2) {
            push!.str_param_key = "lunch_json"
            push?.getData = section3Data
        } else if (sender.tag == 3) {
            push!.str_param_key = "evening_snack_json"
            push?.getData = section4Data
        } else if (sender.tag == 4) {
            push!.str_param_key = "dinner_json"
            push?.getData = section5Data
        } else {
            push!.str_param_key = "breakfast_json"
            push?.getData = section1Data
        }
        self.navigationController?.pushViewController(push!, animated: true)
        
        
    }
    
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            switch section {
            case 0:
                return section1Data.count
            case 1:
                return section2Data.count
            case 2:
                return section3Data.count
            case 3:
                return section4Data.count
            case 4:
                return section5Data.count
            default:
                return 0
            }
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:meal_track_table_cell = tableView.dequeueReusableCell(withIdentifier: "meal_track_table_cell") as! meal_track_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        cell.backgroundColor = light_pink_color
        
        switch indexPath.section {
        case 0:
            let item = self.section1Data[indexPath.row] as? [String:Any]
            cell.lbl_title.text = "\(item!["name"]!)"
            cell.lbl_sub_title.text = "\(item!["serving_size_g"]!) g"
            cell.lbl_cal.text = "Calories: \(item!["calories"]!)"
        case 1:
            let item = self.section2Data[indexPath.row] as? [String:Any]
            cell.lbl_title.text = "\(item!["name"]!)"
            cell.lbl_sub_title.text = "\(item!["serving_size_g"]!) g"
            cell.lbl_cal.text = "Calories: \(item!["calories"]!)"
        case 2:
            let item = self.section3Data[indexPath.row] as? [String:Any]
            cell.lbl_title.text = "\(item!["name"]!)"
            cell.lbl_sub_title.text = "\(item!["serving_size_g"]!) g"
            cell.lbl_cal.text = "Calories: \(item!["calories"]!)"
        case 3:
            let item = self.section4Data[indexPath.row] as? [String:Any]
            cell.lbl_title.text = "\(item!["name"]!)"
            cell.lbl_sub_title.text = "\(item!["serving_size_g"]!) g"
            cell.lbl_cal.text = "Calories: \(item!["calories"]!)"
        case 4:
            let item = self.section5Data[indexPath.row] as? [String:Any]
            cell.lbl_title.text = "\(item!["name"]!)"
            cell.lbl_sub_title.text = "\(item!["serving_size_g"]!) g"
            cell.lbl_cal.text = "Calories: \(item!["calories"]!)"
        default:
            break
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }

}
class CustomHeaderView: UIView {
    
    let button: UIButton = {
        let button = UIButton()
        button.setTitle(" Button", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont(name: "Avenir Next Demi Bold", size: 22)
        button.contentHorizontalAlignment = .left;
        return button
    }()
    
    let buttonr: UIButton = {
        let buttonr = UIButton()
        buttonr.setTitle("", for: .normal)
        buttonr.setTitleColor(.black, for: .normal)
        buttonr.translatesAutoresizingMaskIntoConstraints = false
        buttonr.titleLabel?.font = UIFont(name: "Avenir Next Demi Bold", size: 22)
        buttonr.setImage(UIImage(named: "plus"), for: .normal)
        buttonr.contentHorizontalAlignment = .right;
        return buttonr
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(button)
        addSubview(buttonr)
        
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0), // Anchor to leading edge of CustomHeaderView
            button.topAnchor.constraint(equalTo: topAnchor, constant: -6), // Anchor to top edge of CustomHeaderView
            
            buttonr.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10), // Anchor to trailing edge of CustomHeaderView
            buttonr.topAnchor.constraint(equalTo: topAnchor, constant: -6),
            
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
