//
//  heart.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 22/03/24.
//

import UIKit
import DGCharts
import Alamofire
import Charts

class heart: UIViewController, ChartViewDelegate {
    
    //    class CustomXAxisDateFormatter: NSObject, IAxisValueFormatter {
    //        var dates: [Date] = []
    //        private let dateFormatter: DateFormatter
    //
    //        init(dates: [Date]) {
    //            self.dates = dates
    //            self.dateFormatter = DateFormatter()
    //            self.dateFormatter.dateFormat = "MMM d" // Customize date format as needed
    //        }
    //
    //        func stringForValue(_ value: Double, axis: AxisBase?) -> String {
    //            let index = Int(value)
    //            if index >= 0 && index < dates.count {
    //                return dateFormatter.string(from: dates[index])
    //            }
    //            return ""
    //        }
    //    }
    
    var arr_heart:NSMutableArray! = []
    var arr_7_days:NSMutableArray! = []
    var str_do_not_change:String! = "0"
    
    var str_start_date:String!
    var str_end_date:String!
    
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
            lbl_navigation_title.text = navigation_title_heart_rate_en
        }
    }
    
    @IBOutlet weak var tble_view:UITableView! {
        didSet {
            
            tble_view.clipsToBounds = true
        }
    }
    
    var str_status:String! = "0"
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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tble_view.separatorColor = .white
        
        self.btn_week.addTarget(self, action: #selector(week_click_method), for: .touchUpInside)
        self.btn_custom.addTarget(self, action: #selector(custom_click_method), for: .touchUpInside)
        self.btn_add.addTarget(self, action: #selector(add_click_method), for: .touchUpInside)
        
        self.caluclate_last_7_days()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.arr_heart.removeAllObjects()
        self.submit_date_WB(status: "no")
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
    
    
    @objc func add_click_method() {
        light_vibration()
        
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "add_heart_rate_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    @objc func week_click_method() {
        self.str_status = "0"
        
        btn_week.addBottomBorder(color: .black)
        btn_custom.addBottomBorder(color: .systemOrange)
        self.submit_date_WB(status: "yes")
        
    }
    
    @objc func custom_click_method() {
        self.str_status = "1"
        
        self.showDateSelectionPopup()
        // self.tble_view.reloadData()
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
                
                if (self.str_status == "0") {
                    parameters = [
                        "action"        : "heartlist",
                        "userId"        : String(myString),
                        "startDate"     : "\(self.arr_7_days.lastObject!)",
                        "enddate"       : String(Date.getCurrentDateCustom()),
                    ]
                } else {
                    self.str_do_not_change = "1"
                    let indexPath = IndexPath.init(row: 0, section: 0)
                    let cell = self.tble_view.cellForRow(at: indexPath) as! heart_table_cell
                    parameters = [
                        "action"        : "heartlist",
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
                                
                                self.arr_heart.removeAllObjects()
                                
                                var ar : NSArray!
                                ar = (JSON["data"] as! Array<Any>) as NSArray
                                self.arr_heart.addObjects(from: ar as! [Any])
                                
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
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! heart_table_cell
        
        let selectedDate = Date().dateByAddingDays(-6)
        
        RPicker.selectDate(title: "Select date", cancelText: "Cancel", datePickerMode: .date, minDate:selectedDate, maxDate: Date.now, didSelectDate: { (selectedDate) in
            
            cell.btn_date_one.setTitle(selectedDate.dateString(date_fomatter_yyyy_MM_dd), for: .normal)
            
        })
    }
    @objc func date_click_end() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! heart_table_cell
        
        let selectedDate = Date().dateByAddingDays(-6)
        
        RPicker.selectDate(title: "Select date", cancelText: "Cancel", datePickerMode: .date, minDate:selectedDate, maxDate: Date.now, didSelectDate: { (selectedDate) in
            
            cell.btn_date_two.setTitle(selectedDate.dateString(date_fomatter_yyyy_MM_dd), for: .normal)
            
        })
    }
    
    @objc func delete_click_method(_ sender:UIButton) {
        
        print(sender.tag)
        let item = self.arr_heart[sender.tag] as? [String:Any]
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
                    "action"        : "heartdelete",
                    "userId"        : String(myString),
                    "heartId"     : "\(item!["heartId"]!)",
                    
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
                                
                                self.arr_heart.removeAllObjects()
                                
                                var ar : NSArray!
                                ar = (JSON["data"] as! Array<Any>) as NSArray
                                self.arr_heart.addObjects(from: ar as! [Any])
                                
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
    
    @objc func showDateSelectionPopup() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        // Date pickers
        
        startDatePicker.datePickerMode = .date
        startDatePicker.maximumDate = Date() // Maximum date is today
        startDatePicker.minimumDate = Calendar.current.date(byAdding: .day, value: -6, to: Date()) // Minimum date is 6 days ago
        startDatePicker.addTarget(self, action: #selector(startDateChanged(_:)), for: .valueChanged)
        
        endDatePicker.datePickerMode = .date
        endDatePicker.maximumDate = Date() // Maximum date is today
        endDatePicker.minimumDate = Calendar.current.date(byAdding: .day, value: -6, to: Date()) // Minimum date is 6 days ago
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
extension heart: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_heart.count+2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell:heart_table_cell = tableView.dequeueReusableCell(withIdentifier: "heart_one_table_cell") as! heart_table_cell
            
            cell.backgroundColor = .clear
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            
            if (self.str_status == "0") {
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
            
            let swiftArray = self.arr_heart.compactMap { $0 as? [String: Any] }
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
            
            let dates = swiftArray.compactMap { dateFormatter.date(from: $0["date"] as! String) }
            
            xAxis.valueFormatter = IndexAxisValueFormatter(values: dates.map { dateFormatter.string(from: $0) })
            xAxis.labelCount = dates.count // Ensure label count matches number of dates
            
            xAxis.granularityEnabled = true
            xAxis.granularity = 1 // Set to 1 to show all labels
            
            cell.chartView.legend.enabled = false
            
            var add_time = 0.0
            
            let yVals2 = (0..<swiftArray.count).map { (i) -> BarChartDataEntry in
                let item = swiftArray[i]
                if ("\(item["bmp"]!)" == "") {
                    add_time += Double(0)
                } else {
                    add_time += Double("\(item["bmp"]!)")!
                }
                
                let myDouble = Double("\(item["bmp"]!)")
                return BarChartDataEntry(x: Double(i), y: myDouble!, icon: UIImage(named: "logo1"))
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
            cell.chartView.fitScreen() // Ensure chart fits screen
            
            return cell
            
        } else if indexPath.row == 1 {
            let cell:heart_table_cell = tableView.dequeueReusableCell(withIdentifier: "heart_two_table_cell") as! heart_table_cell
            
            cell.backgroundColor = .clear
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            return cell
        } else {
            let cell:heart_table_cell = tableView.dequeueReusableCell(withIdentifier: "heart_three_table_cell") as! heart_table_cell
            
            cell.backgroundColor = .clear
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            
            let item = self.arr_heart[indexPath.row-2] as? [String:Any]
            
            // cell.lbl_header_date.text = "1"
            
            cell.lbl_day_time.text = getDayOfWeek(item!["date"] as! String)+" "+get_number_convert_into_months_slash(date_one: (item!["date"] as! String))
            cell.lbl_value.text = "\(item!["bmp"]!) BPM"
            
            cell.btn_delete.tag = indexPath.row-2
            cell.btn_delete.addTarget(self, action: #selector(delete_click_method), for: .touchUpInside)
            
            return cell
        }
        
        
        
        
        /*if (self.str_status == "0") {
         
         if indexPath.row == 0 {
         let cell:heart_table_cell = tableView.dequeueReusableCell(withIdentifier: "heart_one_table_cell") as! heart_table_cell
         
         cell.backgroundColor = .clear
         
         let backgroundView = UIView()
         backgroundView.backgroundColor = .clear
         cell.selectedBackgroundView = backgroundView
         
         //                let mutableArray = self.arr_heart.copy() as! NSArray
         //                let swiftArray = mutableArray as! [Any]
         //
         //                for element in swiftArray {
         //                    if let item = element as? [String: Any] {
         //                        // Process dictionary items if needed
         //                        let bmpValue = item["bmp"] as? Int ?? 0
         //                        print("BMP value: \(bmpValue)")
         //                    }
         //                }
         let swiftArray = self.arr_heart.compactMap { $0 as? [String: Any] }
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
         dateFormatter.dateFormat = "MM/dd/yyyy" // Adjust format to match your date strings
         
         let dates = swiftArray.compactMap { dateFormatter.date(from: $0["date"] as! String) }
         
         xAxis.valueFormatter = IndexAxisValueFormatter(values: dates.map { dateFormatter.string(from: $0) })
         xAxis.labelCount = dates.count // Ensure label count matches number of dates
         
         // Adjust granularity to avoid overlapping
         xAxis.granularityEnabled = true
         xAxis.granularity = 1 // Set to 1 to show all labels
         
         cell.chartView.legend.enabled = false
         
         var add_time = 0.0
         
         let yVals2 = (0..<swiftArray.count).map { (i) -> BarChartDataEntry in
         let item = swiftArray[i]
         add_time += Double("\(item["bmp"]!)")!
         let myDouble = Double("\(item["bmp"]!)")
         return BarChartDataEntry(x: Double(i), y: myDouble!, icon: UIImage(named: "logo1"))
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
         cell.chartView.fitScreen() // Ensure chart fits screen
         
         return cell
         
         } else if indexPath.row == 1 {
         let cell:heart_table_cell = tableView.dequeueReusableCell(withIdentifier: "heart_two_table_cell") as! heart_table_cell
         
         cell.backgroundColor = .clear
         
         let backgroundView = UIView()
         backgroundView.backgroundColor = .clear
         cell.selectedBackgroundView = backgroundView
         return cell
         } else {
         let cell:heart_table_cell = tableView.dequeueReusableCell(withIdentifier: "heart_three_table_cell") as! heart_table_cell
         
         cell.backgroundColor = .clear
         
         let backgroundView = UIView()
         backgroundView.backgroundColor = .clear
         cell.selectedBackgroundView = backgroundView
         
         let item = self.arr_heart[indexPath.row-2] as? [String:Any]
         
         // cell.lbl_header_date.text = "1"
         
         cell.lbl_day_time.text = getDayOfWeek(item!["date"] as! String)+" "+get_number_convert_into_months_slash(date_one: (item!["date"] as! String))
         cell.lbl_value.text = "\(item!["bmp"]!) BPM"
         
         cell.btn_delete.tag = indexPath.row-2
         cell.btn_delete.addTarget(self, action: #selector(delete_click_method), for: .touchUpInside)
         
         return cell
         }
         
         } else {
         
         if indexPath.row == 0 {
         let cell:heart_table_cell = tableView.dequeueReusableCell(withIdentifier: "heart_one_table_cell") as! heart_table_cell
         
         cell.backgroundColor = .clear
         
         let backgroundView = UIView()
         backgroundView.backgroundColor = .clear
         cell.selectedBackgroundView = backgroundView
         
         //                let mutableArray = self.arr_heart.copy() as! NSArray
         //                let swiftArray = mutableArray as! [Any]
         //
         //                for element in swiftArray {
         //                    if let item = element as? [String: Any] {
         //                        // Process dictionary items if needed
         //                        let bmpValue = item["bmp"] as? Int ?? 0
         //                        print("BMP value: \(bmpValue)")
         //                    }
         //                }
         let swiftArray = self.arr_heart.compactMap { $0 as? [String: Any] }
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
         dateFormatter.dateFormat = "MM/dd/yyyy" // Adjust format to match your date strings
         
         let dates = swiftArray.compactMap { dateFormatter.date(from: $0["date"] as! String) }
         
         xAxis.valueFormatter = IndexAxisValueFormatter(values: dates.map { dateFormatter.string(from: $0) })
         xAxis.labelCount = dates.count // Ensure label count matches number of dates
         
         // Adjust granularity to avoid overlapping
         xAxis.granularityEnabled = true
         xAxis.granularity = 1 // Set to 1 to show all labels
         
         cell.chartView.legend.enabled = false
         
         var add_time = 0.0
         
         let yVals2 = (0..<swiftArray.count).map { (i) -> BarChartDataEntry in
         let item = swiftArray[i]
         add_time += Double("\(item["bmp"]!)")!
         let myDouble = Double("\(item["bmp"]!)")
         return BarChartDataEntry(x: Double(i), y: myDouble!, icon: UIImage(named: "logo1"))
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
         cell.chartView.fitScreen() // Ensure chart fits screen
         
         return cell
         
         } else if indexPath.row == 1 {
         let cell:heart_table_cell = tableView.dequeueReusableCell(withIdentifier: "heart_two_table_cell") as! heart_table_cell
         
         cell.backgroundColor = .clear
         
         let backgroundView = UIView()
         backgroundView.backgroundColor = .clear
         cell.selectedBackgroundView = backgroundView
         return cell
         } else {
         let cell:heart_table_cell = tableView.dequeueReusableCell(withIdentifier: "heart_three_table_cell") as! heart_table_cell
         
         cell.backgroundColor = .clear
         
         let backgroundView = UIView()
         backgroundView.backgroundColor = .clear
         cell.selectedBackgroundView = backgroundView
         
         let item = self.arr_heart[indexPath.row-2] as? [String:Any]
         
         // cell.lbl_header_date.text = "1"
         
         cell.lbl_day_time.text = getDayOfWeek(item!["date"] as! String)+" "+get_number_convert_into_months_slash(date_one: (item!["date"] as! String))
         cell.lbl_value.text = "\(item!["bmp"]!) BPM"
         
         cell.btn_delete.tag = indexPath.row-2
         cell.btn_delete.addTarget(self, action: #selector(delete_click_method), for: .touchUpInside)
         
         return cell
         }
         
         }*/
        
        
    }
    
    func dateFromString(_ dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: dateString)!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (self.str_status == "0") {
            if indexPath.row == 0 {
                return 370
            } else if indexPath.row == 1 {
                return 0
            } else {
                return 70
            }
        } else {
            if indexPath.row == 0 {
                return 370
            } else if indexPath.row == 1 {
                return 0
            } else {
                return 70
            }
        }
    }
    
}



