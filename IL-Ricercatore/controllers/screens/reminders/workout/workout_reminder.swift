//
//  workout_reminder.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 08/05/24.
//

import UIKit

class workout_reminder: UIViewController, UNUserNotificationCenterDelegate {

    var str_remind_me_every_at_status:String! = "0"
    var str_sunday_status:String! = "0"
    var str_monday_status:String! = "0"
    var str_wednesday_status:String! = "0"
    var str_thursday_status:String! = "0"
    var str_friday_status:String! = "0"
    var str_saturday_status:String! = "0"
    var str_tuesday_status:String! = "0"
    
    var str_selected_time:String! = ""
    
    var int_yyyy:Int!
    var int_mm:Int!
    var int_dd:Int!
    
    var int_hr:Int!
    var int_min:Int!
    
    var lastScheduledBadgeCount = 0
    
    @IBOutlet weak var btn_menu:UIButton! {
        didSet {
            btn_menu.tintColor = .white
            btn_menu.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var lbl_navigation_title:UILabel! {
        didSet {
            lbl_navigation_title.text = "WORKOUT REMINDER"
            lbl_navigation_title.textColor = .white
        }
    }
    
    @IBOutlet weak var tble_view:UITableView! {
        didSet {
            tble_view.delegate = self
            tble_view.dataSource = self
            tble_view.layer.cornerRadius = 0
            tble_view.clipsToBounds = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tble_view.reloadData()
        self.get_all_reminders_workout()
        requestNotificationAuthorization()
        UNUserNotificationCenter.current().delegate = self
    }
    
    @objc func get_all_reminders_workout() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! workout_reminders_table_cell
        
        UNUserNotificationCenter.current().getPendingNotificationRequests { (requests) in
            print(requests)
            for request in requests {
                 print("Identifier: \(request.identifier)")
                // print("Content: \(request.content)")
                 print("Trigger: \(request.trigger)")
                // print("---------")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
                    if ("\(request.identifier)") == identifier_meal_reminder_remind_me_every_at {
                        
                        if let calendarTrigger = request.trigger as? UNCalendarNotificationTrigger {
                            let dateComponents = calendarTrigger.dateComponents
                            if let hour = dateComponents.hour, let minute = dateComponents.minute {
                                
                                cell.btn_reminde_me_every_at_time.tag = 1
                                cell.btn_reminde_me_every_at_checkmark.tag = 1
                                cell.btn_reminde_me_every_at_checkmark.setImage(UIImage(named: "check"), for: .normal)
                                cell.btn_reminde_me_every_at_time.backgroundColor = .systemPurple
                                cell.btn_reminde_me_every_at_time.isUserInteractionEnabled = true
                                self.str_remind_me_every_at_status = "1"
                                cell.btn_reminde_me_every_at_time.setTitle(self.convertTo12HourFormat(time: "\(hour):\(minute)"), for: .normal)
                                
                                // action
                                cell.btn_reminde_me_every_at_time.addTarget(self, action: #selector(time_picker_remind_me_every_at), for: .touchUpInside)
                                
                            }
                           
                        }
                        
                        
                        
                    }
                    
                    // sunday
                    if ("\(request.identifier)") == identifier_meal_sunday {
                        
                        if let calendarTrigger = request.trigger as? UNCalendarNotificationTrigger {
                            let dateComponents = calendarTrigger.dateComponents
                            if let hour = dateComponents.hour, let minute = dateComponents.minute {
                                
                                cell.btn_sunday_time.tag = 1
                                cell.btn_sunday_checkmark.tag = 1
                                cell.btn_sunday_checkmark.setImage(UIImage(named: "check"), for: .normal)
                                cell.btn_sunday_time.backgroundColor = .systemPurple
                                cell.btn_sunday_time.isUserInteractionEnabled = true
                                self.str_sunday_status = "1"
                                cell.btn_sunday_time.setTitle(self.convertTo12HourFormat(time: "\(hour):\(minute)"), for: .normal)
                                
                                // action
                                cell.btn_sunday_time.addTarget(self, action: #selector(time_picker_sunday), for: .touchUpInside)
                                
                            }
                        }
                    }
                    
                    // monday
                   
                    if ("\(request.identifier)") == identifier_meal_monday {
                        
                        if let calendarTrigger = request.trigger as? UNCalendarNotificationTrigger {
                            let dateComponents = calendarTrigger.dateComponents
                            if let hour = dateComponents.hour, let minute = dateComponents.minute {
                                
                                cell.btn_monday_time.tag = 1
                                cell.btn_monday_checkmark.tag = 1
                                cell.btn_monday_checkmark.setImage(UIImage(named: "check"), for: .normal)
                                cell.btn_monday_time.backgroundColor = .systemPurple
                                cell.btn_monday_time.isUserInteractionEnabled = true
                                self.str_monday_status = "1"
                                cell.btn_monday_time.setTitle(self.convertTo12HourFormat(time: "\(hour):\(minute)"), for: .normal)
                                
                                // action
                                cell.btn_monday_time.addTarget(self, action: #selector(time_picker_monday), for: .touchUpInside)
                                
                            }
                        }
                    }
                    
                    // tuesday
                   
                    if ("\(request.identifier)") == identifier_meal_tuesday {
                        
                        if let calendarTrigger = request.trigger as? UNCalendarNotificationTrigger {
                            let dateComponents = calendarTrigger.dateComponents
                            if let hour = dateComponents.hour, let minute = dateComponents.minute {
                                
                                cell.btn_tuesday_time.tag = 1
                                cell.btn_tuesday_checkmark.tag = 1
                                cell.btn_tuesday_checkmark.setImage(UIImage(named: "check"), for: .normal)
                                cell.btn_tuesday_time.backgroundColor = .systemPurple
                                cell.btn_tuesday_time.isUserInteractionEnabled = true
                                self.str_tuesday_status = "1"
                                cell.btn_tuesday_time.setTitle(self.convertTo12HourFormat(time: "\(hour):\(minute)"), for: .normal)
                                
                                // action
                                cell.btn_tuesday_time.addTarget(self, action: #selector(time_picker_tuesday), for: .touchUpInside)
                                
                            }
                        }
                    }
                    
                    // wednesday
                    if ("\(request.identifier)") == identifier_meal_wednesday {
                        
                        if let calendarTrigger = request.trigger as? UNCalendarNotificationTrigger {
                            let dateComponents = calendarTrigger.dateComponents
                            if let hour = dateComponents.hour, let minute = dateComponents.minute {
                                
                                cell.btn_wednesday_time.tag = 1
                                cell.btn_wednesday_checkmark.tag = 1
                                cell.btn_wednesday_checkmark.setImage(UIImage(named: "check"), for: .normal)
                                cell.btn_wednesday_time.backgroundColor = .systemPurple
                                cell.btn_wednesday_time.isUserInteractionEnabled = true
                                self.str_wednesday_status = "1"
                                cell.btn_wednesday_time.setTitle(self.convertTo12HourFormat(time: "\(hour):\(minute)"), for: .normal)
                                
                                // action
                                cell.btn_wednesday_time.addTarget(self, action: #selector(time_picker_wednesday), for: .touchUpInside)
                                
                            }
                        }
                    }
                    
                    // thursday
                    if ("\(request.identifier)") == identifier_meal_thursday {
                        
                        if let calendarTrigger = request.trigger as? UNCalendarNotificationTrigger {
                            let dateComponents = calendarTrigger.dateComponents
                            if let hour = dateComponents.hour, let minute = dateComponents.minute {
                                
                                cell.btn_thursday_time.tag = 1
                                cell.btn_thursday_checkmark.tag = 1
                                cell.btn_thursday_checkmark.setImage(UIImage(named: "check"), for: .normal)
                                cell.btn_thursday_time.backgroundColor = .systemPurple
                                cell.btn_thursday_time.isUserInteractionEnabled = true
                                self.str_thursday_status = "1"
                                cell.btn_thursday_time.setTitle(self.convertTo12HourFormat(time: "\(hour):\(minute)"), for: .normal)
                                
                                // action
                                cell.btn_thursday_time.addTarget(self, action: #selector(time_picker_thursday), for: .touchUpInside)
                                
                            }
                        }
                    }
                    
                    // friday
                    if ("\(request.identifier)") == identifier_meal_friday {
                        
                        if let calendarTrigger = request.trigger as? UNCalendarNotificationTrigger {
                            let dateComponents = calendarTrigger.dateComponents
                            if let hour = dateComponents.hour, let minute = dateComponents.minute {
                                
                                cell.btn_friday_time.tag = 1
                                cell.btn_friday_checkmark.tag = 1
                                cell.btn_friday_checkmark.setImage(UIImage(named: "check"), for: .normal)
                                cell.btn_friday_time.backgroundColor = .systemPurple
                                cell.btn_friday_time.isUserInteractionEnabled = true
                                self.str_friday_status = "1"
                                cell.btn_friday_time.setTitle(self.convertTo12HourFormat(time: "\(hour):\(minute)"), for: .normal)
                                
                                // action
                                cell.btn_friday_time.addTarget(self, action: #selector(time_picker_friday), for: .touchUpInside)
                                
                            }
                        }
                    }
                    
                    // saturday
                    if ("\(request.identifier)") == identifier_meal_saturday {
                        
                        if let calendarTrigger = request.trigger as? UNCalendarNotificationTrigger {
                            let dateComponents = calendarTrigger.dateComponents
                            if let hour = dateComponents.hour, let minute = dateComponents.minute {
                                
                                cell.btn_saturday_time.tag = 1
                                cell.btn_saturday_checkmark.tag = 1
                                cell.btn_saturday_checkmark.setImage(UIImage(named: "check"), for: .normal)
                                cell.btn_saturday_time.backgroundColor = .systemPurple
                                cell.btn_saturday_time.isUserInteractionEnabled = true
                                self.str_saturday_status = "1"
                                cell.btn_saturday_time.setTitle(self.convertTo12HourFormat(time: "\(hour):\(minute)"), for: .normal)
                                
                                // action
                                cell.btn_saturday_time.addTarget(self, action: #selector(time_picker_saturday), for: .touchUpInside)
                                
                            }
                        }
                    }
                    
                    
                    
                    
                    
                }
            }
        }
    }
    
    @objc func disable_all_days() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! workout_reminders_table_cell
        
        // disable all days
        cell.btn_sunday_time.tag = 0
        cell.btn_sunday_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
        cell.btn_sunday_time.backgroundColor = .systemGray5
        cell.btn_sunday_time.isUserInteractionEnabled = false
        cell.btn_sunday_time.setTitle("disable", for: .normal)
        self.str_sunday_status = "0"
        
        cell.btn_monday_time.tag = 0
        cell.btn_monday_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
        cell.btn_monday_time.backgroundColor = .systemGray5
        cell.btn_monday_time.isUserInteractionEnabled = false
        cell.btn_monday_time.setTitle("disable", for: .normal)
        self.str_monday_status = "0"
        
        cell.btn_tuesday_time.tag = 0
        cell.btn_tuesday_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
        cell.btn_tuesday_time.backgroundColor = .systemGray5
        cell.btn_tuesday_time.isUserInteractionEnabled = false
        cell.btn_tuesday_time.setTitle("disable", for: .normal)
        self.str_tuesday_status = "0"
        
        
        cell.btn_wednesday_time.tag = 0
        cell.btn_wednesday_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
        cell.btn_wednesday_time.backgroundColor = .systemGray5
        cell.btn_wednesday_time.isUserInteractionEnabled = false
        cell.btn_wednesday_time.setTitle("disable", for: .normal)
        self.str_wednesday_status = "0"
        
        
        cell.btn_thursday_time.tag = 0
        cell.btn_thursday_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
        cell.btn_thursday_time.backgroundColor = .systemGray5
        cell.btn_thursday_time.isUserInteractionEnabled = false
        cell.btn_thursday_time.setTitle("disable", for: .normal)
        self.str_thursday_status = "0"
        
        
        cell.btn_friday_time.tag = 0
        cell.btn_friday_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
        cell.btn_friday_time.backgroundColor = .systemGray5
        cell.btn_friday_time.isUserInteractionEnabled = false
        cell.btn_friday_time.setTitle("disable", for: .normal)
        self.str_friday_status = "0"
        
        cell.btn_saturday_time.tag = 0
        cell.btn_saturday_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
        cell.btn_saturday_time.backgroundColor = .systemGray5
        cell.btn_saturday_time.isUserInteractionEnabled = false
        cell.btn_saturday_time.setTitle("disable", for: .normal)
        self.str_saturday_status = "0"
        
        // disable reminder
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [identifier_meal_sunday,
                                                                   identifier_meal_monday,
                                                                   identifier_meal_tuesday,
                                                                   identifier_meal_wednesday,
                                                                   identifier_meal_thursday,
                                                                   identifier_meal_friday,
                                                                   identifier_meal_saturday])
        self.view.makeToast("All weekdays notifications are cleared")
    }
    
    @objc func disbale_remind_me_every_at() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! workout_reminders_table_cell
        
        // disable remind me every
        cell.btn_reminde_me_every_at_time.tag = 0
        cell.btn_reminde_me_every_at_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
        cell.btn_reminde_me_every_at_time.backgroundColor = .systemGray5
        cell.btn_reminde_me_every_at_time.isUserInteractionEnabled = false
        cell.btn_reminde_me_every_at_time.setTitle("disable", for: .normal)
        self.str_remind_me_every_at_status = "0"
        
        // disable reminder remind me at
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [identifier_meal_reminder_remind_me_every_at])
    }
    
    @objc func remind_me_every_at_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! workout_reminders_table_cell
        
        if (cell.btn_reminde_me_every_at_time.tag == 0) {
            cell.btn_reminde_me_every_at_time.tag = 1
            cell.btn_reminde_me_every_at_checkmark.setImage(UIImage(named: "check"), for: .normal)
            cell.btn_reminde_me_every_at_time.backgroundColor = .systemPurple
            cell.btn_reminde_me_every_at_time.isUserInteractionEnabled = true
            cell.btn_reminde_me_every_at_time.setTitle("select", for: .normal)
            self.str_remind_me_every_at_status = "1"
            // action
            cell.btn_reminde_me_every_at_time.addTarget(self, action: #selector(time_picker_remind_me_every_at), for: .touchUpInside)
            
            // disable all days
            self.disable_all_days()
            
            
        } else {
            cell.btn_reminde_me_every_at_time.tag = 0
            cell.btn_reminde_me_every_at_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
            cell.btn_reminde_me_every_at_time.backgroundColor = .systemGray5
            cell.btn_reminde_me_every_at_time.isUserInteractionEnabled = false
            cell.btn_reminde_me_every_at_time.setTitle("disable", for: .normal)
            self.str_remind_me_every_at_status = "0"
            
            // disable reminder
            self.disable_reminder(identifier: identifier_meal_reminder_remind_me_every_at, text: type_workout_remind_me_every_at)
        }
        
    }
    @objc func time_picker_remind_me_every_at() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! workout_reminders_table_cell
        
        if (self.str_remind_me_every_at_status == "0") {
            self.alert_custom(message: "Please enable")
            return
        }
        
        RPicker.selectDate(title: "Select Time", cancelText: "Cancel", datePickerMode: .time, didSelectDate: { (selectedDate) in
            cell.btn_reminde_me_every_at_time.setTitle(selectedDate.dateString("hh:mm a"), for: .normal)
            self.str_selected_time = selectedDate.dateString("HH:mm")
            
            
            
            self.open_custom_day(header: local_notification_workout_reminder_header,
                                 body: local_notification_workout_reminder_body,
                                 identifier: identifier_meal_reminder_remind_me_every_at,
                                 time: String(self.str_selected_time),
                                 type: type_workout_remind_me_every_at)
        })
        
    }
    
    // sunday
    @objc func sunday_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! workout_reminders_table_cell
        
        if (cell.btn_sunday_time.tag == 0) {
            
            // disable remind me every at
            self.disbale_remind_me_every_at()
            
            
            cell.btn_sunday_time.tag = 1
            cell.btn_sunday_checkmark.setImage(UIImage(named: "check"), for: .normal)
            cell.btn_sunday_time.backgroundColor = .systemPurple
            cell.btn_sunday_time.isUserInteractionEnabled = true
            cell.btn_sunday_time.setTitle("select", for: .normal)
            self.str_sunday_status = "1"
            // action
            cell.btn_sunday_time.addTarget(self, action: #selector(time_picker_sunday), for: .touchUpInside)
            
        } else {
            cell.btn_sunday_time.tag = 0
            cell.btn_sunday_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
            cell.btn_sunday_time.backgroundColor = .systemGray5
            cell.btn_sunday_time.isUserInteractionEnabled = false
            cell.btn_sunday_time.setTitle("disable", for: .normal)
            self.str_sunday_status = "0"
            
            // disable reminder
            self.disable_reminder(identifier: identifier_meal_sunday, text: type_sunday)
        }
    }
    
    @objc func time_picker_sunday() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! workout_reminders_table_cell
        
        
        //
        if (self.str_sunday_status == "0") {
            self.alert_custom(message: "Please enable")
            return
        }
        
        RPicker.selectDate(title: "Select Time", cancelText: "Cancel", datePickerMode: .time, didSelectDate: { (selectedDate) in
            cell.btn_sunday_time.setTitle(selectedDate.dateString("hh:mm a"), for: .normal)
            self.str_selected_time = selectedDate.dateString("HH:mm")
            
            
            self.weekday_reminder(header: local_notification_workout_reminder_header,
                                  body: local_notification_workout_reminder_body,
                                  day: day_sunday,
                                  get_full_time: String(self.str_selected_time),
                                  identifier: identifier_meal_sunday,
                                  type: type_sunday)
            
        })
        
    }
    
    // monday
    @objc func monday_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! workout_reminders_table_cell
        
        if (cell.btn_monday_time.tag == 0) {
            
            // disable remind me every at
            self.disbale_remind_me_every_at()
            
            cell.btn_monday_time.tag = 1
            cell.btn_monday_checkmark.setImage(UIImage(named: "check"), for: .normal)
            cell.btn_monday_time.backgroundColor = .systemPurple
            cell.btn_monday_time.isUserInteractionEnabled = true
            cell.btn_monday_time.setTitle("select", for: .normal)
            self.str_monday_status = "1"
            // action
            cell.btn_monday_time.addTarget(self, action: #selector(time_picker_monday), for: .touchUpInside)
            
        } else {
            cell.btn_monday_time.tag = 0
            cell.btn_monday_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
            cell.btn_monday_time.backgroundColor = .systemGray5
            cell.btn_monday_time.isUserInteractionEnabled = false
            cell.btn_monday_time.setTitle("disable", for: .normal)
            self.str_monday_status = "0"
            
            // disable reminder
            self.disable_reminder(identifier: identifier_meal_monday, text: type_monday)
        }
    }
    
    @objc func time_picker_monday() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! workout_reminders_table_cell
        
        
        //
        if (self.str_monday_status == "0") {
            self.alert_custom(message: "Please enable")
            return
        }
        
        RPicker.selectDate(title: "Select Time", cancelText: "Cancel", datePickerMode: .time, didSelectDate: { (selectedDate) in
            cell.btn_monday_time.setTitle(selectedDate.dateString("hh:mm a"), for: .normal)
            self.str_selected_time = selectedDate.dateString("HH:mm")
            
            
            self.weekday_reminder(header: local_notification_workout_reminder_header,
                                  body: local_notification_workout_reminder_body,
                                  day: day_monday,
                                  get_full_time: String(self.str_selected_time),
                                  identifier: identifier_meal_monday,
                                  type: type_monday)
            
        })
        
    }
    
    
    // tuesday
    @objc func tuesday_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! workout_reminders_table_cell
        
        if (cell.btn_tuesday_time.tag == 0) {
            
            // disable remind me every
            cell.btn_tuesday_time.tag = 0
            cell.btn_tuesday_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
            cell.btn_tuesday_time.backgroundColor = .systemGray5
            cell.btn_tuesday_time.isUserInteractionEnabled = false
            cell.btn_tuesday_time.setTitle("disable", for: .normal)
            self.str_tuesday_status = "0"
            
            // disable remind me every at
            self.disbale_remind_me_every_at()
            
            cell.btn_tuesday_time.tag = 1
            cell.btn_tuesday_checkmark.setImage(UIImage(named: "check"), for: .normal)
            cell.btn_tuesday_time.backgroundColor = .systemPurple
            cell.btn_tuesday_time.isUserInteractionEnabled = true
            cell.btn_tuesday_time.setTitle("select", for: .normal)
            self.str_tuesday_status = "1"
            // action
            cell.btn_tuesday_time.addTarget(self, action: #selector(time_picker_tuesday), for: .touchUpInside)
            
        } else {
            cell.btn_tuesday_time.tag = 0
            cell.btn_tuesday_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
            cell.btn_tuesday_time.backgroundColor = .systemGray5
            cell.btn_tuesday_time.isUserInteractionEnabled = false
            cell.btn_tuesday_time.setTitle("disable", for: .normal)
            self.str_tuesday_status = "0"
            
            // disable reminder
            self.disable_reminder(identifier: identifier_meal_tuesday, text: type_tuesday)
        }
    }
    
    @objc func time_picker_tuesday() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! workout_reminders_table_cell
        
        
        //
        if (self.str_tuesday_status == "0") {
            self.alert_custom(message: "Please enable")
            return
        }
        
        RPicker.selectDate(title: "Select Time", cancelText: "Cancel", datePickerMode: .time, didSelectDate: { (selectedDate) in
            cell.btn_tuesday_time.setTitle(selectedDate.dateString("hh:mm a"), for: .normal)
            self.str_selected_time = selectedDate.dateString("HH:mm")
            
            
            self.weekday_reminder(header: local_notification_workout_reminder_header,
                                  body: local_notification_workout_reminder_body,
                                  day: day_tuesday,
                                  get_full_time: String(self.str_selected_time),
                                  identifier: identifier_meal_tuesday,
                                  type: type_tuesday)
            
        })
        
    }
    
    // wednesday
    @objc func wednesday_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! workout_reminders_table_cell
        
        if (cell.btn_wednesday_time.tag == 0) {
            
            // disable remind me every
            cell.btn_wednesday_time.tag = 0
            cell.btn_wednesday_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
            cell.btn_wednesday_time.backgroundColor = .systemGray5
            cell.btn_wednesday_time.isUserInteractionEnabled = false
            cell.btn_wednesday_time.setTitle("disable", for: .normal)
            self.str_wednesday_status = "0"
            
            // disable remind me every at
            self.disbale_remind_me_every_at()
            
            cell.btn_wednesday_time.tag = 1
            cell.btn_wednesday_checkmark.setImage(UIImage(named: "check"), for: .normal)
            cell.btn_wednesday_time.backgroundColor = .systemPurple
            cell.btn_wednesday_time.isUserInteractionEnabled = true
            cell.btn_wednesday_time.setTitle("select", for: .normal)
            self.str_wednesday_status = "1"
            // action
            cell.btn_wednesday_time.addTarget(self, action: #selector(time_picker_wednesday), for: .touchUpInside)
            
        } else {
            cell.btn_wednesday_time.tag = 0
            cell.btn_wednesday_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
            cell.btn_wednesday_time.backgroundColor = .systemGray5
            cell.btn_wednesday_time.isUserInteractionEnabled = false
            cell.btn_wednesday_time.setTitle("disable", for: .normal)
            self.str_wednesday_status = "0"
            
            // disable reminder
            self.disable_reminder(identifier: identifier_meal_wednesday, text: type_wednesday)
        }
    }
    
    @objc func time_picker_wednesday() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! workout_reminders_table_cell
        
        
        //
        if (self.str_wednesday_status == "0") {
            self.alert_custom(message: "Please enable")
            return
        }
        
        RPicker.selectDate(title: "Select Time", cancelText: "Cancel", datePickerMode: .time, didSelectDate: { (selectedDate) in
            cell.btn_wednesday_time.setTitle(selectedDate.dateString("hh:mm a"), for: .normal)
            self.str_selected_time = selectedDate.dateString("HH:mm")
            
            
            self.weekday_reminder(header: local_notification_workout_reminder_header,
                                  body: local_notification_workout_reminder_body,
                                  day: day_wednesday,
                                  get_full_time: String(self.str_selected_time),
                                  identifier: identifier_meal_wednesday,
                                  type: type_wednesday)
            
        })
        
    }
    
