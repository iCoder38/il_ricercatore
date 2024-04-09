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
            tble_view.delegate = self
            tble_view.dataSource = self
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tble_view.separatorColor = .white
        
        self.btn_week.addTarget(self, action: #selector(week_click_method), for: .touchUpInside)
        self.btn_custom.addTarget(self, action: #selector(custom_click_method), for: .touchUpInside)
        self.btn_add.addTarget(self, action: #selector(add_click_method), for: .touchUpInside)
        
        self.submit_date_WB()
        
    }
    
    @objc func add_click_method() {
        light_vibration()
        
        //updateChartData
        updateChartData()
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "add_sleep_time_id")
        //self.navigationController?.pushViewController(push, animated: true)
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
                    "userId"        : "32",//String(myString),
                    "startDate"          : String("2024-04-03"),
                    "enddate"          : String("2024-04-09"),
                    
                     
                    
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
                                self.success_with_back_show_alert(message: (JSON["msg"] as? String)!)
                                
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
            l.xEntrySpace = 4
    //        chartView.legend = l

            /*let marker = XYMarkerView(color: UIColor(white: 180/250, alpha: 1),
                                      font: .systemFont(ofSize: 12),
                                      textColor: .white,
                                      insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8),
                                      xAxisValueFormatter: cell.chartView.xAxis.valueFormatter!)
            marker.chartView = cell.chartView
            marker.minimumSize = CGSize(width: 80, height: 40)
            cell.chartView.marker = marker
            
            cell.sliderX.value = 12
            cell.sliderY.value = 50
            slidersValueChanged(nil)*/
            
            
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
    
     func updateChartData() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! sleep_table_cell
        
         self.setDataCount(Int(10) + 1, range: UInt32(10))
    }
    
    func setDataCount(_ count: Int, range: UInt32) {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! sleep_table_cell
        
        let start = 1
        
        let yVals = (start..<start+count+1).map { (i) -> BarChartDataEntry in
            let mult = range + 1
            let val = Double(arc4random_uniform(mult))
            print(val as Any)
//            if arc4random_uniform(100) < 25 {
//                return BarChartDataEntry(x: Double(i), y: val, icon: UIImage(named: "icon"))
//            } else {
//                return BarChartDataEntry(x: Double(i), y: val)
//            }
            return BarChartDataEntry(x: Double(i), y: val, icon: UIImage(named: "icon"))
        }
        
        
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
        
//        chartView.setNeedsDisplay()
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
