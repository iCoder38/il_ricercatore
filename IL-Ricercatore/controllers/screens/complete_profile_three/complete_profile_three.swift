//
//  complete_profile_three.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 16/12/23.
//

import UIKit
import Alamofire

class complete_profile_three: UIViewController, UITextFieldDelegate {
    
    var str_food_prefrence_index = 0
    
    var str_selected_time:String! = ""
    var str_selected_time2:String! = ""
    
    var str_selected_time_for_morning_snack:String! = ""
    var str_selected_time_for_lunch:String! = ""
    var str_selected_time_for_evening_snack:String! = ""
    var str_selected_time_for_dinner:String! = ""
    
    var str_breakfast_select:String! = "0"
    var str_morning_snack_select:String! = "0"
    var str_lunch_select:String! = "0"
    var str_evening_snack_select:String! = "0"
    var str_dinner_select:String! = "0"
    
    // these value send to server
    var str_pass_breafast_value:String!
    var str_pass_morning_snack_value:String!
    var str_pass_lunch_value:String!
    var str_pass_evening_snack_value:String!
    var str_pass_dinner_value:String!
    
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
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tble_view.separatorColor = .white
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }

    @objc func food_prefrence_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_three_table_cell
        
        let dummyList = ["Vegetarian","Non-Vegetarian","Vegan"]
        RPicker.selectOption(title: "Select", cancelText: "Cancel", dataArray: dummyList, selectedIndex: self.str_food_prefrence_index) { (selctedText, atIndex) in
             
            self.str_food_prefrence_index = atIndex
            
            cell.txt_food_preferences.text = String(selctedText)
            
        }
        
    }
    
    @objc func breakfast_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_three_table_cell
       
    }
   
    @objc func breakfast_time_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_three_table_cell
        
        if (self.str_breakfast_select == "0") {
            self.alert_custom(message: "Please enable breakfast")
            return
        }
        
        RPicker.selectDate(title: "Select Time", cancelText: "Cancel", datePickerMode: .time, didSelectDate: { (selectedDate) in
            // TODO: Your implementation for date
            // self.btn_select_time.setTitle(selectedDate.dateString("HH:mm"), for: .normal)
            cell.lbl_checkmark_breakfast_time.text = selectedDate.dateString("HH:mm")
            self.str_selected_time = selectedDate.dateString("HH:mm")
            
            print(self.str_selected_time as Any)
            
            let fullName    = String(self.str_selected_time)
            let fullNameArr = fullName.components(separatedBy: ":")

            let hour    = fullNameArr[0]
            let minute  = fullNameArr[1]
            
            var str_am:String! = " AM"
            var str_pm:String! = " PM"
            
            if (hour == "00") {
                
                self.str_selected_time2 = "12:\(minute)"
                cell.lbl_checkmark_breakfast_time.text = "12:\(minute)\(str_am!)"
                
            } else if (hour == "01") {
                
                self.str_selected_time2 = "1:\(minute)"
                cell.lbl_checkmark_breakfast_time.text = "1:\(minute)\(str_am!)"
                
            }else if (hour == "02") {
                
                self.str_selected_time2 = "2:\(minute)"
                cell.lbl_checkmark_breakfast_time.text = "2:\(minute)\(str_am!)"
                
            }else if (hour == "03") {
                
                self.str_selected_time2 = "3:\(minute)"
                cell.lbl_checkmark_breakfast_time.text = "3:\(minute)\(str_am!)"
                
            }else if (hour == "04") {
                
                self.str_selected_time2 = "4:\(minute)"
                cell.lbl_checkmark_breakfast_time.text = "4:\(minute)\(str_am!)"
                
            }else if (hour == "05") {
                
                self.str_selected_time2 = "5:\(minute)"
                cell.lbl_checkmark_breakfast_time.text = "5:\(minute)\(str_am!)"
                
            }else if (hour == "06") {
                
                self.str_selected_time2 = "6:\(minute)"
                cell.lbl_checkmark_breakfast_time.text = "6:\(minute)\(str_am!)"
                
            }else if (hour == "07") {
                
                self.str_selected_time2 = "7:\(minute)"
                cell.lbl_checkmark_breakfast_time.text = "7:\(minute)\(str_am!)"
                
            }else if (hour == "08") {
                
                self.str_selected_time2 = "8:\(minute)"
                cell.lbl_checkmark_breakfast_time.text = "8:\(minute)\(str_am!)"
                
            }else if (hour == "09") {
                
                self.str_selected_time2 = "9:\(minute)"
                cell.lbl_checkmark_breakfast_time.text = "9:\(minute)\(str_am!)"
                
            }else if (hour == "10") {
                
                self.str_selected_time2 = "10:\(minute)"
                cell.lbl_checkmark_breakfast_time.text = "10:\(minute)\(str_am!)"
                
            }else if (hour == "11") {
                
                self.str_selected_time2 = "11:\(minute)"
                cell.lbl_checkmark_breakfast_time.text = "11:\(minute)\(str_am!)"
                
            }else if (hour == "12") {
                
                self.str_selected_time2 = "12:\(minute)"
                cell.lbl_checkmark_breakfast_time.text = "12:\(minute)\(str_am!)"
                
            }else if (hour == "13") {
                
                self.str_selected_time2 = "13:\(minute)"
                cell.lbl_checkmark_breakfast_time.text = "1:\(minute)\(str_pm!)"
                
            } else if (hour == "14") {
                
                self.str_selected_time2 = "14:\(minute)"
                cell.lbl_checkmark_breakfast_time.text = "2:\(minute)\(str_pm!)"
                
            } else if (hour == "15") {
                
                self.str_selected_time2 = "15:\(minute)\(str_pm!)"
                cell.lbl_checkmark_breakfast_time.text = "3:\(minute)\(str_pm!)"
                
            } else if (hour == "16") {
                
                self.str_selected_time2 = "16:\(minute)"
                cell.lbl_checkmark_breakfast_time.text = "4:\(minute)\(str_pm!)"
                
            } else if (hour == "17") {
                
                self.str_selected_time2 = "17:\(minute)"
                cell.lbl_checkmark_breakfast_time.text = "5:\(minute)\(str_pm!)"
                
            } else if (hour == "18") {
                
                self.str_selected_time2 = "18:\(minute)"
                cell.lbl_checkmark_breakfast_time.text = "6:\(minute)\(str_pm!)"
                
            } else if (hour == "19") {
                
                self.str_selected_time2 = "19:\(minute)"
                cell.lbl_checkmark_breakfast_time.text = "7:\(minute)\(str_pm!)"
                
            } else if (hour == "20") {
                
                self.str_selected_time2 = "20:\(minute)\(str_pm!)"
                cell.lbl_checkmark_breakfast_time.text = "8:\(minute)\(str_pm!)"
                
            } else if (hour == "21") {
                
                self.str_selected_time2 = "21:\(minute)"
                cell.lbl_checkmark_breakfast_time.text = "9:\(minute)\(str_pm!)"
                
            } else if (hour == "22") {
                
                self.str_selected_time2 = "22:\(minute)"
                cell.lbl_checkmark_breakfast_time.text = "10:\(minute)\(str_pm!)"
                
            } else if (hour == "23") {
                
                self.str_selected_time2 = "23:\(minute)"
                cell.lbl_checkmark_breakfast_time.text = "11:\(minute)\(str_pm!)"
                
            } else if (hour == "24") {
                
                self.str_selected_time2 = "244:\(minute)"
                cell.lbl_checkmark_breakfast_time.text = "12:\(minute)\(str_pm!)"
                
            } else {
                
                cell.lbl_checkmark_breakfast_time.text = selectedDate.dateString("HH:mm")
                self.str_selected_time = selectedDate.dateString("HH:mm")
                
            }
            
        })
    }
    
    // morning snack
    @objc func morning_snack_time_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_three_table_cell
        
        if (self.str_morning_snack_select == "0") {
            self.alert_custom(message: "Please enable morning snack")
            return
        }
        
        RPicker.selectDate(title: "Select Time", cancelText: "Cancel", datePickerMode: .time, didSelectDate: { (selectedDate) in
            // TODO: Your implementation for date
            // self.btn_select_time.setTitle(selectedDate.dateString("HH:mm"), for: .normal)
            cell.lbl_checkmark_morning_snack_time.text = selectedDate.dateString("HH:mm")
            self.str_selected_time_for_morning_snack = selectedDate.dateString("HH:mm")
            
            print(self.str_selected_time_for_morning_snack as Any)
            
            let fullName    = String(self.str_selected_time_for_morning_snack)
            let fullNameArr = fullName.components(separatedBy: ":")

            let hour    = fullNameArr[0]
            let minute  = fullNameArr[1]
            
            var str_am:String! = " AM"
            var str_pm:String! = " PM"
            
            if (hour == "00") {
                
                self.str_selected_time_for_morning_snack = "12:\(minute)"
                cell.lbl_checkmark_morning_snack_time.text = "12:\(minute)\(str_am!)"
                
            } else if (hour == "01") {
                
                self.str_selected_time_for_morning_snack = "1:\(minute)"
                cell.lbl_checkmark_morning_snack_time.text = "1:\(minute)\(str_am!)"
                
            }else if (hour == "02") {
                
                self.str_selected_time_for_morning_snack = "2:\(minute)"
                cell.lbl_checkmark_morning_snack_time.text = "2:\(minute)\(str_am!)"
                
            }else if (hour == "03") {
                
                self.str_selected_time_for_morning_snack = "3:\(minute)"
                cell.lbl_checkmark_morning_snack_time.text = "3:\(minute)\(str_am!)"
                
            }else if (hour == "04") {
                
                self.str_selected_time_for_morning_snack = "4:\(minute)"
                cell.lbl_checkmark_morning_snack_time.text = "4:\(minute)\(str_am!)"
                
            }else if (hour == "05") {
                
                self.str_selected_time_for_morning_snack = "5:\(minute)"
                cell.lbl_checkmark_morning_snack_time.text = "5:\(minute)\(str_am!)"
                
            }else if (hour == "06") {
                
                self.str_selected_time_for_morning_snack = "6:\(minute)"
                cell.lbl_checkmark_morning_snack_time.text = "6:\(minute)\(str_am!)"
                
            }else if (hour == "07") {
                
                self.str_selected_time_for_morning_snack = "7:\(minute)"
                cell.lbl_checkmark_morning_snack_time.text = "7:\(minute)\(str_am!)"
                
            }else if (hour == "08") {
                
                self.str_selected_time_for_morning_snack = "8:\(minute)"
                cell.lbl_checkmark_morning_snack_time.text = "8:\(minute)\(str_am!)"
                
            }else if (hour == "09") {
                
                self.str_selected_time_for_morning_snack = "9:\(minute)"
                cell.lbl_checkmark_morning_snack_time.text = "9:\(minute)\(str_am!)"
                
            }else if (hour == "10") {
                
                self.str_selected_time_for_morning_snack = "10:\(minute)"
                cell.lbl_checkmark_morning_snack_time.text = "10:\(minute)\(str_am!)"
                
            }else if (hour == "11") {
                
                self.str_selected_time_for_morning_snack = "11:\(minute)"
                cell.lbl_checkmark_morning_snack_time.text = "11:\(minute)\(str_am!)"
                
            }else if (hour == "12") {
                
                self.str_selected_time_for_morning_snack = "12:\(minute)"
                cell.lbl_checkmark_morning_snack_time.text = "12:\(minute)\(str_am!)"
                
            }else if (hour == "13") {
                
                self.str_selected_time_for_morning_snack = "13:\(minute)"
                cell.lbl_checkmark_morning_snack_time.text = "1:\(minute)\(str_pm!)"
                
            } else if (hour == "14") {
                
                self.str_selected_time_for_morning_snack = "14:\(minute)"
                cell.lbl_checkmark_morning_snack_time.text = "2:\(minute)\(str_pm!)"
                
            } else if (hour == "15") {
                
                self.str_selected_time_for_morning_snack = "15:\(minute)"
                cell.lbl_checkmark_morning_snack_time.text = "3:\(minute)\(str_pm!)"
                
            } else if (hour == "16") {
                
                self.str_selected_time_for_morning_snack = "16:\(minute)"
                cell.lbl_checkmark_morning_snack_time.text = "4:\(minute)\(str_pm!)"
                
            } else if (hour == "17") {
                
                self.str_selected_time_for_morning_snack = "17:\(minute)"
                cell.lbl_checkmark_morning_snack_time.text = "5:\(minute)\(str_pm!)"
                
            } else if (hour == "18") {
                
                self.str_selected_time_for_morning_snack = "18:\(minute)"
                cell.lbl_checkmark_morning_snack_time.text = "6:\(minute)\(str_pm!)"
                
            } else if (hour == "19") {
                
                self.str_selected_time_for_morning_snack = "19:\(minute)"
                cell.lbl_checkmark_morning_snack_time.text = "7:\(minute)\(str_pm!)"
                
            } else if (hour == "20") {
                
                self.str_selected_time_for_morning_snack = "20:\(minute)"
                cell.lbl_checkmark_morning_snack_time.text = "8:\(minute)\(str_pm!)"
                
            } else if (hour == "21") {
                
                self.str_selected_time_for_morning_snack = "21:\(minute)"
                cell.lbl_checkmark_morning_snack_time.text = "9:\(minute)\(str_pm!)"
                
            } else if (hour == "22") {
                
                self.str_selected_time_for_morning_snack = "22:\(minute)"
                cell.lbl_checkmark_morning_snack_time.text = "10:\(minute)\(str_pm!)"
                
            } else if (hour == "23") {
                
                self.str_selected_time_for_morning_snack = "23:\(minute)"
                cell.lbl_checkmark_morning_snack_time.text = "11:\(minute)\(str_pm!)"
                
            } else if (hour == "24") {
                
                self.str_selected_time_for_morning_snack = "244:\(minute)"
                cell.lbl_checkmark_morning_snack_time.text = "12:\(minute)\(str_pm!)"
                
            } else {
                
                cell.lbl_checkmark_morning_snack_time.text = selectedDate.dateString("HH:mm")
                self.str_selected_time_for_morning_snack = selectedDate.dateString("HH:mm")
                
            }
            
        })
    }

    // lunch
    @objc func lunch_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_three_table_cell
        
        if (self.str_lunch_select == "0") {
            self.alert_custom(message: "Please enable lunch")
            return
        }
        
        RPicker.selectDate(title: "Select Time", cancelText: "Cancel", datePickerMode: .time, didSelectDate: { (selectedDate) in
            // TODO: Your implementation for date
            // self.btn_select_time.setTitle(selectedDate.dateString("HH:mm"), for: .normal)
            cell.lbl_checkmark_lunch_time.text = selectedDate.dateString("HH:mm")
            self.str_selected_time_for_lunch = selectedDate.dateString("HH:mm")
            
            print(self.str_selected_time_for_lunch as Any)
            
            let fullName    = String(self.str_selected_time_for_lunch)
            let fullNameArr = fullName.components(separatedBy: ":")

            let hour    = fullNameArr[0]
            let minute = fullNameArr[1]
            
            var str_am:String! = " AM"
            var str_pm:String! = " PM"
            
            if (hour == "00") {
                
                self.str_selected_time_for_lunch = "12:\(minute)"
                cell.lbl_checkmark_lunch_time.text = "12:\(minute)\(str_am!)"
                
            } else if (hour == "01") {
                
                self.str_selected_time_for_lunch = "1:\(minute)"
                cell.lbl_checkmark_lunch_time.text = "1:\(minute)\(str_am!)"
                
            }else if (hour == "02") {
                
                self.str_selected_time_for_lunch = "2:\(minute)"
                cell.lbl_checkmark_lunch_time.text = "2:\(minute)\(str_am!)"
                
            }else if (hour == "03") {
                
                self.str_selected_time_for_lunch = "3:\(minute)"
                cell.lbl_checkmark_lunch_time.text = "3:\(minute)\(str_am!)"
                
            }else if (hour == "04") {
                
                self.str_selected_time_for_lunch = "4:\(minute)"
                cell.lbl_checkmark_lunch_time.text = "4:\(minute)\(str_am!)"
                
            }else if (hour == "05") {
                
                self.str_selected_time_for_lunch = "5:\(minute)"
                cell.lbl_checkmark_lunch_time.text = "5:\(minute)\(str_am!)"
                
            }else if (hour == "06") {
                
                self.str_selected_time_for_lunch = "6:\(minute)"
                cell.lbl_checkmark_lunch_time.text = "6:\(minute)\(str_am!)"
                
            }else if (hour == "07") {
                
                self.str_selected_time_for_lunch = "7:\(minute)"
                cell.lbl_checkmark_lunch_time.text = "7:\(minute)\(str_am!)"
                
            }else if (hour == "08") {
                
                self.str_selected_time_for_lunch = "8:\(minute)"
                cell.lbl_checkmark_lunch_time.text = "8:\(minute)\(str_am!)"
                
            }else if (hour == "09") {
                
                self.str_selected_time_for_lunch = "9:\(minute)"
                cell.lbl_checkmark_lunch_time.text = "9:\(minute)\(str_am!)"
                
            }else if (hour == "10") {
                
                self.str_selected_time_for_lunch = "10:\(minute)"
                cell.lbl_checkmark_lunch_time.text = "10:\(minute)\(str_am!)"
                
            }else if (hour == "11") {
                
                self.str_selected_time_for_lunch = "11:\(minute)"
                cell.lbl_checkmark_lunch_time.text = "11:\(minute)\(str_am!)"
                
            }else if (hour == "12") {
                
                self.str_selected_time_for_lunch = "12:\(minute)"
                cell.lbl_checkmark_lunch_time.text = "12:\(minute)\(str_am!)"
                
            }else if (hour == "13") {
                
                self.str_selected_time_for_lunch = "13:\(minute)"
                cell.lbl_checkmark_lunch_time.text = "1:\(minute)\(str_pm!)"
                
            } else if (hour == "14") {
                
                self.str_selected_time_for_lunch = "14:\(minute)"
                cell.lbl_checkmark_lunch_time.text = "2:\(minute)\(str_pm!)"
                
            } else if (hour == "15") {
                
                self.str_selected_time_for_lunch = "15:\(minute)"
                cell.lbl_checkmark_lunch_time.text = "3:\(minute)\(str_pm!)"
                
            } else if (hour == "16") {
                
                self.str_selected_time_for_lunch = "16:\(minute)"
                cell.lbl_checkmark_lunch_time.text = "4:\(minute)\(str_pm!)"
                
            } else if (hour == "17") {
                
                self.str_selected_time_for_lunch = "17:\(minute)"
                cell.lbl_checkmark_lunch_time.text = "5:\(minute)\(str_pm!)"
                
            } else if (hour == "18") {
                
                self.str_selected_time_for_lunch = "18:\(minute)"
                cell.lbl_checkmark_lunch_time.text = "6:\(minute)\(str_pm!)"
                
            } else if (hour == "19") {
                
                self.str_selected_time_for_lunch = "19:\(minute)"
                cell.lbl_checkmark_lunch_time.text = "7:\(minute)\(str_pm!)"
                
            } else if (hour == "20") {
                
                self.str_selected_time_for_lunch = "20:\(minute)"
                cell.lbl_checkmark_lunch_time.text = "8:\(minute)\(str_pm!)"
                
            } else if (hour == "21") {
                
                self.str_selected_time_for_lunch = "21:\(minute)"
                cell.lbl_checkmark_lunch_time.text = "9:\(minute)\(str_pm!)"
                
            } else if (hour == "22") {
                
                self.str_selected_time_for_lunch = "22:\(minute)"
                cell.lbl_checkmark_lunch_time.text = "10:\(minute)\(str_pm!)"
                
            } else if (hour == "23") {
                
                self.str_selected_time_for_lunch = "23:\(minute)"
                cell.lbl_checkmark_lunch_time.text = "11:\(minute)\(str_pm!)"
                
            } else if (hour == "24") {
                
                self.str_selected_time_for_lunch = "244:\(minute)"
                cell.lbl_checkmark_lunch_time.text = "12:\(minute)\(str_pm!)"
                
            } else {
                
                cell.lbl_checkmark_lunch_time.text = selectedDate.dateString("HH:mm")
                self.str_selected_time_for_lunch = selectedDate.dateString("HH:mm")
                
            }
            
        })
    }
    
    // evening snack
    @objc func evening_snack_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_three_table_cell
        
        if (self.str_evening_snack_select == "0") {
            self.alert_custom(message: "Please enable evening snack")
            return
        }
        
        RPicker.selectDate(title: "Select Time", cancelText: "Cancel", datePickerMode: .time, didSelectDate: { (selectedDate) in
            // TODO: Your implementation for date
            // self.btn_select_time.setTitle(selectedDate.dateString("HH:mm"), for: .normal)
            cell.lbl_checkmark_evening_snack_time.text = selectedDate.dateString("HH:mm")
            self.str_selected_time_for_evening_snack = selectedDate.dateString("HH:mm")
            
            print(self.str_selected_time_for_evening_snack as Any)
            
            let fullName    = String(self.str_selected_time_for_evening_snack)
            let fullNameArr = fullName.components(separatedBy: ":")

            let hour    = fullNameArr[0]
            let minute = fullNameArr[1]
            
            var str_am:String! = " AM"
            var str_pm:String! = " PM"
            
            if (hour == "00") {
                
                self.str_selected_time_for_evening_snack = "12:\(minute)"
                cell.lbl_checkmark_evening_snack_time.text = "12:\(minute)\(str_am!)"
                
            } else if (hour == "01") {
                
                self.str_selected_time_for_evening_snack = "1:\(minute)"
                cell.lbl_checkmark_evening_snack_time.text = "1:\(minute)\(str_am!)"
                
            }else if (hour == "02") {
                
                self.str_selected_time_for_evening_snack = "2:\(minute)"
                cell.lbl_checkmark_evening_snack_time.text = "2:\(minute)\(str_am!)"
                
            }else if (hour == "03") {
                
                self.str_selected_time_for_evening_snack = "3:\(minute)"
                cell.lbl_checkmark_evening_snack_time.text = "3:\(minute)\(str_am!)"
                
            }else if (hour == "04") {
                
                self.str_selected_time_for_evening_snack = "4:\(minute)"
                cell.lbl_checkmark_evening_snack_time.text = "4:\(minute)\(str_am!)"
                
            }else if (hour == "05") {
                
                self.str_selected_time_for_evening_snack = "5:\(minute)"
                cell.lbl_checkmark_evening_snack_time.text = "5:\(minute)\(str_am!)"
                
            }else if (hour == "06") {
                
                self.str_selected_time_for_evening_snack = "6:\(minute)"
                cell.lbl_checkmark_evening_snack_time.text = "6:\(minute)\(str_am!)"
                
            }else if (hour == "07") {
                
                self.str_selected_time_for_evening_snack = "7:\(minute)"
                cell.lbl_checkmark_evening_snack_time.text = "7:\(minute)\(str_am!)"
                
            }else if (hour == "08") {
                
                self.str_selected_time_for_evening_snack = "8:\(minute)"
                cell.lbl_checkmark_evening_snack_time.text = "8:\(minute)\(str_am!)"
                
            }else if (hour == "09") {
                
                self.str_selected_time_for_evening_snack = "9:\(minute)"
                cell.lbl_checkmark_evening_snack_time.text = "9:\(minute)\(str_am!)"
                
            }else if (hour == "10") {
                
                self.str_selected_time_for_evening_snack = "10:\(minute)"
                cell.lbl_checkmark_evening_snack_time.text = "10:\(minute)\(str_am!)"
                
            }else if (hour == "11") {
                
                self.str_selected_time_for_evening_snack = "11:\(minute)"
                cell.lbl_checkmark_evening_snack_time.text = "11:\(minute)\(str_am!)"
                
            }else if (hour == "12") {
                
                self.str_selected_time_for_evening_snack = "12:\(minute)"
                cell.lbl_checkmark_evening_snack_time.text = "12:\(minute)\(str_am!)"
                
            }else if (hour == "13") {
                
                self.str_selected_time_for_evening_snack = "13:\(minute)"
                cell.lbl_checkmark_evening_snack_time.text = "1:\(minute)\(str_pm!)"
                
            } else if (hour == "14") {
                
                self.str_selected_time_for_evening_snack = "14:\(minute)"
                cell.lbl_checkmark_evening_snack_time.text = "2:\(minute)\(str_pm!)"
                
            } else if (hour == "15") {
                
                self.str_selected_time_for_evening_snack = "15:\(minute)"
                cell.lbl_checkmark_evening_snack_time.text = "3:\(minute)\(str_pm!)"
                
            } else if (hour == "16") {
                
                self.str_selected_time_for_evening_snack = "16:\(minute)"
                cell.lbl_checkmark_evening_snack_time.text = "4:\(minute)\(str_pm!)"
                
            } else if (hour == "17") {
                
                self.str_selected_time_for_evening_snack = "17:\(minute)"
                cell.lbl_checkmark_evening_snack_time.text = "5:\(minute)\(str_pm!)"
                
            } else if (hour == "18") {
                
                self.str_selected_time_for_evening_snack = "18:\(minute)"
                cell.lbl_checkmark_evening_snack_time.text = "6:\(minute)\(str_pm!)"
                
            } else if (hour == "19") {
                
                self.str_selected_time_for_evening_snack = "19:\(minute)"
                cell.lbl_checkmark_evening_snack_time.text = "7:\(minute)\(str_pm!)"
                
            } else if (hour == "20") {
                
                self.str_selected_time_for_evening_snack = "20:\(minute)"
                cell.lbl_checkmark_evening_snack_time.text = "8:\(minute)\(str_pm!)"
                
            } else if (hour == "21") {
                
                self.str_selected_time_for_evening_snack = "21:\(minute)"
                cell.lbl_checkmark_evening_snack_time.text = "9:\(minute)\(str_pm!)"
                
            } else if (hour == "22") {
                
                self.str_selected_time_for_evening_snack = "22:\(minute)"
                cell.lbl_checkmark_evening_snack_time.text = "10:\(minute)\(str_pm!)"
                
            } else if (hour == "23") {
                
                self.str_selected_time_for_evening_snack = "23:\(minute)"
                cell.lbl_checkmark_evening_snack_time.text = "11:\(minute)\(str_pm!)"
                
            } else if (hour == "24") {
                
                self.str_selected_time_for_evening_snack = "244:\(minute)"
                cell.lbl_checkmark_evening_snack_time.text = "12:\(minute)\(str_pm!)"
                
            } else {
                
                cell.lbl_checkmark_evening_snack_time.text = selectedDate.dateString("HH:mm")
                self.str_selected_time_for_evening_snack = selectedDate.dateString("HH:mm")
                
            }
            
        })
    }
    
    
    // dinner
    @objc func dinner_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_three_table_cell
        
        if (self.str_dinner_select == "0") {
            self.alert_custom(message: "Please enable dinner")
            return
        }
        
        RPicker.selectDate(title: "Select Time", cancelText: "Cancel", datePickerMode: .time, didSelectDate: { (selectedDate) in
            // TODO: Your implementation for date
            // self.btn_select_time.setTitle(selectedDate.dateString("HH:mm"), for: .normal)
            cell.lbl_checkmark_dinner_time.text = selectedDate.dateString("HH:mm")
            self.str_selected_time_for_dinner = selectedDate.dateString("HH:mm")
            
            print(self.str_selected_time_for_dinner as Any)
            
            let fullName    = String(self.str_selected_time_for_dinner)
            let fullNameArr = fullName.components(separatedBy: ":")

            let hour    = fullNameArr[0]
            let minute = fullNameArr[1]
            
            var str_am:String! = " AM"
            var str_pm:String! = " PM"
            
            if (hour == "00") {
                
                self.str_selected_time_for_dinner = "12:\(minute)"
                cell.lbl_checkmark_dinner_time.text = "12:\(minute)\(str_am!)"
                
            } else if (hour == "01") {
                
                self.str_selected_time_for_dinner = "1:\(minute)"
                cell.lbl_checkmark_dinner_time.text = "1:\(minute)\(str_am!)"
                
            }else if (hour == "02") {
                
                self.str_selected_time_for_dinner = "2:\(minute)"
                cell.lbl_checkmark_dinner_time.text = "2:\(minute)\(str_am!)"
                
            }else if (hour == "03") {
                
                self.str_selected_time_for_dinner = "3:\(minute)"
                cell.lbl_checkmark_dinner_time.text = "3:\(minute)\(str_am!)"
                
            }else if (hour == "04") {
                
                self.str_selected_time_for_dinner = "4:\(minute)"
                cell.lbl_checkmark_dinner_time.text = "4:\(minute)\(str_am!)"
                
            }else if (hour == "05") {
                
                self.str_selected_time_for_dinner = "5:\(minute)"
                cell.lbl_checkmark_dinner_time.text = "5:\(minute)\(str_am!)"
                
            }else if (hour == "06") {
                
                self.str_selected_time_for_dinner = "6:\(minute)"
                cell.lbl_checkmark_dinner_time.text = "6:\(minute)\(str_am!)"
                
            }else if (hour == "07") {
                
                self.str_selected_time_for_dinner = "7:\(minute)"
                cell.lbl_checkmark_dinner_time.text = "7:\(minute)\(str_am!)"
                
            }else if (hour == "08") {
                
                self.str_selected_time_for_dinner = "8:\(minute)"
                cell.lbl_checkmark_dinner_time.text = "8:\(minute)\(str_am!)"
                
            }else if (hour == "09") {
                
                self.str_selected_time_for_dinner = "9:\(minute)"
                cell.lbl_checkmark_dinner_time.text = "9:\(minute)\(str_am!)"
                
            }else if (hour == "10") {
                
                self.str_selected_time_for_dinner = "10:\(minute)"
                cell.lbl_checkmark_dinner_time.text = "10:\(minute)\(str_am!)"
                
            }else if (hour == "11") {
                
                self.str_selected_time_for_dinner = "11:\(minute)"
                cell.lbl_checkmark_dinner_time.text = "11:\(minute)\(str_am!)"
                
            }else if (hour == "12") {
                
                self.str_selected_time_for_dinner = "12:\(minute)"
                cell.lbl_checkmark_dinner_time.text = "12:\(minute)\(str_am!)"
                
            }else if (hour == "13") {
                
                self.str_selected_time_for_dinner = "13:\(minute)"
                cell.lbl_checkmark_dinner_time.text = "1:\(minute)\(str_pm!)"
                
            } else if (hour == "14") {
                
                self.str_selected_time_for_dinner = "14:\(minute)"
                cell.lbl_checkmark_dinner_time.text = "2:\(minute)\(str_pm!)"
                
            } else if (hour == "15") {
                
                self.str_selected_time_for_dinner = "15:\(minute)"
                cell.lbl_checkmark_dinner_time.text = "3:\(minute)\(str_pm!)"
                
            } else if (hour == "16") {
                
                self.str_selected_time_for_dinner = "16:\(minute)"
                cell.lbl_checkmark_dinner_time.text = "4:\(minute)\(str_pm!)"
                
            } else if (hour == "17") {
                
                self.str_selected_time_for_dinner = "17:\(minute)"
                cell.lbl_checkmark_dinner_time.text = "5:\(minute)\(str_pm!)"
                
            } else if (hour == "18") {
                
                self.str_selected_time_for_dinner = "18:\(minute)"
                cell.lbl_checkmark_dinner_time.text = "6:\(minute)\(str_pm!)"
                
            } else if (hour == "19") {
                
                self.str_selected_time_for_dinner = "19:\(minute)"
                cell.lbl_checkmark_dinner_time.text = "7:\(minute)\(str_pm!)"
                
            } else if (hour == "20") {
                
                self.str_selected_time_for_dinner = "20:\(minute)"
                cell.lbl_checkmark_dinner_time.text = "8:\(minute)\(str_pm!)"
                
            } else if (hour == "21") {
                
                self.str_selected_time_for_dinner = "21:\(minute)"
                cell.lbl_checkmark_dinner_time.text = "9:\(minute)\(str_pm!)"
                
            } else if (hour == "22") {
                
                self.str_selected_time_for_evening_snack = "22:\(minute)"
                cell.lbl_checkmark_dinner_time.text = "10:\(minute)\(str_pm!)"
                
            } else if (hour == "23") {
                
                self.str_selected_time_for_dinner = "23:\(minute)"
                cell.lbl_checkmark_dinner_time.text = "11:\(minute)\(str_pm!)"
                
            } else if (hour == "24") {
                
                self.str_selected_time_for_dinner = "244:\(minute)"
                cell.lbl_checkmark_dinner_time.text = "12:\(minute)\(str_pm!)"
                
            } else {
                
                cell.lbl_checkmark_dinner_time.text = selectedDate.dateString("HH:mm")
                self.str_selected_time_for_dinner = selectedDate.dateString("HH:mm")
                
            }
            
        })
    }
  
    @objc func complete_profile_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_three_table_cell
        
        if (cell.txt_food_preferences.text == "") {
            self.alert_show_error(field_name: "Food Prefrences")
        } else {
            // self.create_an_account(loader: "yes")
            self.validation_before_submit()
        }
  
    }
    
    @objc func validation_before_submit() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_three_table_cell
        
       
        
        if (self.str_breakfast_select == "0") {
            str_pass_breafast_value = cell.lbl_checkmark_breakfast_time.text
        } else if (self.str_breakfast_select == "1") {
            if (cell.lbl_checkmark_breakfast_time.text == "select") {
                print("Please select time")
                self.alert_custom(message: "Please select breakfast time")
                return
            }
        }
        
        
        // morning snack
        print(self.str_morning_snack_select as Any)
        if (self.str_morning_snack_select == "0") {
            str_pass_breafast_value = cell.lbl_checkmark_morning_snack_time.text
        } else if (self.str_morning_snack_select == "1") {
            if (cell.lbl_checkmark_morning_snack_time.text == "select") {
                print("Please select time")
                self.alert_custom(message: "Please select morning snack time")
                return
            }
        }
        
        // lunch
        print(self.str_lunch_select as Any)
        if (self.str_lunch_select == "0") {
            str_pass_breafast_value = cell.lbl_checkmark_lunch_time.text
        } else if (self.str_lunch_select == "1") {
            if (cell.lbl_checkmark_lunch_time.text == "select") {
                print("Please select time")
                self.alert_custom(message: "Please select lunch time")
                return
            }
        }
        
        // evening snack
        print(self.str_evening_snack_select as Any)
        if (self.str_evening_snack_select == "0") {
            str_pass_breafast_value = cell.lbl_checkmark_evening_snack_time.text
        } else if (self.str_evening_snack_select == "1") {
            if (cell.lbl_checkmark_evening_snack_time.text == "select") {
                print("Please select time")
                self.alert_custom(message: "Please select evening snack time")
                return
            }
        }
        
        // dinner
        print(self.str_dinner_select as Any)
        if (self.str_dinner_select == "0") {
            str_pass_breafast_value = cell.lbl_checkmark_dinner_time.text
        } else if (self.str_dinner_select == "1") {
            if (cell.lbl_checkmark_dinner_time.text == "select") {
                print("Please select time")
                self.alert_custom(message: "Please select dinner time")
                return
            }
        }
        
        print("DISHANT RAJPUT")
        
        self.create_an_account(loader: "yes")
        
    }
    
    @objc func create_an_account(loader:String) {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_three_table_cell
        
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
                    "action"            : "editprofile",
                    "userId"            : String(myString),
                    "food_preference"   : String(cell.txt_food_preferences.text!),
                    "breakfast_time"    : String(self.str_selected_time2),
                    "morning_snack_time": String(self.str_selected_time_for_morning_snack),
                    "evening_snack_time": String(self.str_selected_time_for_evening_snack),
                    "dinner_time"       : String(self.str_selected_time_for_dinner),
                    "lunch_time"       : String(self.str_selected_time_for_lunch),
                    
                    "breakfast"         : String(self.str_breakfast_select),
                    "morning_snack"     : String(self.str_morning_snack_select),
                    "lunch"             : String(self.str_lunch_select),
                    "evening_snack"     : String(self.str_evening_snack_select),
                    "dinner"            : String(self.str_dinner_select),
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
                                
                                let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "dashboard_id")
                                self.navigationController?.pushViewController(push, animated: true)
                                
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
                        
                        self.create_an_account(loader: "no")
                        
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
    
    
    @objc func breakfast_checkmark_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_three_table_cell
        
        // print("breakfast checkmark")
        
        if (cell.btn_checkmark_breakfast.tag == 0) {
            cell.btn_checkmark_breakfast.tag = 1
            print("1")
            
            self.str_breakfast_select = "1"
            cell.btn_checkmark_breakfast.setImage(UIImage(named: "check"), for: .normal)
            
            cell.lbl_checkmark_breakfast_time.textColor = UIColor.black
            
            cell.lbl_checkmark_breakfast_time.text = "select"
            
        } else {
            cell.btn_checkmark_breakfast.tag = 0
            print("0")
            
            self.str_breakfast_select = "0"
            cell.btn_checkmark_breakfast.setImage(UIImage(named: "uncheck"), for: .normal)
            
            cell.lbl_checkmark_breakfast_time.textColor = UIColor.gray
            
            cell.lbl_checkmark_breakfast_time.text = "disabled"
        }
        
        
    }
    
    //
    @objc func morning_snack_checkmark_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_three_table_cell
        
        if (cell.btn_checkmark_morning_snack.tag == 0) {
            cell.btn_checkmark_morning_snack.tag = 1
            print("1")
            
            self.str_morning_snack_select = "1"
            cell.btn_checkmark_morning_snack.setImage(UIImage(named: "check"), for: .normal)
            
            cell.lbl_checkmark_morning_snack_time.textColor = UIColor.black
            
            cell.lbl_checkmark_morning_snack_time.text = "select"
            
        } else {
            cell.btn_checkmark_morning_snack.tag = 0
            print("0")
            
            self.str_morning_snack_select = "0"
            cell.btn_checkmark_morning_snack.setImage(UIImage(named: "uncheck"), for: .normal)
            
            cell.lbl_checkmark_morning_snack_time.textColor = UIColor.gray
            
            cell.lbl_checkmark_morning_snack_time.text = "disabled"
        }
        
        
    }
    
    @objc func lunch_checkmark_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_three_table_cell
        
        if (cell.btn_checkmark_lunch.tag == 0) {
            cell.btn_checkmark_lunch.tag = 1
            print("1")
            
            self.str_lunch_select = "1"
            cell.btn_checkmark_lunch.setImage(UIImage(named: "check"), for: .normal)
            
            cell.lbl_checkmark_lunch_time.textColor = UIColor.black
            
            cell.lbl_checkmark_lunch_time.text = "select"
            
        } else {
            cell.btn_checkmark_lunch.tag = 0
            print("0")
            
            self.str_lunch_select = "0"
            cell.btn_checkmark_lunch.setImage(UIImage(named: "uncheck"), for: .normal)
            
            cell.lbl_checkmark_lunch_time.textColor = UIColor.gray
            
            cell.lbl_checkmark_lunch_time.text = "disabled"
        }
        
        
    }
    
    @objc func evening_snack_checkmark_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_three_table_cell
        
        if (cell.btn_checkmark_evening_snack.tag == 0) {
            cell.btn_checkmark_evening_snack.tag = 1
            print("1")
            
            self.str_evening_snack_select = "1"
            cell.btn_checkmark_evening_snack.setImage(UIImage(named: "check"), for: .normal)
            
            cell.lbl_checkmark_evening_snack_time.textColor = UIColor.black
            
            cell.lbl_checkmark_evening_snack_time.text = "select"
            
        } else {
            cell.btn_checkmark_evening_snack.tag = 0
            print("0")
            
            self.str_evening_snack_select = "0"
            cell.btn_checkmark_evening_snack.setImage(UIImage(named: "uncheck"), for: .normal)
            
            cell.lbl_checkmark_evening_snack_time.textColor = UIColor.gray
            
            cell.lbl_checkmark_evening_snack_time.text = "disabled"
        }
        
        
    }
    
    @objc func dinner_checkmark_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_three_table_cell
        
        if (cell.btn_checkmark_dinner.tag == 0) {
            cell.btn_checkmark_dinner.tag = 1
            print("1")
            
            self.str_dinner_select = "1"
            cell.btn_checkmark_dinner.setImage(UIImage(named: "check"), for: .normal)
            
            cell.lbl_checkmark_dinner_time.textColor = UIColor.black
            
            cell.lbl_checkmark_dinner_time.text = "select"
            
        } else {
            cell.btn_checkmark_dinner.tag = 0
            print("0")
            
            self.str_dinner_select = "0"
            cell.btn_checkmark_dinner.setImage(UIImage(named: "uncheck"), for: .normal)
            
            cell.lbl_checkmark_dinner_time.textColor = UIColor.gray
            
            cell.lbl_checkmark_dinner_time.text = "disabled"
        }
        
        
    }
}

