//
//  sleep.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 07/03/24.
//

import UIKit
import DGCharts
import Alamofire

class sleep: UIViewController {

    var arrSleep:NSMutableArray! = []
    
    var arr_7_days:NSMutableArray! = []
    var str_do_not_change:String! = "0"
    
    let startDatePicker = UIDatePicker()
    let endDatePicker = UIDatePicker()
    
    @IBOutlet weak var btn_back:UIButton! {
        didSet {
            btn_back.tintColor = .white
            btn_back.setImage(UIImage(systemName: "arrow.left"), for: .normal)
            btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        }
    }
    @IBOutlet weak var btn_add:UIButton!
    
    @IBOutlet weak var lbl_navigation_title:UILabel! {
        didSet {
            lbl_navigation_title.text = navigation_title_sleep_monitor
        }
    }
    
    @IBOutlet weak var tble_view:UITableView! {
        didSet {
            
            // tble_view.layer.cornerRadius = 22
            tble_view.clipsToBounds = true
        }
    }
    
    var str_instake_status:String! = "0"
    @IBOutlet weak var btn_week:UIButton! {
        didSet {
            btn_week.setTitle("Week", for: .normal)
            btn_week.backgroundColor = .systemOrange
            btn_week.addBottomBorder(color: .black)
        }
    }
    
    @IBOutlet weak var btn_custom:UIButton!  {
        didSet {
            btn_custom.setTitle("Custom", for: .normal)
            btn_custom.backgroundColor = .systemOrange
            btn_custom.addBottomBorder(color: .systemOrange)
        }
    }
    