    // thursday
    @objc func thursday_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! workout_reminders_table_cell
        
        if (cell.btn_thursday_time.tag == 0) {
            
            // disable remind me every
            cell.btn_thursday_time.tag = 0
            cell.btn_thursday_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
            cell.btn_thursday_time.backgroundColor = .systemGray5
            cell.btn_thursday_time.isUserInteractionEnabled = false
            cell.btn_thursday_time.setTitle("disable", for: .normal)
            self.str_thursday_status = "0"
            
            // disable remind me every at
            self.disbale_remind_me_every_at()
            
            cell.btn_thursday_time.tag = 1
            cell.btn_thursday_checkmark.setImage(UIImage(named: "check"), for: .normal)
            cell.btn_thursday_time.backgroundColor = .systemPurple
            cell.btn_thursday_time.isUserInteractionEnabled = true
            cell.btn_thursday_time.setTitle("select", for: .normal)
            self.str_thursday_status = "1"
            // action
            cell.btn_thursday_time.addTarget(self, action: #selector(time_picker_thursday), for: .touchUpInside)
            
        } else {
            cell.btn_thursday_time.tag = 0
            cell.btn_thursday_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
            cell.btn_thursday_time.backgroundColor = .systemGray5
            cell.btn_thursday_time.isUserInteractionEnabled = false
            cell.btn_thursday_time.setTitle("disable", for: .normal)
            self.str_thursday_status = "0"
            
            // disable reminder
            self.disable_reminder(identifier: identifier_meal_thursday, text: type_thursday)
        }
    }
    
