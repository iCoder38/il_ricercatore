//
//  water_intake.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 19/12/23.
//

import UIKit
import Alamofire
import DGCharts

class water_intake: UIViewController {

    var arr_water_list:NSMutableArray! = []
    var get_only_date:String!
    
    var str_total_water:String!
    var str_done_water_count:String!
    
    var str_updated_value:String!
    
    var str_set_date_for_server:String!
    var arr_7_days:NSMutableArray! = []
    
    var str_not_today_date:String! = ""
    
    @IBOutlet weak var btn_menu:UIButton! {
        didSet {
            btn_menu.tintColor = .white
            btn_menu.addTarget(self, action: #selector(menu_click_method), for: .touchUpInside)
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
            lbl_navigation_title.text = navigation_title_water_intake_en
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
        self.tble_view.separatorColor = .white
        
        
        // self.water_intake_check_WB(loader: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.my_profile(loader: "yes")
        
        self.caluclate_last_7_days()
        
    }
    
    @objc func caluclate_last_7_days() {
        
        for indexx in 1...6 {
            let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -indexx, to: Date())
            
            let separate_time = "\(sevenDaysAgo!)".components(separatedBy: " ")
            let before_space_value = separate_time[0]
            
            self.arr_7_days.add(before_space_value as Any)
        }
        print(self.arr_7_days.lastObject as Any)
    }
    
    @objc func reminder_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "water_reminder_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    @objc func water_count_edit_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "set_up_water_tracker_id") as? set_up_water_tracker
        
        push!.str_total_drink_water_count = String(self.str_done_water_count)
        push!.str_total_water_count = String(self.str_total_water)
        
        self.navigationController?.pushViewController(push!, animated: true)
    }
    
    @objc func my_profile(loader:String) {
//        let indexPath = IndexPath.init(row: 0, section: 0)
//        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_three_table_cell
        
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
                    "action"            : "profile",
                    "userId"            : String(myString),
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
                                
                                if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
                                    print(person)
                                    
                                    if "\(person["water_goal"]!)" == "" {
                                        self.str_total_water = "0"
                                    } else {
                                        self.str_total_water = "\(person["water_goal"]!)"
                                    }
                                    
                                    
                                }
                                
