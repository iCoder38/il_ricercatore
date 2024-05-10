//
//  weight_reminder.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 09/05/24.
//

import UIKit

class weight_reminder: UIViewController, UNUserNotificationCenterDelegate {

    var lastScheduledBadgeCount = 0
    
    var str_day_count = 10
    var str_day_name = ""
    
    var int_yyyy:Int!
    var int_mm:Int!
    var int_dd:Int!
    
    var int_hr:Int!
    var int_min:Int!
    
    @IBOutlet weak var btn_menu:UIButton! {
        didSet {
            btn_menu.tintColor = .white
            btn_menu.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var lbl_navigation_title:UILabel! {
        didSet {
            lbl_navigation_title.text = "WEIGHT REMINDER"
            lbl_navigation_title.textColor = .white
        }
    }
    
    @IBOutlet weak var btn_remind_me_day_checkmark:UIButton! {
        didSet {
            btn_remind_me_day_checkmark.backgroundColor = .clear
            btn_remind_me_day_checkmark.tag = 0
            btn_remind_me_day_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
        }
    }
    @IBOutlet weak var btn_remind_me_day_time:UIButton! {
        didSet {
            btn_remind_me_day_time.backgroundColor = .systemGray5
            btn_remind_me_day_time.isUserInteractionEnabled = false
            btn_remind_me_day_time.layer.cornerRadius = 8
            btn_remind_me_day_time.clipsToBounds = true
        }
    }
    
    
    
    @IBOutlet weak var btn_remind_me_only_checkmark:UIButton! {
        didSet {
            btn_remind_me_only_checkmark.backgroundColor = .clear
            btn_remind_me_only_checkmark.tag = 0
            btn_remind_me_only_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
        }
    }
    @IBOutlet weak var btn_remind_me_only_date_time:UIButton! {
        didSet {
            btn_remind_me_only_date_time.backgroundColor = .systemGray5
            btn_remind_me_only_date_time.isUserInteractionEnabled = false
            btn_remind_me_only_date_time.layer.cornerRadius = 8
            btn_remind_me_only_date_time.clipsToBounds = true
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btn_remind_me_day_time.addTarget(self, action: #selector(remind_me_every), for: .touchUpInside)
        self.btn_remind_me_day_checkmark.addTarget(self, action: #selector(btn_remind_me_checkmark_click_method), for: .touchUpInside)
        
        
        
        self.btn_remind_me_only_checkmark.addTarget(self, action: #selector(remind_me_only), for: .touchUpInside)
        self.btn_remind_me_only_date_time.addTarget(self, action: #selector(btn_remind_me_only_d_t_click_method), for: .touchUpInside)
        
        
        
        
        requestNotificationAuthorization()
        UNUserNotificationCenter.current().delegate = self
        
        self.get_all_reminders_workout()
    }
    
    @objc func get_all_reminders_workout() {
        
        UNUserNotificationCenter.current().getPendingNotificationRequests { (requests) in
            print(requests)
            for request in requests {
                print("Identifier: \(request.identifier)")
                // print("Content: \(request.content)")
                print("Trigger: \(request.trigger)")
                // print("---------")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
                    if ("\(request.identifier)") == identifier_weight_reminder_remind_me_every_at {
                        
                        if let calendarTrigger = request.trigger as? UNCalendarNotificationTrigger {
                            let dateComponents = calendarTrigger.dateComponents
                            if let hour = dateComponents.hour, let minute = dateComponents.minute, let weekday = dateComponents.weekday {
                                
                                self.btn_remind_me_day_checkmark.tag = 1
                                self.btn_remind_me_day_checkmark.setImage(UIImage(named: "check"), for: .normal)
                                
                                self.btn_remind_me_day_time.backgroundColor = .systemPurple
                                self.btn_remind_me_day_time.isUserInteractionEnabled = true
                                
                                var day_name:String! = ""
                                
                                if "\(weekday)" == "1" {
                                    day_name = "Sunday"
                                } else if "\(weekday)" == "2" {
                                    day_name = "Monday"
                                } else if "\(weekday)" == "3" {
                                    day_name = "Tuesday"
                                } else if "\(weekday)" == "4" {
                                    day_name = "Wednesday"
                                } else if "\(weekday)" == "5" {
                                    day_name = "Thursday"
                                } else if "\(weekday)" == "6" {
                                    day_name = "Friday"
                                } else {
                                    day_name = "Saturday"
                                }
                                self.btn_remind_me_day_time.setTitle("\(day_name!) | "+self.convertTo12HourFormat(time: "\(hour):\(minute)")!, for: .normal)
                                
                                
                            }
                        }
                    }
                    
                    if ("\(request.identifier)") == identifier_weight_reminder_remind_me_only1 {
                        
                        if let calendarTrigger = request.trigger as? UNCalendarNotificationTrigger {
                            let dateComponents = calendarTrigger.dateComponents
                            if let hour = dateComponents.hour, let minute = dateComponents.minute {
                                
                                self.btn_remind_me_only_checkmark.tag = 1
                                self.btn_remind_me_only_checkmark.setImage(UIImage(named: "check"), for: .normal)
                                
                                self.btn_remind_me_only_date_time.backgroundColor = .systemPurple
                                self.btn_remind_me_only_date_time.isUserInteractionEnabled = true
                                
                                if let year = dateComponents.year, let month = dateComponents.month, let day = dateComponents.day {
                                    debugPrint("\(year)")
                                    debugPrint("\(month)")
                                    debugPrint("\(day)")
                                    
                                    self.btn_remind_me_only_date_time.setTitle("\(day)/\(month) | "+self.convertTo12HourFormat(time: "\(hour):\(minute)")!, for: .normal)
                                    
                                }
                                
                                
                                
                                
                            }
                        }
                    }
                }
            }
        }
    }
    
    @objc func remind_me_only() {
        if (self.btn_remind_me_only_checkmark.tag == 0) {
            self.btn_remind_me_only_checkmark.tag = 1
            self.btn_remind_me_only_checkmark.setImage(UIImage(named: "check"), for: .normal)
            
            self.btn_remind_me_only_date_time.backgroundColor = .systemPurple
            self.btn_remind_me_only_date_time.isUserInteractionEnabled = true
        } else {
            self.btn_remind_me_only_checkmark.tag = 0
            self.btn_remind_me_only_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
            
            self.btn_remind_me_only_date_time.backgroundColor = .systemGray5
            self.btn_remind_me_only_date_time.isUserInteractionEnabled = false
        }
    }
    
    @objc func btn_remind_me_only_d_t_click_method() {
        
        RPicker.selectDate(title: "Select date", cancelText: "Cancel", datePickerMode: .dateAndTime,minDate: Date.now, didSelectDate: { (selectedDate) in
            
            self.btn_remind_me_only_date_time.setTitle(selectedDate.dateStringCustommmm(), for: .normal)
            // print(selectedDate.dateString())
            
            let get_date = selectedDate.dateString2()
            // print(get_date)
            
            let get_time = selectedDate.dateString("hh:mm")
            // print(get_time)
            
            
            let separate_date = "\(get_date)".components(separatedBy: "-")
            debugPrint(separate_date[0]) // yyyy
            debugPrint(separate_date[1]) // mm
            debugPrint(separate_date[2]) // dd
            
            let separate_time = "\(get_time)".components(separatedBy: ":")
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
            
            print("HOUR ====> \(self.int_hr!)")
            print("MIN ==> \(self.int_min!)")
            
            print("YEAR ==> \(self.int_yyyy!)")
            print("MONTH ==> \(self.int_mm!)")
            print("DAY ==> \(self.int_dd!)")
            
            
            
            
            let content = UNMutableNotificationContent()
            content.title = local_notification_weight_reminder_header
            content.body = local_notification_weight_reminder_body
            content.sound = .default
            
            let dateComponents = DateComponents(year: self.int_yyyy, month: self.int_mm, day: self.int_dd, hour: self.int_hr, minute: self.int_min)
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let request = UNNotificationRequest(identifier: identifier_weight_reminder_remind_me_only1, content: content, trigger: trigger)
            
            
            UNUserNotificationCenter.current().add(request) { (error) in
                if let error = error {
                    print("Error scheduling notification: \(error.localizedDescription)")
                } else {
                    print("Notification scheduled successfully!")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        self.set_local_notification_toast(type: "Remind me", status: "enable")
                    }
                }
            }
            
        })
        
    }
    
    @objc func btn_remind_me_checkmark_click_method() {
        
        if (self.btn_remind_me_day_checkmark.tag == 0) {
            self.btn_remind_me_day_checkmark.tag = 1
            self.btn_remind_me_day_checkmark.setImage(UIImage(named: "check"), for: .normal)
            
            self.btn_remind_me_day_time.backgroundColor = .systemPurple
            self.btn_remind_me_day_time.isUserInteractionEnabled = true
        } else {
            self.btn_remind_me_day_checkmark.tag = 0
            self.btn_remind_me_day_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
            
            self.btn_remind_me_day_time.backgroundColor = .systemGray5
            self.btn_remind_me_day_time.isUserInteractionEnabled = false
            self.btn_remind_me_day_time.setTitle("N.A.", for: .normal)
            
            // disable reminder
            let center = UNUserNotificationCenter.current()
            center.removePendingNotificationRequests(withIdentifiers: [identifier_weight_reminder_remind_me_every_at])
            self.view.makeToast("Disabled: Remind me every")
        }
        
    }
    
    @objc func remind_me_every() {
        
        let actionSheet = NewYorkAlertController(title: "Select Day or Date", message: nil, style: .actionSheet)
        
        let sun = NewYorkButton(title: "Sunday", style: .default) { _ in
            
            self.str_day_count = day_sunday
            self.str_day_name = "Sunday"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.time_picker()
            }
        }
        
        let mon = NewYorkButton(title: "Monday", style: .default) { _ in
            
            self.str_day_count = day_monday
            self.str_day_name = "Monday"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.time_picker()
            }
        }
        
        let tue = NewYorkButton(title: "Tuesday", style: .default) { _ in
            
            self.str_day_count = day_tuesday
            self.str_day_name = "Tuesday"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.time_picker()
            }
        }
        
        let wed = NewYorkButton(title: "Wednesday", style: .default) { _ in
            
            self.str_day_count = day_wednesday
            self.str_day_name = "Wednesday"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.time_picker()
            }
        }
        
        let thu = NewYorkButton(title: "Thursday", style: .default) { _ in
            
            self.str_day_count = day_thursday
            self.str_day_name = "Thursday"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.time_picker()
            }
        }
        
        let fri = NewYorkButton(title: "Friday", style: .default) { _ in
            
            self.str_day_count = day_friday
            self.str_day_name = "Friday"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.time_picker()
            }
        }
        