    @objc func time_picker_thursday() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! workout_reminders_table_cell
        
        
        //
        if (self.str_thursday_status == "0") {
            self.alert_custom(message: "Please enable")
            return
        }
        
        RPicker.selectDate(title: "Select Time", cancelText: "Cancel", datePickerMode: .time, didSelectDate: { (selectedDate) in
            cell.btn_thursday_time.setTitle(selectedDate.dateString("hh:mm a"), for: .normal)
            self.str_selected_time = selectedDate.dateString("HH:mm")
            
            
            self.weekday_reminder(header: local_notification_workout_reminder_header,
                                  body: local_notification_workout_reminder_body,
                                  day: day_thursday,
                                  get_full_time: String(self.str_selected_time),
                                  identifier: identifier_meal_thursday,
                                  type: type_thursday)
            
        })
        
    }
    // friday
    @objc func friday_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! workout_reminders_table_cell
        
        if (cell.btn_friday_time.tag == 0) {
            
            // disable remind me every
            cell.btn_friday_time.tag = 0
            cell.btn_friday_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
            cell.btn_friday_time.backgroundColor = .systemGray5
            cell.btn_friday_time.isUserInteractionEnabled = false
            cell.btn_friday_time.setTitle("disable", for: .normal)
            self.str_friday_status = "0"
            
            // disable remind me every at
            self.disbale_remind_me_every_at()
            
            cell.btn_friday_time.tag = 1
            cell.btn_friday_checkmark.setImage(UIImage(named: "check"), for: .normal)
            cell.btn_friday_time.backgroundColor = .systemPurple
            cell.btn_friday_time.isUserInteractionEnabled = true
            cell.btn_friday_time.setTitle("select", for: .normal)
            self.str_friday_status = "1"
            // action
            cell.btn_friday_time.addTarget(self, action: #selector(time_picker_friday), for: .touchUpInside)
            
        } else {
            cell.btn_friday_time.tag = 0
            cell.btn_friday_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
            cell.btn_friday_time.backgroundColor = .systemGray5
            cell.btn_friday_time.isUserInteractionEnabled = false
            cell.btn_friday_time.setTitle("disable", for: .normal)
            self.str_friday_status = "0"
            
            // disable reminder
            self.disable_reminder(identifier: identifier_meal_friday, text: type_friday)
        }
    }
    
    @objc func time_picker_friday() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! workout_reminders_table_cell
        
        
        //
        if (self.str_friday_status == "0") {
            self.alert_custom(message: "Please enable")
            return
        }
        
        RPicker.selectDate(title: "Select Time", cancelText: "Cancel", datePickerMode: .time, didSelectDate: { (selectedDate) in
            cell.btn_friday_time.setTitle(selectedDate.dateString("hh:mm a"), for: .normal)
            self.str_selected_time = selectedDate.dateString("HH:mm")
            
            
            self.weekday_reminder(header: local_notification_workout_reminder_header,
                                  body: local_notification_workout_reminder_body,
                                  day: day_friday,
                                  get_full_time: String(self.str_selected_time),
                                  identifier: identifier_meal_friday,
                                  type: type_friday)
            
        })
        
    }
    
    // saturday
    @objc func saturday_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! workout_reminders_table_cell
        
        if (cell.btn_saturday_time.tag == 0) {
            
            // disable remind me every
            cell.btn_saturday_time.tag = 0
            cell.btn_saturday_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
            cell.btn_saturday_time.backgroundColor = .systemGray5
            cell.btn_saturday_time.isUserInteractionEnabled = false
            cell.btn_saturday_time.setTitle("disable", for: .normal)
            self.str_saturday_status = "0"
            
            // disable remind me every at
            self.disbale_remind_me_every_at()
            
            cell.btn_saturday_time.tag = 1
            cell.btn_saturday_checkmark.setImage(UIImage(named: "check"), for: .normal)
            cell.btn_saturday_time.backgroundColor = .systemPurple
            cell.btn_saturday_time.isUserInteractionEnabled = true
            cell.btn_saturday_time.setTitle("select", for: .normal)
            self.str_saturday_status = "1"
            // action
            cell.btn_saturday_time.addTarget(self, action: #selector(time_picker_saturday), for: .touchUpInside)
            
        } else {
            cell.btn_saturday_time.tag = 0
            cell.btn_saturday_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
            cell.btn_saturday_time.backgroundColor = .systemGray5
            cell.btn_saturday_time.isUserInteractionEnabled = false
            cell.btn_saturday_time.setTitle("disable", for: .normal)
            self.str_saturday_status = "0"
            
            // disable reminder
            self.disable_reminder(identifier: identifier_meal_saturday, text: type_saturday)
        }
    }
    
    @objc func time_picker_saturday() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! workout_reminders_table_cell
        
        if (self.str_saturday_status == "0") {
            self.alert_custom(message: "Please enable")
            return
        }
        
        RPicker.selectDate(title: "Select Time", cancelText: "Cancel", datePickerMode: .time, didSelectDate: { (selectedDate) in
            cell.btn_saturday_time.setTitle(selectedDate.dateString("hh:mm a"), for: .normal)
            self.str_selected_time = selectedDate.dateString("HH:mm")
            
            
            self.weekday_reminder(header: local_notification_workout_reminder_header,
                                  body: local_notification_workout_reminder_body,
                                  day: day_saturday,
                                  get_full_time: String(self.str_selected_time),
                                  identifier: identifier_meal_saturday,
                                  type: type_saturday)
            
        })
        
    }
    
    
    
    // every day reminder setup
    @objc func set_reminder_everyday(set_header:String,set_body:String,set_identifier:String,get_full_time:String,type:String) {
         print(get_full_time as Any)
        
        let separate_time = "\(get_full_time)".components(separatedBy: ":")
        debugPrint(separate_time.count as Any)
        debugPrint(separate_time as Any)
        
        let hr = separate_time[0]
        if (hr == ""){
            return
        }
        let min = separate_time[1]
        
        self.int_hr = Int(hr)
        self.int_min = Int(min)
        
        let content = UNMutableNotificationContent()
        content.title = set_header
        content.body = set_body
        content.sound = .default
        
        let center = UNUserNotificationCenter.current()
        // center.removeAllPendingNotificationRequests()
        
        var dateComponents = DateComponents()
        dateComponents.hour = self.int_hr
        dateComponents.minute = self.int_min
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: set_identifier, content: content, trigger: trigger)
        // center.add(request)
        
        // Add the request to the notification center
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.view.makeToast("Error scheduling notification: \(error.localizedDescription)")
                }
            } else {
                print("Notification scheduled successfully!")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    self.set_local_notification_toast(type: type, status: "e")
                }
                // self.updateBadgeCount()
            }
        }
        
        /*self.scheduleDailyReminder(hour: self.int_hr,
                                   minute: self.int_min,
                                   header: set_header,
                                   body: set_body,
                                   identifier: set_identifier, text: type)*/
    }
    @objc func set_reminder_custom_day_time(set_header:String,set_body:String,set_identifier:String,get_full_time:String,get_full_date:String,type:String) {
        // print(get_full_date as Any)
        // print(get_full_time as Any)
        
        let separate_date = "\(get_full_date)".components(separatedBy: "-")
        // debugPrint(separate_date[0]) // yyyy
        // debugPrint(separate_date[1]) // mm
        // debugPrint(separate_date[2]) // dd
        
        let separate_time = "\(get_full_time)".components(separatedBy: ":")
        // debugPrint(separate_time.count as Any)
        // debugPrint(separate_time as Any)
        
        let yyyy = separate_date[0]
        let mm = separate_date[1]
        let dd = separate_date[2]
        
        let hr = separate_time[0]
        if (hr == ""){
            return
        }
        let min = separate_time[1]
        
        self.int_hr = Int(hr)
        self.int_min = Int(min)
        
        self.int_yyyy = Int(yyyy)
        self.int_mm = Int(mm)
        self.int_dd = Int(dd)
        
        self.scheduleReminderCustomDayAndTime(for: self.int_yyyy,
                                              month: self.int_mm,
                                              day: self.int_dd,
                                              hour: self.int_hr,
                                              minute: self.int_min,
                                              identifier: set_identifier,
                                              type: type)
    }
    
    // dynamic
    @objc func open_custom_day(header:String,body:String,identifier:String,time:String,type:String) {
     
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.set_reminder_everyday(set_header: header,
                                       set_body: body,
                                       set_identifier: identifier,
                                       get_full_time: time,
                                       type: type)
        }
        
        /*DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let actionSheet = NewYorkAlertController(title: "Select Day or Date", message: nil, style: .actionSheet)
            
            let cameraa = NewYorkButton(title: "Every day", style: .default) { _ in
                self.set_reminder_everyday(set_header: header,
                                  set_body: body,
                                  set_identifier: identifier,
                                  get_full_time: time,
                                  type: type)
                
                // refresh
                self.get_all_reminders_workout()
            }
            
            let gallery = NewYorkButton(title: "Custom date", style: .default) { _ in
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    RPicker.selectDate(title: "Select date", cancelText: "Cancel", datePickerMode: .date,minDate: Date.now, didSelectDate: { (selectedDate) in
                        
                        self.set_reminder_custom_day_time(set_header: header,
                                                          set_body: body,
                                                          set_identifier: identifier,
                                                          get_full_time: time,
                                                          get_full_date: selectedDate.dateString("yyyy-MM-dd"),
                                                          type: type)
                        
                        // refresh
                        self.get_all_reminders_workout()
                       
                    })
                    
                }
            }
            
            let cancel = NewYorkButton(title: "Cancel", style: .cancel)
            
            actionSheet.addButtons([cameraa, gallery, cancel])
            
            self.present(actionSheet, animated: true)
        }*/
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
    
    
    
}