//MARK:- TABLE VIEW -
extension complete_profile_three: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:complete_profile_three_table_cell = tableView.dequeueReusableCell(withIdentifier: "complete_profile_three_table_cell") as! complete_profile_three_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(breakfast_time_click_method))
        cell.lbl_checkmark_breakfast_time.isUserInteractionEnabled = true
        cell.lbl_checkmark_breakfast_time.addGestureRecognizer(tap)
        
        // morning snack
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(morning_snack_time_click_method))
        cell.lbl_checkmark_morning_snack_time.isUserInteractionEnabled = true
        cell.lbl_checkmark_morning_snack_time.addGestureRecognizer(tap2)
        
        // lunch
        let tap3 = UITapGestureRecognizer(target: self, action: #selector(lunch_click_method))
        cell.lbl_checkmark_lunch_time.isUserInteractionEnabled = true
        cell.lbl_checkmark_lunch_time.addGestureRecognizer(tap3)
        
        // evening snack
        let tap4 = UITapGestureRecognizer(target: self, action: #selector(evening_snack_click_method))
        cell.lbl_checkmark_evening_snack_time.isUserInteractionEnabled = true
        cell.lbl_checkmark_evening_snack_time.addGestureRecognizer(tap4)
        
        // evening snack
        let tap5 = UITapGestureRecognizer(target: self, action: #selector(dinner_click_method))
        cell.lbl_checkmark_dinner_time.isUserInteractionEnabled = true
        cell.lbl_checkmark_dinner_time.addGestureRecognizer(tap5)
        
        
        cell.btn_continue.addTarget(self, action: #selector(complete_profile_click_method), for: .touchUpInside)
        cell.btn_food_prefrence.addTarget(self, action: #selector(food_prefrence_click_method), for: .touchUpInside)
        // cell.btn_checkmark_lunch.addTarget(self, action: #selector(lunch_click_method), for: .touchUpInside)
        
        
        cell.btn_checkmark_breakfast.tag = 0
        cell.btn_checkmark_breakfast.addTarget(self, action: #selector(breakfast_checkmark_click_method), for: .touchUpInside)
        
        cell.btn_checkmark_morning_snack.tag = 0
        cell.btn_checkmark_morning_snack.addTarget(self, action: #selector(morning_snack_checkmark_click_method), for: .touchUpInside)
        
        cell.btn_checkmark_lunch.tag = 0
        cell.btn_checkmark_lunch.addTarget(self, action: #selector(lunch_checkmark_click_method), for: .touchUpInside)
        
        cell.btn_checkmark_evening_snack.tag = 0
        cell.btn_checkmark_evening_snack.addTarget(self, action: #selector(evening_snack_checkmark_click_method), for: .touchUpInside)
        
        cell.btn_checkmark_dinner.tag = 0
        cell.btn_checkmark_dinner.addTarget(self, action: #selector(dinner_checkmark_click_method), for: .touchUpInside)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 800
    }

}
