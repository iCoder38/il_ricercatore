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
            lbl_navigation_title.text = navigation_title_water_intake_en
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
        }
    }
    
    @IBOutlet weak var btn_custom:UIButton!  {
        didSet {
            btn_custom.setTitle("Custom", for: .normal)
            btn_custom.backgroundColor = .systemOrange
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
        
        for indexx in 1...7 {
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
        self.submit_date_WB()
    }
    
    @objc func add_click_method() {
        self.light_vibration()
        
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "add_sleep_time_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    @objc func week_click_method() {
        self.str_instake_status = "0"
        
        self.tble_view.reloadData()
    }
    
    @objc func custom_click_method() {
        self.str_instake_status = "1"
        
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
                 
                parameters = [
                    "action"        : "sleeplist",
                    "userId"        : String(myString),
                    "startDate"     : "\(self.arr_7_days.lastObject!)",
                    "enddate"       : String(Date.getCurrentDateCustom()),
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
}

//MARK:- TABLE VIEW -
extension sleep: UITableViewDataSource , UITableViewDelegate, ChartViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (self.str_instake_status == "0") {
            
            let cell:sleep_table_cell = tableView.dequeueReusableCell(withIdentifier: "one_table_cell") as! sleep_table_cell
            
            cell.backgroundColor = .clear
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            
            cell.chartView.delegate = self
            
            cell.chartView.drawBarShadowEnabled = false
            cell.chartView.drawValueAboveBarEnabled = false
            
            cell.chartView.maxVisibleCount = 60
            
            let xAxis = cell.chartView.xAxis
            xAxis.labelPosition = .bottom
            xAxis.labelFont = .systemFont(ofSize: 10)
            xAxis.granularity = 1
            xAxis.labelCount = 7
            xAxis.valueFormatter = DayAxisValueFormatter(chart: cell.chartView)
            
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
            
            let l = cell.chartView.legend
            l.horizontalAlignment = .left
            l.verticalAlignment = .bottom
            l.orientation = .horizontal
            l.drawInside = false
            l.form = .circle
            l.formSize = 9
            l.font = UIFont(name: "HelveticaNeue-Light", size: 11)!
            l.xEntrySpace = 6

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
            cell.lbl_on_avg.text = String(doubleStr)+"h on average"
            
            var set1: BarChartDataSet! = nil
            if let set = cell.chartView.data?.first as? BarChartDataSet {
                set1 = set
                set1.replaceEntries(yVals)
                cell.chartView.data?.notifyDataChanged()
                cell.chartView.notifyDataSetChanged()
            } else {
                set1 = BarChartDataSet(entries: yVals, label: "The year 2024")
                set1.colors = ChartColorTemplates.material()
                //set1.colors = ChartColorTemplates.joyful()
                set1.drawValuesEnabled = true
                
                let data = BarChartData(dataSet: set1)
                data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 10)!)
                data.barWidth = 0.9
                cell.chartView.data = data
            }
            
            return cell
            
        } else {
            
            let cell:sleep_table_cell = tableView.dequeueReusableCell(withIdentifier: "two_table_cell") as! sleep_table_cell
            
            cell.backgroundColor = .clear
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            
            return cell
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (self.str_instake_status == "0") {
            return 300
        } else {
            return 240
        }
    }

}
