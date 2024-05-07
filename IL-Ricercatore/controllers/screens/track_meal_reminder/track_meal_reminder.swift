//
//  track_meal_reminder.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 19/12/23.
//

import UIKit
import UserNotifications

class track_meal_reminder: UIViewController, UNUserNotificationCenterDelegate {

    var lastScheduledBadgeCount = 0
    
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
    
    var int_hr:Int!
    var int_min:Int!
    
    @IBOutlet weak var btn_menu:UIButton! {
        didSet {
            btn_menu.tintColor = .white
            btn_menu.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
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
            lbl_navigation_title.text = "Meal Reminder"
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
        
        self.btn_reset.addTarget(self, action: #selector(edit_calorie_budget_click_method), for: .touchUpInside)
        
        requestNotificationAuthorization()
        UNUserNotificationCenter.current().delegate = self
        
    }
    
    @objc func edit_calorie_budget_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "water_intake_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
 
    @objc func set_reminder(get_full_time:String) {
         
        let separate_time = get_full_time.components(separatedBy: ":")
        let hr = separate_time[0]
        let min = separate_time[1]
        
        self.int_hr = Int(hr)
        self.int_min = Int(min)
        
        // print(self.int_hr as Any)
        // print(self.int_min as Any)
        
        self.scheduleDailyReminder(hour: self.int_hr,
                                   minute: self.int_min,
                                   header: local_notification_meal_reminder_breakfast_header,
                                   body: local_notification_meal_reminder_breakfast_body,
                                   identifier: identifier_meal_reminder_breakfast)
    }
    
    func requestNotificationAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                debugPrint("Notification permission granted")
            } else {
                print("Notification permission denied: \(error?.localizedDescription ?? "")")
            }
        }
    }
    
    func updateBadgeCount() {
        // Fetch the current badge count
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.lastScheduledBadgeCount = UIApplication.shared.applicationIconBadgeNumber
                UIApplication.shared.applicationIconBadgeNumber = self.lastScheduledBadgeCount
            }
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // Decrease the badge count by 1 if user interacts with the notification
        lastScheduledBadgeCount -= 1
        UIApplication.shared.applicationIconBadgeNumber = lastScheduledBadgeCount
        
        // Call the completion handler when finished processing the notification
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Show the notification banner even when the app is open
        completionHandler([.alert, .sound, .badge])
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @objc func breakfast_time_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! track_meal_reminder_table_cell
        
        if (self.str_breakfast_select == "0") {
            self.alert_custom(message: "Please enable breakfast")
            return
        }
        
        RPicker.selectDate(title: "Select Time", cancelText: "Cancel", datePickerMode: .time, didSelectDate: { (selectedDate) in
            // TODO: Your implementation for date
            // self.btn_select_time.setTitle(selectedDate.dateString("HH:mm"), for: .normal)
            cell.lbl_checkmark_breakfast_time.text = selectedDate.dateString("HH:mm")
            self.str_selected_time = selectedDate.dateString("HH:mm")
            
            // print(self.str_selected_time as Any)
            
            let fullName    = String(self.str_selected_time)
            let fullNameArr = fullName.components(separatedBy: ":")

            let hour    = fullNameArr[0]
            let minute  = fullNameArr[1]
            
            let str_am:String! = " AM"
            let str_pm:String! = " PM"
            
            if (hour == "00") {
                
                self.str_selected_time2 = "12:\(minute)"
                cell.lbl_checkmark_breakfast_time.text = "12:\(minute)\(str_am!)"
                
            } else if (hour == "01") {
                
                self.str_selected_time2 = "1:\(minute)"
                cell.lbl_checkmark_breakfast_time.text = "1:\(minute)\(str_am!)"
                
            } else if (hour == "02") {
                
                self.str_selected_time2 = "2:\(minute)"
                cell.lbl_checkmark_breakfast_time.text = "2:\(minute)\(str_am!)"
                
            } else if (hour == "03") {
                
                self.str_selected_time2 = "3:\(minute)"
                cell.lbl_checkmark_breakfast_time.text = "3:\(minute)\(str_am!)"
                
            } else if (hour == "04") {
                
                self.str_selected_time2 = "4:\(minute)"
                cell.lbl_checkmark_breakfast_time.text = "4:\(minute)\(str_am!)"
                
            } else if (hour == "05") {
                
                self.str_selected_time2 = "5:\(minute)"
                cell.lbl_checkmark_breakfast_time.text = "5:\(minute)\(str_am!)"
                
            } else if (hour == "06") {
                
                self.str_selected_time2 = "6:\(minute)"
                cell.lbl_checkmark_breakfast_time.text = "6:\(minute)\(str_am!)"
                
            } else if (hour == "07") {
                
                self.str_selected_time2 = "7:\(minute)"
                cell.lbl_checkmark_breakfast_time.text = "7:\(minute)\(str_am!)"
                
            } else if (hour == "08") {
                
                self.str_selected_time2 = "8:\(minute)"
                cell.lbl_checkmark_breakfast_time.text = "8:\(minute)\(str_am!)"
                
            } else if (hour == "09") {
                
                self.str_selected_time2 = "9:\(minute)"
                cell.lbl_checkmark_breakfast_time.text = "9:\(minute)\(str_am!)"
                
            } else if (hour == "10") {
                
                self.str_selected_time2 = "10:\(minute)"
                cell.lbl_checkmark_breakfast_time.text = "10:\(minute)\(str_am!)"
                
            } else if (hour == "11") {
                
                self.str_selected_time2 = "11:\(minute)"
                cell.lbl_checkmark_breakfast_time.text = "11:\(minute)\(str_am!)"
                
            } else if (hour == "12") {
                
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
                
                self.str_selected_time2 = "24:\(minute)"
                cell.lbl_checkmark_breakfast_time.text = "12:\(minute)\(str_pm!)"
                
            } else {
                
                cell.lbl_checkmark_breakfast_time.text = selectedDate.dateString("HH:mm")
                self.str_selected_time = selectedDate.dateString("HH:mm")
                
            }
            
            print(self.str_selected_time as Any)
            
            self.set_reminder(get_full_time: self.str_selected_time)
            
        })
    }
    
    // morning snack
    @objc func morning_snack_time_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! track_meal_reminder_table_cell
        
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
        let cell = self.tble_view.cellForRow(at: indexPath) as! track_meal_reminder_table_cell
        
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
                
                self.str_selected_time_for_lunch = "24:\(minute)"
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
        let cell = self.tble_view.cellForRow(at: indexPath) as! track_meal_reminder_table_cell
        
        if (self.str_evening_snack_select == "0") {
            self.alert_custom(message: "Please enable evening snack")
            return
        }
        
        RPicker.selectDate(title: "Select Time", cancelText: "Cancel", datePickerMode: .time, didSelectDate: { (selectedDate) in
            // TODO: Your implementation for date
            // self.btn_select_time.setTitle(selectedDate.dateString("HH:mm"), for: .normal)
            cell.lbl_checkmark_evening_snack_time.text = selectedDate.dateString("HH:mm")
            self.str_selected_time_for_evening_snack = selectedDate.dateString("HH:mm")
            
            // print(self.str_selected_time_for_evening_snack as Any)
            
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
                
                self.str_selected_time_for_evening_snack = "24:\(minute)"
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
        let cell = self.tble_view.cellForRow(at: indexPath) as! track_meal_reminder_table_cell
        
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
                
                self.str_selected_time_for_dinner = "24:\(minute)"
                cell.lbl_checkmark_dinner_time.text = "12:\(minute)\(str_pm!)"
                
            } else {
                
                cell.lbl_checkmark_dinner_time.text = selectedDate.dateString("HH:mm")
                self.str_selected_time_for_dinner = selectedDate.dateString("HH:mm")
                
            }
            
        })
    }
    
    
    @objc func breakfast_checkmark_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! track_meal_reminder_table_cell
        
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
        let cell = self.tble_view.cellForRow(at: indexPath) as! track_meal_reminder_table_cell
        
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
        let cell = self.tble_view.cellForRow(at: indexPath) as! track_meal_reminder_table_cell
        
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
        let cell = self.tble_view.cellForRow(at: indexPath) as! track_meal_reminder_table_cell
        
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
        let cell = self.tble_view.cellForRow(at: indexPath) as! track_meal_reminder_table_cell
        
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
    
    
    @objc func complete_profile_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! track_meal_reminder_table_cell
        
        
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
    }
}


//MARK:- TABLE VIEW -
extension track_meal_reminder: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:track_meal_reminder_table_cell = tableView.dequeueReusableCell(withIdentifier: "track_meal_reminder_table_cell") as! track_meal_reminder_table_cell
        
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
        // cell.btn_food_prefrence.addTarget(self, action: #selector(food_prefrence_click_method), for: .touchUpInside)
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
        return 558
    }

}
