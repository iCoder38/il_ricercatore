//
//  steps.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 07/03/24.
//

import UIKit
import DGCharts
import Alamofire

class steps: UIViewController {
    
    var arrSteps:NSMutableArray! = []
    var arr_7_days:NSMutableArray! = []
    var str_do_not_change:String! = "0"
    
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
            lbl_navigation_title.text = navigation_title_steps_details
        }
    }
    
    @IBOutlet weak var tble_view:UITableView! {
        didSet {
            
            tble_view.clipsToBounds = true
        }
    }
    
    var str_step_status:String! = "0"
    @IBOutlet weak var btn_week:UIButton! {
        didSet {
            btn_week.setTitle("Week", for: .normal)
            btn_week.backgroundColor = .systemOrange
        }
    }
    
    @IBOutlet weak var btn_custom:UIButton!  {
        didSet {
            btn_custom.setTitle("Custom", for: .normal)
            btn_custom.backgroundColor = .systemOrange
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
        self.arrSteps.removeAllObjects()
        self.submit_date_WB()
    }
    
    @objc func caluclate_last_7_days() {
        
        for indexx in 1...7 {
            let sevenDaysAgo = Calendar.current.date(byAdding: .day, value: -indexx, to: Date())
            
            let separate_time = "\(sevenDaysAgo!)".components(separatedBy: " ")
            let before_space_value = separate_time[0]
            
            self.arr_7_days.add(before_space_value as Any)
        }
        print(self.arr_7_days.lastObject as Any)
    }
    
    @objc func add_click_method() {
        light_vibration()
        
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "add_steps_time_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    @objc func week_click_method() {
        self.str_step_status = "0"
        
        self.tble_view.reloadData()
    }
    
    @objc func custom_click_method() {
        self.str_step_status = "1"
        
        self.tble_view.reloadData()
    }
    
    @objc func submit_date_WB() {
         
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        var parameters:Dictionary<AnyHashable, Any>!
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            
            if let token_id_is = UserDefaults.standard.string(forKey: str_save_last_api_token) {
                
                let headers: HTTPHeaders = [
                    "token":String(token_id_is),
                ]
                
                let x : Int = person["userId"] as! Int
                let myString = String(x)
                 
                if (self.str_step_status == "0") {
                    parameters = [
                        "action"        : "stepslist",
                        "userId"        : String(myString),
                        "startDate"     : "\(self.arr_7_days.lastObject!)",
                        "enddate"       : String(Date.getCurrentDateCustom()),
                    ]
                } else {
                    self.str_do_not_change = "1"
                    let indexPath = IndexPath.init(row: 0, section: 0)
                    let cell = self.tble_view.cellForRow(at: indexPath) as! steps_table_cell
                    parameters = [
                        "action"        : "stepslist",
                        "userId"        : String(myString),
                        "startDate"     : String((cell.btn_date_one.titleLabel?.text)!),
                        "enddate"       : String((cell.btn_date_two.titleLabel?.text)!),
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
                                
                                self.arrSteps.removeAllObjects()
                                
                                var ar : NSArray!
                                ar = (JSON["data"] as! Array<Any>) as NSArray
                                self.arrSteps.addObjects(from: ar as! [Any])
                                
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
                        
                        
                            self.submit_date_WB()
                       
                        
                        
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
        let cell = self.tble_view.cellForRow(at: indexPath) as! steps_table_cell
        
        let selectedDate = Date().dateByAddingDays(-6)
        
        RPicker.selectDate(title: "Select date", cancelText: "Cancel", datePickerMode: .date, minDate:selectedDate, maxDate: Date.now, didSelectDate: { (selectedDate) in
            
            cell.btn_date_one.setTitle(selectedDate.dateString(date_fomatter_yyyy_MM_dd), for: .normal)
            
        })
    }
    @objc func date_click_end() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! steps_table_cell
        
        let selectedDate = Date().dateByAddingDays(-6)
        
        RPicker.selectDate(title: "Select date", cancelText: "Cancel", datePickerMode: .date, minDate:selectedDate, maxDate: Date.now, didSelectDate: { (selectedDate) in
            
            cell.btn_date_two.setTitle(selectedDate.dateString(date_fomatter_yyyy_MM_dd), for: .normal)
            
        })
    }
    
}

//MARK:- TABLE VIEW -
extension steps: UITableViewDataSource , UITableViewDelegate, ChartViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (self.str_step_status == "0") {
            
            let cell:steps_table_cell = tableView.dequeueReusableCell(withIdentifier: "one_steps_table_cell") as! steps_table_cell
            
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
            
            /*let yVals = (0..<6).map { (i) -> BarChartDataEntry in
                let mult2 = 10.0
                let val2 = Double(arc4random_uniform(UInt32(mult2))) + mult2/2
                return BarChartDataEntry(x: Double(i), y: 10)
            }*/
            var add_time = 0.0
            
            let yVals2 = (0..<self.arrSteps.count).map { (i) -> BarChartDataEntry in
                let item = self.arrSteps[i] as? [String:Any]
                
                /*let str_start_time:String! = (item!["sleepTime"] as! String)
                let str_end_time:String! = (item!["wakeupTime"] as! String)
                
                let dateDiff = time_difference(start_time: String(str_start_time), end_time: String(str_end_time))
                print(dateDiff as Any)
                
                
                 let myDouble = Double(dateDiff)
                */
                
                
                // header date
                cell.lbl_header_date.text = get_number_convert_into_months(date_one: "\(self.arr_7_days.lastObject!)")+" - "+get_number_convert_into_months(date_one: String(Date.getCurrentDateCustom()))
                
                add_time += Double("\(item!["totalSteps"]!)")!
                let myDouble = Double("\(item!["totalSteps"]!)")
                return BarChartDataEntry(x: Double(i), y: myDouble!, icon: UIImage(named: "logo1"))
            }
            
            let doubleStr = String(format: "%.2f", (add_time/Double(self.arrSteps.count))) // "3.14"
            cell.lbl_on_avg.text = String(doubleStr)+"h on average"
            
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
            
            return cell
            
        } else {
            
            let cell:steps_table_cell = tableView.dequeueReusableCell(withIdentifier: "two_steps_table_cell") as! steps_table_cell
            
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
            
            
            
            cell.btn_submit.addTarget(self, action: #selector(submit_date_WB), for: .touchUpInside)
            
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
            let yVals = (0..<self.arrSteps.count).map { [self] (i) -> BarChartDataEntry in
                
                let item = self.arrSteps[i] as? [String:Any]
                
                /*let str_start_time:String! = (item!["sleepTime"] as! String)
                let str_end_time:String! = (item!["wakeupTime"] as! String)
                
                let dateDiff = time_difference(start_time: String(str_start_time), end_time: String(str_end_time))
                print(dateDiff as Any)
                
                add_time += Double(dateDiff)!
                
                let myDouble = Double(dateDiff)*/
                
                add_time += Double("\(item!["totalSteps"]!)")!
                let myDouble = Double("\(item!["totalSteps"]!)")
                return BarChartDataEntry(x: Double(i), y: myDouble!, icon: UIImage(named: "logo1"))
                
            }
            
            // print(add_time as Any)
            // print(add_time/Double(self.arrSleep.count) as Any)
            let doubleStr = String(format: "%.2f", (add_time/Double(self.arrSteps.count))) // "3.14"
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
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (self.str_step_status == "0") {
            return 300
        } else {
            return 240
        }
    }

}