                                self.water_intake_check_WB(loader: false)
                            }
                            else {
                                self.refresh_token_WB(type: "1")
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
                self.refresh_token_WB(type: "1")
            }
        }
        
    }
    
    @objc func refresh_token_WB(type:String) {
        
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
                        
                        if (type == "1") {
                            self.my_profile(loader: "no")
                        } else {
                            self.water_intake_check_WB(loader: false)
                        }
                        
                        
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
   
    @objc func water_intake_check_WB(loader:Bool) {
//        let indexPath = IndexPath.init(row: 0, section: 0)
//        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_three_table_cell
        
        var parameters:Dictionary<AnyHashable, Any>!
        
        if (loader == true) {
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
                
                if let date = Calendar.current.date(byAdding: .day, value: -6, to: Date()) {
                    let fullNameArr = "\(date)".components(separatedBy: " ")
                    
                    self.get_only_date    = fullNameArr[0]
                }
                
                parameters = [
                    "action"    : "waterlist",
                    "userId"    : String(myString),
                    "startDate" : String(self.get_only_date),
                    "enddate"   : Date.getCurrentDateCustom(),
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
                                
                                self.arr_water_list.removeAllObjects()
                                
                                var ar : NSArray!
                                ar = (JSON["data"] as! Array<Any>) as NSArray
                                self.arr_water_list.addObjects(from: ar as! [Any])
                                
                                if (self.arr_water_list.count == 0) {
                                    self.str_done_water_count = "0"
                                } else {
                                    let item = self.arr_water_list[0] as? [String:Any]
                                    
                                    print(Date.dateCustomForWaterTaken())
                                    
                                    if (self.str_set_date_for_server) == nil {
                                        if "\(item!["total_glass"]!)" == "" {
                                            self.str_done_water_count = "0"
                                        } else {
                                            self.str_done_water_count = "\(item!["total_glass"]!)"
                                        }
                                    } else {
                                        // some date has been selected
                                        debugPrint("somedate has been selected")
                                        // print(Date.dateCustomForWaterTaken())
                                        
                                        print(self.str_not_today_date as Any)
                                        print(self.str_set_date_for_server as Any)
                                        
                                        for indexx in 0..<self.arr_water_list.count {
                                            let item = self.arr_water_list[indexx] as? [String:Any]
                                            
                                            if (item!["date"] as! String) == String(self.str_not_today_date) {
                                                
                                                print("YES! Date is here")
                                                print(item as Any)
                                                
                                                if "\(item!["total_glass"]!)" == "" {
                                                    self.str_done_water_count = "0"
                                                } else {
                                                    self.str_done_water_count = "\(item!["total_glass"]!)"
                                                }
                                                
                                                self.tble_view.reloadData()
                                                
                                                return
                                            } else {
                                                print("No! This date is not here")
                                                self.str_done_water_count = "0"
                                                
                                            }
                                            
                                        }
                                        self.tble_view.reloadData()
                                        
                                        
                                    }
                                    
                                }
                                
                                self.tble_view.delegate = self
                                self.tble_view.dataSource = self
                                self.tble_view.reloadData()
                                
                            }
                            else {
                                self.refresh_token_WB(type: "2")
                                
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
                self.refresh_token_WB(type: "2")
            }
        }
        
    }
    
    @objc func add_click_method() {
        // let indexPath = IndexPath.init(row: 0, section: 0)
        // let cell = self.tble_view.cellForRow(at: indexPath) as! water_intake_table_cell
        
        print(self.str_total_water as Any)
        print(self.str_done_water_count as Any)
        
        let a: Int? = Int(self.str_done_water_count)
        print(a as Any)
        
        let c: Int? = Int(self.str_done_water_count)
        print(c as Any)
        
        let d: Int? = Int(self.str_total_water)
        print(d as Any)
        
        if (c != d) {
            var sum = a
            sum! += 1
            print(sum as Any)
            
            self.str_done_water_count = "\(sum!)"
            
            self.str_updated_value = "\(sum!)"

            self.tble_view.reloadData()
            
            // self.str_set_date_for_server = "\(Date.getCurrentDateCustom())"
            
            // live
              self.update_one_more_glass_WB(loader: "yes")
        }
        
        
    }
    
    @objc func minus_click_method() {
        // let indexPath = IndexPath.init(row: 0, section: 0)
        // let cell = self.tble_view.cellForRow(at: indexPath) as! water_intake_table_cell
        
        print(self.str_total_water as Any)
        print(self.str_done_water_count as Any)
        
        let a: Int? = Int(self.str_done_water_count)
        print(a as Any)
        
        let c: Int? = Int(self.str_done_water_count)
        print(c as Any)
        
        let d: Int? = Int(self.str_total_water)
        print(d as Any)
        
        if (c != 0) {
            
            var sum = a
            sum! -= 1
            print(sum as Any)
            
            self.str_done_water_count = "\(sum!)"
            
            self.str_updated_value = "\(sum!)"
            
            self.tble_view.reloadData()
            
            // self.str_set_date_for_server = "\(Date.getCurrentDateCustom())"
            
            // live
             self.update_one_more_glass_WB(loader: "yes")
        }
        
    }
    
    // MARK: - ADD ONE GLASS OF WATER -
    @objc func update_one_more_glass_WB(loader:String) {
        // let indexPath = IndexPath.init(row: 0, section: 0)
        // let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_table_cell
        
        var parameters:Dictionary<AnyHashable, Any>!
        
        if (loader == "yes") {
            ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        }
        
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            print(person)
            
            // print(str_set_date_for_server)
            let x : Int = person["userId"] as! Int
            let myString = String(x)
            
            if let token_id_is = UserDefaults.standard.string(forKey: str_save_last_api_token) {
                
                let headers: HTTPHeaders = [
                    "token":String(token_id_is),
                ]
                 
                if (self.str_set_date_for_server == nil) {
                    parameters = [
                        "action"        : "wateradd",
                        "userId"        : String(myString),
                        "date"          : "\(Date.getCurrentDateCustom())",
                        "total_glass"   : String(self.str_updated_value),
                    ]
                } else {
                    parameters = [
                        "action"        : "wateradd",
                        "userId"        : String(myString),
                        "date"          : String(self.str_set_date_for_server),
                        "total_glass"   : String(self.str_updated_value),
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
                                ERProgressHud.sharedInstance.hide()
                                
                                self.water_intake_check_WB(loader: true)
                                
                                self.view.makeToast(JSON["msg"] as? String)
                                
                            }
                            else {
                                self.refresh_token_WB2()
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
                        
                        self.update_one_more_glass_WB(loader: "no")
                        
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
        let cell = self.tble_view.cellForRow(at: indexPath) as! water_intake_table_cell
        
        RPicker.selectDate(title: "Select date", cancelText: "Cancel", datePickerMode: .date,maxDate: Date.now, didSelectDate: { (selectedDate) in
            // cell.btn_date.setTitle(selectedDate.dateString("yyyy-MM-dd"), for: .normal)
            cell.lbl_date.text = selectedDate.dateString("MM-dd-yyyy")
            // self.meal_track_record_WB(loader: "yes")
            self.str_set_date_for_server = selectedDate.dateString("yyyy-MM-dd")
            self.str_not_today_date = selectedDate.dateString("MM/dd/yyyy")
            
            self.water_intake_check_WB(loader: true)
        })
        
        
    }
    
}

//MARK:- TABLE VIEW -
extension water_intake: UITableViewDataSource, UITableViewDelegate, ChartViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:water_intake_table_cell = tableView.dequeueReusableCell(withIdentifier: "water_intake_table_cell") as! water_intake_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        if (self.str_set_date_for_server == nil){
            cell.lbl_date.text = Date.getCurrentDate()
        } else {
            cell.lbl_date.text = String(self.str_not_today_date)
        }
        
        
        cell.lbl_water_glass_count.text = String(self.str_done_water_count)
        cell.lbl_water_glass_out_of.text = "of \(self.str_total_water!) Glasses"
        
        cell.btn_reminder.addTarget(self, action: #selector(reminder_click_method), for: .touchUpInside)
        cell.btn_water_count_edit.addTarget(self, action: #selector(water_count_edit_click_method), for: .touchUpInside)
        
        cell.btn_add.addTarget(self, action: #selector(add_click_method), for: .touchUpInside)
        cell.btn_minus.addTarget(self, action: #selector(minus_click_method), for: .touchUpInside)
        
        cell.btn_date.addTarget(self, action: #selector(date_click_method), for: .touchUpInside)
        
        let swiftArray = self.arr_water_list.compactMap { $0 as? [String: Any] }
        cell.chartView.delegate = self
        
        // Rest of your chart setup code...
        
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.minimumFractionDigits = 0
        leftAxisFormatter.maximumFractionDigits = 1
        leftAxisFormatter.negativeSuffix = " H"
        leftAxisFormatter.positiveSuffix = " H"
        
        let leftAxis = cell.chartView.leftAxis
        leftAxis.labelFont = .systemFont(ofSize: 10)
        leftAxis.labelCount = 6
        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
        leftAxis.labelPosition = .outsideChart
        leftAxis.spaceTop = 0.15
        leftAxis.axisMinimum = 0
        
        let rightAxis = cell.chartView.rightAxis
        rightAxis.enabled = true
        rightAxis.labelFont = .systemFont(ofSize: 10)
        rightAxis.labelCount = 6
        rightAxis.valueFormatter = leftAxis.valueFormatter
        rightAxis.spaceTop = 0.15
        rightAxis.axisMinimum = 0
        
        let xAxis = cell.chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 10) // Adjust font size as needed
        xAxis.labelRotationAngle = -45 // Rotate labels for better readability
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        let dates = swiftArray.compactMap { dateFormatter.date(from: $0["date"] as! String) }
        
        xAxis.valueFormatter = IndexAxisValueFormatter(values: dates.map { dateFormatter.string(from: $0) })
        xAxis.labelCount = dates.count // Ensure label count matches number of dates
        
        xAxis.granularityEnabled = true
        xAxis.granularity = 1 // Set to 1 to show all labels
        
        cell.chartView.legend.enabled = false
        
        var add_time = 0.0
        
        let yVals2 = (0..<swiftArray.count).map { (i) -> BarChartDataEntry in
            let item = swiftArray[i]
            if ("\(item["total_glass"]!)" == "") {
                add_time += Double(0)
            } else {
                add_time += Double("\(item["total_glass"]!)")!
            }
            
            let myDouble = Double("\(item["total_glass"]!)")
            return BarChartDataEntry(x: Double(i), y: myDouble!)
        }
        
        // let doubleStr = String(format: "%.2f", (add_time / Double(swiftArray.count))) // "3.14"
        // cell.lbl_on_avg.text = String(doubleStr) + "h on average"
        
        var set1: BarChartDataSet! = nil
        if let set = cell.chartView.data?.first as? BarChartDataSet {
            set1 = set
            set1?.replaceEntries(yVals2)
            cell.chartView.data?.notifyDataChanged()
            cell.chartView.notifyDataSetChanged()
        } else {
            set1 = BarChartDataSet(entries: yVals2, label: "Data Set")
            set1.colors = ChartColorTemplates.vordiplom()
            set1.drawValuesEnabled = true
            
            let data = BarChartData(dataSet: set1)
            cell.chartView.data = data
            cell.chartView.fitBars = true
        }
        
        cell.chartView.setNeedsDisplay()
        cell.chartView.fitScreen()
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 660
    }
    
}