//MARK:- TABLE VIEW -
extension workout_reminder: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:workout_reminders_table_cell = tableView.dequeueReusableCell(withIdentifier: "workout_reminders_table_cell") as! workout_reminders_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
         
        cell.btn_reminde_me_every_at_checkmark.tag = 0
        cell.btn_reminde_me_every_at_checkmark.addTarget(self, action: #selector(remind_me_every_at_click_method), for: .touchUpInside)
        
        
        cell.btn_sunday_checkmark.tag = 0
        cell.btn_sunday_checkmark.addTarget(self, action: #selector(sunday_click_method), for: .touchUpInside)
        
        cell.btn_monday_checkmark.tag = 0
        cell.btn_monday_checkmark.addTarget(self, action: #selector(monday_click_method), for: .touchUpInside)
        
        cell.btn_tuesday_checkmark.tag = 0
        cell.btn_tuesday_checkmark.addTarget(self, action: #selector(tuesday_click_method), for: .touchUpInside)
        
        cell.btn_wednesday_checkmark.tag = 0
        cell.btn_wednesday_checkmark.addTarget(self, action: #selector(wednesday_click_method), for: .touchUpInside)
        
        cell.btn_thursday_checkmark.tag = 0
        cell.btn_thursday_checkmark.addTarget(self, action: #selector(thursday_click_method), for: .touchUpInside)
        
        cell.btn_friday_checkmark.tag = 0
        cell.btn_friday_checkmark.addTarget(self, action: #selector(friday_click_method), for: .touchUpInside)
        
        cell.btn_saturday_checkmark.tag = 0
        cell.btn_saturday_checkmark.addTarget(self, action: #selector(saturday_click_method), for: .touchUpInside)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
       
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 324
    }

}