    func findDateDiff(time1Str: String, time2Str: String) -> String {
        let timeformatter = DateFormatter()
        timeformatter.dateFormat = "hh:mm a"

        guard let time1 = timeformatter.date(from: time1Str),
            let time2 = timeformatter.date(from: time2Str) else { return "" }

        //You can directly use from here if you have two dates

        let interval = time2.timeIntervalSince(time1)
        let hour = interval / 3600;
        let minute = interval.truncatingRemainder(dividingBy: 3600) / 60
        _ = Int(interval)
        // return "\(intervalInt < 0 ? "-" : "+") \(Int(hour)).\(Int(minute))"
        return "\(Int(hour)).\(Int(minute))"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tble_view.separatorColor = .white
        
        self.btn_week.addTarget(self, action: #selector(week_click_method), for: .touchUpInside)
        self.btn_custom.addTarget(self, action: #selector(custom_click_method), for: .touchUpInside)
        self.btn_add.addTarget(self, action: #selector(add_click_method), for: .touchUpInside)
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.arrSleep.removeAllObjects()
        self.submit_date_WB(status: "yes")
    }
    
    @objc func add_click_method() {
        self.light_vibration()
        
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "add_sleep_time_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    @objc func week_click_method() {
        self.str_instake_status = "0"
        
        btn_week.addBottomBorder(color: .black)
        btn_custom.addBottomBorder(color: .systemOrange)
        self.submit_date_WB(status: "yes")
    }
    
    @objc func custom_click_method() {
        self.str_instake_status = "1"
        
        self.showDateSelectionPopup()
    }
    
    
    @objc func submit_date_WB(status:String) {
         
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
                 
                if (self.str_instake_status == "0") {
                    parameters = [
                        "action"        : "sleeplist",
                        "userId"        : String(myString),
                        "startDate"     : "\(self.arr_7_days.lastObject!)",
                        "enddate"       : String(Date.getCurrentDateCustom()),
                    ]
                } else {
                    self.str_do_not_change = "1"
                    let indexPath = IndexPath.init(row: 0, section: 0)
                    let cell = self.tble_view.cellForRow(at: indexPath) as! sleep_table_cell
                    parameters = [
                        "action"        : "sleeplist",
                        "userId"        : String(myString),
                        "startDate"     : String(self.str_start_date),
                        "enddate"       : String(self.str_end_date),
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
                                
                                // self.view.makeToast(JSON["msg"] as? String)
                                // self.success_with_back_show_alert(message: (JSON["msg"] as? String)!)
                                
                                self.arrSleep.removeAllObjects()
                                
                                var ar : NSArray!
                                ar = (JSON["data"] as! Array<Any>) as NSArray
                                self.arrSleep.addObjects(from: ar as! [Any])
                                
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
                        
                        self.submit_date_WB(status: "no")
                        
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
    
    @objc func date_click_start() {
        let indexPath = IndexPath.init(row: 1, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! sleep_table_cell
        
        let selectedDate = Date().dateByAddingDays(-6)
        
        RPicker.selectDate(title: "Select date", cancelText: "Cancel", datePickerMode: .date, minDate:selectedDate, maxDate: Date.now, didSelectDate: { (selectedDate) in
             
            cell.btn_date_one.setTitle(selectedDate.dateString(date_fomatter_yyyy_MM_dd), for: .normal)
            
        })
    }
    @objc func date_click_end() {
        let indexPath = IndexPath.init(row: 1, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! sleep_table_cell
        
        let selectedDate = Date().dateByAddingDays(-6)
        
        RPicker.selectDate(title: "Select date", cancelText: "Cancel", datePickerMode: .date, minDate:selectedDate, maxDate: Date.now, didSelectDate: { (selectedDate) in
            
            cell.btn_date_two.setTitle(selectedDate.dateString(date_fomatter_yyyy_MM_dd), for: .normal)
            
        })
    }
    
    @objc func delete_sleep_click_method(_ sender:UIButton) {
       
        print(sender.tag)
        let item = self.arrSleep[sender.tag] as? [String:Any]
        print(item as Any)
        
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "deleting...")
        var parameters:Dictionary<AnyHashable, Any>!
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            
            if let token_id_is = UserDefaults.standard.string(forKey: str_save_last_api_token) {
                
                let headers: HTTPHeaders = [
                    "token":String(token_id_is),
                ]
                
                let x : Int = person["userId"] as! Int
                let myString = String(x)
                
                
                parameters = [
                    "action"        : "sleepdelete",
                    "userId"        : String(myString),
                    "sleepId"     : "\(item!["sleepId"]!)",
                    
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
                                
                                self.submit_date_WB(status: "no")
                                
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
                        
                        self.submit_date_WB(status: "no")
                        
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
    
    
    
    @objc func submit_date_custom_WB(_ sender:UIButton) {
        let indexPath = IndexPath.init(row: 1, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! sleep_table_cell
        
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
                    "action"        : "sleeplist",
                    "userId"        : String(myString),
                    "startDate"     : String((cell.btn_date_one.titleLabel?.text!)!),
                    "enddate"       : String((cell.btn_date_two.titleLabel?.text!)!),
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
                                
                                self.arrSleep.removeAllObjects()
                                
                                var ar : NSArray!
                                ar = (JSON["data"] as! Array<Any>) as NSArray
                                self.arrSleep.addObjects(from: ar as! [Any])
                                
                                self.tble_view.delegate = self
                                self.tble_view.dataSource = self
                                self.tble_view.reloadData()
                            } else {
                                if (JSON["msg"] as? String == your_are_not_auth) {
                                    self.refresh_token_custom_WB()
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
                self.refresh_token_custom_WB()
            }
        }
    }
    @objc func refresh_token_custom_WB() {
        
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
                        
                        self.submit_date_WB(status: "no")
                        
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
    
    
    var startDate: Date?
    var endDate: Date?
    
    var str_start_date:String!
    var str_end_date:String!
    
    @objc func showDateSelectionPopup() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        // Date pickers
        
        startDatePicker.datePickerMode = .date
        startDatePicker.maximumDate = Date() // Maximum date is today
        // startDatePicker.minimumDate = Calendar.current.date(byAdding: .day, value: -40, to: Date()) // Minimum date is 6 days ago
        startDatePicker.addTarget(self, action: #selector(startDateChanged(_:)), for: .valueChanged)
        
        endDatePicker.datePickerMode = .date
        endDatePicker.maximumDate = Date() // Maximum date is today
        // endDatePicker.minimumDate = Calendar.current.date(byAdding: .day, value: -40, to: Date()) // Minimum date is 6 days ago
        endDatePicker.addTarget(self, action: #selector(endDateChanged(_:)), for: .valueChanged)
        
        // Stack view for date pickers
        let stackView = UIStackView(arrangedSubviews: [startDatePicker, endDatePicker])
        stackView.axis = .horizontal
        stackView.spacing = 8.0
        
        // Add stack view to alert controller
        alertController.view.addSubview(stackView)
        
        // Constraints for stack view
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let margin: CGFloat = 8.0
        
        let constraints = [
            stackView.topAnchor.constraint(equalTo: alertController.view.topAnchor, constant: margin),
            stackView.leadingAnchor.constraint(equalTo: alertController.view.leadingAnchor, constant: margin),
            stackView.trailingAnchor.constraint(equalTo: alertController.view.trailingAnchor, constant: -margin),
            stackView.heightAnchor.constraint(equalToConstant:80.0),
            
            alertController.view.heightAnchor.constraint(equalToConstant: 120.0)
        ]
        
        alertController.view.addConstraints(constraints)
        
        // Actions
        alertController.addAction(UIAlertAction(title: "Submit", style: .default, handler: { (_) in
            self.submitDates()
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // Present alert controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func startDateChanged(_ sender: UIDatePicker) {
        
        var startDate2 = sender.date
        let maxEndDate = Calendar.current.date(byAdding: .day, value: 7, to: startDate2)
        endDatePicker.maximumDate = maxEndDate
        // Optionally, update the minimum date of the endDatePicker to the selected start date
        endDatePicker.minimumDate = startDate2
        
        startDate = sender.date
    }
    
    @objc func endDateChanged(_ sender: UIDatePicker) {
        endDate = sender.date
    }
    
    func submitDates() {
        // Handle submission of startDate and endDate
        guard let startDate = startDate, let endDate = endDate else {
            print("Dates are not selected")
            return
        }
        
        // Format the dates before using them
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Adjust the format as needed
        
        let formattedStartDate = dateFormatter.string(from: startDate)
        let formattedEndDate = dateFormatter.string(from: endDate)
        
        // Print or use formatted dates as needed
        print("Selected Start Date: \(formattedStartDate)")
        print("Selected End Date: \(formattedEndDate)")
        
        self.str_start_date = "\(formattedStartDate)"
        self.str_end_date = "\(formattedEndDate)"
        
        btn_custom.addBottomBorder(color: .black)
        btn_week.addBottomBorder(color: .systemOrange)
        
        self.submit_date_WB(status: "yes")
        
    }
}

//MARK:- TABLE VIEW -
extension sleep: UITableViewDataSource , UITableViewDelegate, ChartViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrSleep.count+2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0) {
            let cell:sleep_table_cell = tableView.dequeueReusableCell(withIdentifier: "one_table_cell") as! sleep_table_cell
            
            cell.backgroundColor = .clear
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            
            if (self.str_instake_status == "0") {
                let currentDate = Date()
                
                let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -6, to: currentDate)!
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM dd"
                
                let formattedCurrentDate = dateFormatter.string(from: currentDate)
                let formattedSevenDaysAgo = dateFormatter.string(from: sevenDaysAgo)
                
                print("Current Date: \(formattedCurrentDate)")
                print("Seven Days Ago: \(formattedSevenDaysAgo)")
                cell.lbl_header_date.text = "\(formattedSevenDaysAgo) ~ \(formattedCurrentDate)"
                
            } else {
                
                let dateFormatter2 = DateFormatter()
                dateFormatter2.dateFormat = "yyyy-MM-dd"
                
                // Format dates to "MMM dd"
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM dd"
                
                let formattedStartDate = dateFormatter.string(from: startDate!)
                let formattedEndDate = dateFormatter.string(from: endDate!)
                
                print("Formatted Start Date: \(formattedStartDate)") // Example output: Formatted Start Date: Jul 10
                print("Formatted End Date: \(formattedEndDate)")
                
                cell.lbl_header_date.text = "\(formattedStartDate) ~ \(formattedEndDate)"
            }
            
            let swiftArray = self.arrSleep.compactMap { $0 as? [String: Any] }
            cell.chartView.delegate = self
            
            // Rest of your chart setup code...
            
            let leftAxisFormatter = NumberFormatter()
            leftAxisFormatter.minimumFractionDigits = 0
            leftAxisFormatter.maximumFractionDigits = 1
            leftAxisFormatter.negativeSuffix = " "
            leftAxisFormatter.positiveSuffix = " "
            
            let leftAxis = cell.chartView.leftAxis
            leftAxis.labelFont = .systemFont(ofSize: 10)
            leftAxis.labelCount = 6
            leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
            leftAxis.labelPosition = .outsideChart
            leftAxis.spaceTop = 0.15
            leftAxis.axisMinimum = 0
            leftAxis.drawLabelsEnabled = false // Disable labels on the left axis
            leftAxis.drawGridLinesEnabled = false // Disable grid lines on the left axis
            
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
            dateFormatter.dateFormat = "MM/dd/yyyy" // Adjust format to match your date strings
            
            let dates = swiftArray.compactMap { dateFormatter.date(from: $0["wakeup_date"] as! String) }
            
            xAxis.valueFormatter = IndexAxisValueFormatter(values: dates.map { dateFormatter.string(from: $0) })
            xAxis.labelCount = dates.count // Ensure label count matches number of dates
            
            // Adjust granularity to avoid overlapping
            xAxis.granularityEnabled = true
            xAxis.granularity = 1 // Set to 1 to show all labels
            
            cell.chartView.legend.enabled = false
            
            var add_time = 0.0
            
//            var set_bmp:String! = "0"
            
            var myDouble:Double!
            let yVals2 = (0..<swiftArray.count).map { (i) -> BarChartDataEntry in
                let item = swiftArray[i]
                print(item as Any)
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
                
                let sleepDateTimeString = "\(item["sleep_date"]!) \(item["sleepTime"]!)"
                let wakeupDateTimeString = "\(item["wakeup_date"]!) \(item["wakeupTime"]!)"
                
                if let sleepDateTime = dateFormatter.date(from: sleepDateTimeString),
                   let wakeupDateTime = dateFormatter.date(from: wakeupDateTimeString) {
                    
                    let totalSleepTime = wakeupDateTime.timeIntervalSince(sleepDateTime)
                    let hours = Int(totalSleepTime) / 3600
                    let minutes = (Int(totalSleepTime) % 3600) / 60
                    print("Total sleep time: \(hours) hours and \(minutes) minutes")
                    
                    add_time += Double("\(hours).\(minutes)")!
                    myDouble = Double("\(hours).\(minutes)")
                    
                    
                } else {
                    print("Could not parse sleep or wakeup date/time")
                }
                
                return BarChartDataEntry(x: Double(i), y: myDouble!, icon: UIImage(named: "logo1"))
                
                
                
                /*if ("\(item["totalSteps"]!)" == "") {
                 add_time += Double(0)
                 } else {
                 add_time += Double("\(item["totalSteps"]!)")!
                 }
                 
                 let myDouble = Double("\(item["totalSteps"]!)")
                 return BarChartDataEntry(x: Double(i), y: myDouble!, icon: UIImage(named: "logo1"))*/
            }
            
            let doubleStr = String(format: "%.2f", (add_time / Double(swiftArray.count))) // "3.14"
            cell.lbl_on_avg.text = String(doubleStr) + "h on average"
            
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
            
        } else if (indexPath.row == 1) {
            let cell:sleep_table_cell = tableView.dequeueReusableCell(withIdentifier: "two_table_cell") as! sleep_table_cell
            
            cell.backgroundColor = .clear
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            
            return cell
        } else {
            let cell:sleep_table_cell = tableView.dequeueReusableCell(withIdentifier: "three_table_cell") as! sleep_table_cell
            
            cell.backgroundColor = .clear
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
           
            let item = self.arrSleep[indexPath.row-2] as? [String:Any]
            
            cell.lbl_day_time.text = getDayOfWeek(item!["sleep_date"] as! String)
            
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
            
            let sleepDateTimeString = "\(item!["sleep_date"]!) \(item!["sleepTime"]!)"
            let wakeupDateTimeString = "\(item!["wakeup_date"]!) \(item!["wakeupTime"]!)"
            
            if let sleepDateTime = dateFormatter.date(from: sleepDateTimeString),
               let wakeupDateTime = dateFormatter.date(from: wakeupDateTimeString) {
                
                let totalSleepTime = wakeupDateTime.timeIntervalSince(sleepDateTime)
                let hours = Int(totalSleepTime) / 3600
                let minutes = (Int(totalSleepTime) % 3600) / 60
                print("Total sleep time: \(hours) hours and \(minutes) minutes")
                
                cell.lbl_value.text = "\(hours) hours and \(minutes) minutes"
            }
            
            cell.btn_delete.tag = indexPath.row-2
            cell.btn_delete.addTarget(self, action: #selector(delete_sleep_click_method), for: .touchUpInside)
            
            return cell
        }
        
        /*if (self.str_instake_status == "0") {
            if indexPath.row == 0 {
                let cell:sleep_table_cell = tableView.dequeueReusableCell(withIdentifier: "one_table_cell") as! sleep_table_cell
                
                cell.backgroundColor = .clear
                
                let backgroundView = UIView()
                backgroundView.backgroundColor = .clear
                cell.selectedBackgroundView = backgroundView
                
                cell.chartView.delegate = self
                
                cell.chartView.chartDescription.enabled = false
                cell.chartView.maxVisibleCount = 60
                cell.chartView.pinchZoomEnabled = false
                cell.chartView.drawBarShadowEnabled = false
                
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
                leftAxis.axisMinimum = 0 // FIXME: HUH?? this replaces startAtZero = YES
                
                let rightAxis = cell.chartView.rightAxis
                rightAxis.enabled = true
                rightAxis.labelFont = .systemFont(ofSize: 10)
                rightAxis.labelCount = 6
                rightAxis.valueFormatter = leftAxis.valueFormatter
                rightAxis.spaceTop = 0.15
                rightAxis.axisMinimum = 0
                
                let xAxis = cell.chartView.xAxis
                xAxis.labelPosition = .bottom
                        
                cell.chartView.legend.enabled = false
                
                var add_time = 0.0
                let yVals = (0..<self.arrSleep.count).map { [self] (i) -> BarChartDataEntry in
                    
                    let item = self.arrSleep[i] as? [String:Any]
                    
                    let str_start_time:String! = (item!["sleepTime"] as! String)
                    let str_end_time:String! = (item!["wakeupTime"] as! String)
                    
                    /*
                     cell.btn_date_one.setTitle("\(self.arr_7_days.lastObject!)", for: .normal)
                     cell.btn_date_two.setTitle(String(Date.getCurrentDateCustom()), for: .normal)
                     */
                    // header date
                    cell.lbl_header_date.text = get_number_convert_into_months(date_one: "\(self.arr_7_days.lastObject!)")+" - "+get_number_convert_into_months(date_one: String(Date.getCurrentDateCustom()))
                    
                    let dateDiff = time_difference(start_time: String(str_start_time), end_time: String(str_end_time))
                    print(dateDiff as Any)
                    
                    add_time += Double(dateDiff)!
                    
                    let myDouble = Double(dateDiff)
                    return BarChartDataEntry(x: Double(i), y: myDouble!, icon: UIImage(named: "logo1"))
                    
                }
                
                // print(add_time as Any)
                // print(add_time/Double(self.arrSleep.count) as Any)
                let doubleStr = String(format: "%.2f", (add_time/Double(self.arrSleep.count))) // "3.14"
                cell.lbl_on_avg.text = String(doubleStr)+"h on average"
                
                var set1: BarChartDataSet! = nil
                if let set = cell.chartView.data?.first as? BarChartDataSet {
                    set1 = set
                    set1?.replaceEntries(yVals)
                    cell.chartView.data?.notifyDataChanged()
                    cell.chartView.notifyDataSetChanged()
                    set1.drawValuesEnabled = true
                } else {
                    set1 = BarChartDataSet(entries: yVals, label: "Data Set")
                    set1.colors = ChartColorTemplates.vordiplom()
                    set1.drawValuesEnabled = true
                    
                    let data = BarChartData(dataSet: set1)
                    cell.chartView.data = data
                    cell.chartView.fitBars = true
                }
                
                cell.chartView.setNeedsDisplay()
                
                return cell
                
            } else if indexPath.row == 1 {
                let cell:sleep_table_cell = tableView.dequeueReusableCell(withIdentifier: "two_table_cell") as! sleep_table_cell
                
                cell.backgroundColor = .clear
                
                let backgroundView = UIView()
                backgroundView.backgroundColor = .clear
                cell.selectedBackgroundView = backgroundView
                
                return cell
            } else {
                let cell:sleep_table_cell = tableView.dequeueReusableCell(withIdentifier: "three_table_cell") as! sleep_table_cell
                
                cell.backgroundColor = .clear
                
                let backgroundView = UIView()
                backgroundView.backgroundColor = .clear
                cell.selectedBackgroundView = backgroundView
               
                let item = self.arrSleep[indexPath.row-2] as? [String:Any]
                
                cell.lbl_day_time.text = getDayOfWeek(item!["sleep_date"] as! String)+" "+get_number_convert_into_months_slash(date_one: (item!["sleep_date"] as! String))
                cell.lbl_value.text = "\(item!["wakeupTime"]!)"
                
                 cell.btn_delete.tag = indexPath.row-2
                 cell.btn_delete.addTarget(self, action: #selector(delete_sleep_click_method), for: .touchUpInside)
                
                let dateDiff = time_difference(start_time: "\(item!["sleepTime"]!)", end_time: "\(item!["wakeupTime"]!)")
                print(dateDiff as Any)
                cell.lbl_value.text = dateDiff + " Hours"
                
                return cell
            }
            
        } else {
            if indexPath.row == 0 {
                let cell:sleep_table_cell = tableView.dequeueReusableCell(withIdentifier: "one_table_cell") as! sleep_table_cell
                
                cell.backgroundColor = .clear
                
                let backgroundView = UIView()
                backgroundView.backgroundColor = .clear
                cell.selectedBackgroundView = backgroundView
                
                cell.chartView.delegate = self
                
                cell.chartView.chartDescription.enabled = false
                cell.chartView.maxVisibleCount = 60
                cell.chartView.pinchZoomEnabled = false
                cell.chartView.drawBarShadowEnabled = false
                
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
                leftAxis.axisMinimum = 0 // FIXME: HUH?? this replaces startAtZero = YES
                
                let rightAxis = cell.chartView.rightAxis
                rightAxis.enabled = true
                rightAxis.labelFont = .systemFont(ofSize: 10)
                rightAxis.labelCount = 6
                rightAxis.valueFormatter = leftAxis.valueFormatter
                rightAxis.spaceTop = 0.15
                rightAxis.axisMinimum = 0
                
                let xAxis = cell.chartView.xAxis
                xAxis.labelPosition = .bottom
                        
                cell.chartView.legend.enabled = false
                
                var add_time = 0.0
                let yVals = (0..<self.arrSleep.count).map { [self] (i) -> BarChartDataEntry in
                    
                    let item = self.arrSleep[i] as? [String:Any]
                    
                    let str_start_time:String! = (item!["sleepTime"] as! String)
                    let str_end_time:String! = (item!["wakeupTime"] as! String)
                    
                    /*
                     cell.btn_date_one.setTitle("\(self.arr_7_days.lastObject!)", for: .normal)
                     cell.btn_date_two.setTitle(String(Date.getCurrentDateCustom()), for: .normal)
                     */
                    // header date
                    cell.lbl_header_date.text = get_number_convert_into_months(date_one: "\(self.arr_7_days.lastObject!)")+" - "+get_number_convert_into_months(date_one: String(Date.getCurrentDateCustom()))
                    
                    let dateDiff = time_difference(start_time: String(str_start_time), end_time: String(str_end_time))
                    print(dateDiff as Any)
                    
                    add_time += Double(dateDiff)!
                    
                    let myDouble = Double(dateDiff)
                    return BarChartDataEntry(x: Double(i), y: myDouble!, icon: UIImage(named: "logo1"))
                    
                }
                
                // print(add_time as Any)
                // print(add_time/Double(self.arrSleep.count) as Any)
                let doubleStr = String(format: "%.2f", (add_time/Double(self.arrSleep.count))) // "3.14"
                cell.lbl_on_avg.text = String(doubleStr)+"h on average"
                
                var set1: BarChartDataSet! = nil
                if let set = cell.chartView.data?.first as? BarChartDataSet {
                    set1 = set
                    set1?.replaceEntries(yVals)
                    cell.chartView.data?.notifyDataChanged()
                    cell.chartView.notifyDataSetChanged()
                    set1.drawValuesEnabled = true
                } else {
                    set1 = BarChartDataSet(entries: yVals, label: "Data Set")
                    set1.colors = ChartColorTemplates.vordiplom()
                    set1.drawValuesEnabled = true
                    
                    let data = BarChartData(dataSet: set1)
                    cell.chartView.data = data
                    cell.chartView.fitBars = true
                }
                
                cell.chartView.setNeedsDisplay()
                
                return cell
                
            } else if indexPath.row == 1 {
                /*let cell:sleep_table_cell = tableView.dequeueReusableCell(withIdentifier: "two_table_cell") as! sleep_table_cell
                
                cell.backgroundColor = .clear
                
                let backgroundView = UIView()
                backgroundView.backgroundColor = .clear
                cell.selectedBackgroundView = backgroundView
                
                return cell*/
                let cell:sleep_table_cell = tableView.dequeueReusableCell(withIdentifier: "two_table_cell") as! sleep_table_cell
                
                cell.backgroundColor = .clear
                
                let backgroundView = UIView()
                backgroundView.backgroundColor = .clear
                cell.selectedBackgroundView = backgroundView
                
                if (self.str_do_not_change == "0") {
                    cell.btn_date_one.setTitle("\(self.arr_7_days.lastObject!)", for: .normal)
                    cell.btn_date_two.setTitle(String(Date.getCurrentDateCustom()), for: .normal)
                    
                    // cell.lbl_dates_two.text = "\(self.arr_7_days.lastObject!) - \(Date.getCurrentDateCustom())"
                    
                    // header date
                    cell.lbl_dates_two.text = get_number_convert_into_months(date_one: "\(self.arr_7_days.lastObject!)")+" - "+get_number_convert_into_months(date_one: String(Date.getCurrentDateCustom()))
                    
                } else {
                    // cell.lbl_dates_two.text = (cell.btn_date_one.titleLabel?.text)!+" - "+(cell.btn_date_two.titleLabel?.text)!
                    // header date
                    cell.lbl_dates_two.text = get_number_convert_into_months(date_one: (cell.btn_date_one.titleLabel?.text)!)+" - "+get_number_convert_into_months(date_one: (cell.btn_date_two.titleLabel?.text)!)
                }
                
                cell.btn_date_one.addTarget(self, action: #selector(date_click_start), for: .touchUpInside)
                cell.btn_date_two.addTarget(self, action: #selector(date_click_end), for: .touchUpInside)
                
                
                cell.btn_submit.tag = 1
                cell.btn_submit.addTarget(self, action: #selector(submit_date_custom_WB), for: .touchUpInside)
                
                cell.chartView_two.delegate = self
                
                cell.chartView_two.chartDescription.enabled = false
                cell.chartView_two.maxVisibleCount = 60
                cell.chartView_two.pinchZoomEnabled = false
                cell.chartView_two.drawBarShadowEnabled = false
                
                let leftAxisFormatter = NumberFormatter()
                leftAxisFormatter.minimumFractionDigits = 0
                leftAxisFormatter.maximumFractionDigits = 1
                leftAxisFormatter.negativeSuffix = " H"
                leftAxisFormatter.positiveSuffix = " H"
                
                let leftAxis = cell.chartView_two.leftAxis
                leftAxis.labelFont = .systemFont(ofSize: 10)
                leftAxis.labelCount = 6
                leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
                leftAxis.labelPosition = .outsideChart
                leftAxis.spaceTop = 0.15
                leftAxis.axisMinimum = 0 // FIXME: HUH?? this replaces startAtZero = YES
                
                let rightAxis = cell.chartView_two.rightAxis
                rightAxis.enabled = true
                rightAxis.labelFont = .systemFont(ofSize: 10)
                rightAxis.labelCount = 6
                rightAxis.valueFormatter = leftAxis.valueFormatter
                rightAxis.spaceTop = 0.15
                rightAxis.axisMinimum = 0
                
                let xAxis = cell.chartView_two.xAxis
                xAxis.labelPosition = .bottom
                        
                cell.chartView_two.legend.enabled = false
                
                var add_time = 0.0
                let yVals = (0..<self.arrSleep.count).map { [self] (i) -> BarChartDataEntry in
                    
                    let item = self.arrSleep[i] as? [String:Any]
                    
                    let str_start_time:String! = (item!["sleepTime"] as! String)
                    let str_end_time:String! = (item!["wakeupTime"] as! String)
                    
                    let dateDiff = time_difference(start_time: String(str_start_time), end_time: String(str_end_time))
                    print(dateDiff as Any)
                    
                    add_time += Double(dateDiff)!
                    
                    let myDouble = Double(dateDiff)
                    return BarChartDataEntry(x: Double(i), y: myDouble!, icon: UIImage(named: "logo1"))
                    
                }
                
                // print(add_time as Any)
                // print(add_time/Double(self.arrSleep.count) as Any)
                let doubleStr = String(format: "%.2f", (add_time/Double(self.arrSleep.count))) // "3.14"
                cell.lbl_on_avg_two.text = String(doubleStr)+"h on average"
                 
                var set1: BarChartDataSet! = nil
                if let set = cell.chartView_two.data?.first as? BarChartDataSet {
                    set1 = set
                    set1?.replaceEntries(yVals)
                    cell.chartView_two.data?.notifyDataChanged()
                    cell.chartView_two.notifyDataSetChanged()
                    set1.drawValuesEnabled = true
                } else {
                    set1 = BarChartDataSet(entries: yVals, label: "Data Set")
                    set1.colors = ChartColorTemplates.vordiplom()
                    set1.drawValuesEnabled = true
                    
                    let data = BarChartData(dataSet: set1)
                    cell.chartView_two.data = data
                    cell.chartView_two.fitBars = true
                }
                
                cell.chartView_two.setNeedsDisplay()
                
                return cell
                
            } else {
                let cell:sleep_table_cell = tableView.dequeueReusableCell(withIdentifier: "three_table_cell") as! sleep_table_cell
                
                cell.backgroundColor = .clear
                
                let backgroundView = UIView()
                backgroundView.backgroundColor = .clear
                cell.selectedBackgroundView = backgroundView
               
                let item = self.arrSleep[indexPath.row-2] as? [String:Any]
                
                cell.lbl_day_time.text = getDayOfWeek(item!["sleep_date"] as! String)
                
                
                let dateDiff = time_difference(start_time: "\(item!["sleepTime"]!)", end_time: "\(item!["wakeupTime"]!)")
                print(dateDiff as Any)
                cell.lbl_value.text = dateDiff + " Hours"
                return cell
            }
            
        }*/
         
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if (self.str_instake_status == "0") {
            
        }
        // self.arrSleep.count+2
        // delete_sleep_click_method
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 350
        } else if indexPath.row == 1 {
            return 0
        } else {
            return 70
        }
    }

}