        let sat = NewYorkButton(title: "Saturday", style: .default) { _ in
            
            self.str_day_count = day_saturday
            self.str_day_name = "Saturday"
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.time_picker()
            }
        }
        
        
        
        let cancel = NewYorkButton(title: "Cancel", style: .cancel)
        
        actionSheet.addButtons([sun,mon,tue,wed,thu,fri,sat, cancel])
        
        self.present(actionSheet, animated: true)
        
    }
    
    @objc func time_picker() {
        
        if (self.str_day_count == 10) {
            self.alert_custom(message: "Please enable")
            return
        }
        
        RPicker.selectDate(title: "Select Time", cancelText: "Cancel", datePickerMode: .time, didSelectDate: { (selectedDate) in
            
            var merge = String(self.str_day_name)+" | "+String(selectedDate.dateString("hh:mm a"))
            self.btn_remind_me_day_time.setTitle(String(merge), for: .normal)
            
            self.weekday_reminder(header: local_notification_weight_reminder_header,
                                  body: local_notification_weight_reminder_body,
                                  day: self.str_day_count,
                                  get_full_time: String(selectedDate.dateString("HH:mm")),
                                  identifier: identifier_weight_reminder_remind_me_every_at,
                                  type: self.str_day_name)
            
        })
        
        
        
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
