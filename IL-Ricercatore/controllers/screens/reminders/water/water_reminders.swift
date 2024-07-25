//
//  water_reminders.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 06/05/24.
//

import UIKit
import UserNotifications

class water_reminders: UIViewController, UNUserNotificationCenterDelegate {
    
    var str_users_select_type = "1"
    
    @IBOutlet weak var btn_menu:UIButton! {
        didSet {
            btn_menu.tintColor = .white
            btn_menu.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var lbl_navigation_title:UILabel! {
        didSet {
            lbl_navigation_title.text = "WATER REMINDER"
            lbl_navigation_title.textColor = .white
        }
    }
    
    @IBOutlet weak var btn_one:UIButton! {
        didSet {
            btn_one.layer.cornerRadius = 17
            btn_one.clipsToBounds = true
            btn_one.backgroundColor = .systemGray5
        }
    }
    @IBOutlet weak var btn_two:UIButton!  {
        didSet {
            btn_two.layer.cornerRadius = 17
            btn_two.clipsToBounds = true
            btn_two.backgroundColor = .systemGray5
        }
    }
    @IBOutlet weak var btn_three:UIButton!  {
        didSet {
            btn_three.layer.cornerRadius = 17
            btn_three.clipsToBounds = true
            btn_three.backgroundColor = .systemGray5
        }
    }
    
    @IBOutlet weak var lbl_text_one:UILabel! {
        didSet {
            lbl_text_one.text = "From time"
        }
    }
    @IBOutlet weak var lbl_text_two:UILabel! {
        didSet {
            lbl_text_two.text = "To time"
        }
    }
    
    @IBOutlet weak var view_one:UIView! {
        didSet {
            view_one.layer.cornerRadius = 8
            view_one.clipsToBounds = true
            view_one.backgroundColor = light_pink_color
            
        }
    }
    @IBOutlet weak var view_two:UIView! {
        didSet {
            view_two.layer.cornerRadius = 8
            view_two.clipsToBounds = true
            view_two.backgroundColor = light_pink_color
            
        }
    }
    
    @IBOutlet weak var btn_time_one:UIButton! {
        didSet {
            btn_time_one.setTitleColor(.black, for: .normal)
        }
    }
    @IBOutlet weak var btn_time_two:UIButton! {
        didSet {
            btn_time_two.setTitleColor(.black, for: .normal)
        }
    }
    @IBOutlet weak var btn_submit:UIButton!
    
    var lastScheduledBadgeCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btn_one.layer.borderColor = UIColor.black.cgColor
        self.btn_one.layer.borderWidth = 1.0
        self.btn_one.backgroundColor = .systemGreen
        self.lbl_text_one.text = "From time"
        self.lbl_text_two.text = "To time"
        self.lbl_text_two.textColor = .black
        self.view_two.isUserInteractionEnabled = true
        self.view_two.backgroundColor = light_pink_color
        self.btn_time_one.isUserInteractionEnabled = true
        self.btn_time_two.isUserInteractionEnabled = true
        self.btn_time_two.isHidden = false
        
        // 2
        self.btn_two.layer.borderColor = UIColor.clear.cgColor
        self.btn_two.layer.borderWidth = 0
        self.btn_two.backgroundColor = .systemGray5
        // 3
        self.btn_three.layer.borderColor = UIColor.clear.cgColor
        self.btn_three.layer.borderWidth = 0
        self.btn_three.backgroundColor = .systemGray5
        
        self.btn_one.addTarget(self, action: #selector(one_click_method), for: .touchUpInside)
        self.btn_two.addTarget(self, action: #selector(two_click_method), for: .touchUpInside)
        self.btn_three.addTarget(self, action: #selector(three_click_method), for: .touchUpInside)
        
        self.btn_time_one.addTarget(self, action: #selector(time_one_click), for: .touchUpInside)
        self.btn_time_two.addTarget(self, action: #selector(time_two_click), for: .touchUpInside)
        
        self.btn_submit.addTarget(self, action: #selector(submit_click_method), for: .touchUpInside)
    }
    
    @objc func one_click_method() {
        self.str_users_select_type = "1"
        
        self.btn_one.layer.borderColor = UIColor.black.cgColor
        self.btn_one.layer.borderWidth = 1.0
        self.btn_one.backgroundColor = .systemGreen
        self.lbl_text_one.text = "From time"
        self.lbl_text_two.text = "To time"
        self.lbl_text_two.textColor = .black
        self.view_two.isUserInteractionEnabled = true
        self.view_two.backgroundColor = light_pink_color
        self.btn_time_two.isUserInteractionEnabled = true
        self.btn_time_two.isHidden = false
        
        // 2
        self.btn_two.layer.borderColor = UIColor.clear.cgColor
        self.btn_two.layer.borderWidth = 0
        self.btn_two.backgroundColor = .systemGray5
        // 3
        self.btn_three.layer.borderColor = UIColor.clear.cgColor
        self.btn_three.layer.borderWidth = 0
        self.btn_three.backgroundColor = .systemGray5
    }
    @objc func two_click_method() {
        self.str_users_select_type = "2"
        
        self.btn_two.layer.borderColor = UIColor.black.cgColor
        self.btn_two.layer.borderWidth = 1.0
        self.btn_two.backgroundColor = .systemGreen
        self.lbl_text_one.text = "Time 1"
        self.lbl_text_two.text = "Time 2"
        self.lbl_text_two.textColor = .black
        self.view_two.isUserInteractionEnabled = true
        self.view_two.backgroundColor = light_pink_color
        self.btn_time_two.isUserInteractionEnabled = true
        self.btn_time_two.isHidden = false
        
        // 1
        self.btn_one.layer.borderColor = UIColor.clear.cgColor
        self.btn_one.layer.borderWidth = 0
        self.btn_one.backgroundColor = .systemGray5
        // 3
        self.btn_three.layer.borderColor = UIColor.clear.cgColor
        self.btn_three.layer.borderWidth = 0
        self.btn_three.backgroundColor = .systemGray5
    }
    @objc func three_click_method() {
        self.str_users_select_type = "3"
        
        self.btn_three.layer.borderColor = UIColor.black.cgColor
        self.btn_three.layer.borderWidth = 1.0
        self.btn_three.backgroundColor = .systemGreen
        self.lbl_text_one.text = "Time 1"
        self.lbl_text_two.text = "Time 2"
        self.lbl_text_two.textColor = .systemGray5
        self.view_two.isUserInteractionEnabled = false
        self.view_two.backgroundColor = .systemGray5
        self.btn_time_two.isUserInteractionEnabled = false
        self.btn_time_two.isHidden = true
        
        // 1
        self.btn_one.layer.borderColor = UIColor.clear.cgColor
        self.btn_one.layer.borderWidth = 0
        self.btn_one.backgroundColor = .systemGray5
        // 2
        self.btn_two.layer.borderColor = UIColor.clear.cgColor
        self.btn_two.layer.borderWidth = 0
        self.btn_two.backgroundColor = .systemGray5
    }
    
    @objc func time_one_click() {
        RPicker.selectDate(title: "Select Time", cancelText: "Cancel", datePickerMode: .time, didSelectDate: { (selectedDate) in
            self.btn_time_one.setTitle(selectedDate.dateString("HH:mm"), for: .normal)
        })
    }
    @objc func time_two_click() {
        RPicker.selectDate(title: "Select Time", cancelText: "Cancel", datePickerMode: .time, didSelectDate: { (selectedDate) in
            self.btn_time_two.setTitle(selectedDate.dateString("HH:mm"), for: .normal)
        })
    }
    
    @objc func submit_click_method() {
        debugPrint(self.str_users_select_type as Any)
        
        
        requestNotificationAuthorization()
        UNUserNotificationCenter.current().delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(appDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        /*var set_custom = [
            "":"",
            "":""
        ]
        let defaults = UserDefaults.standard
        defaults.setValue(set_custom, forKey: "key_water_reminder")*/
        
        if (self.str_users_select_type == "3") {
            self.convert_date_time_accordingly()
        } else if (self.str_users_select_type == "2") {
            self.scheduleTwoNotifications()
        } else {
            // remind me every hour
            self.scheduleMultipleNotifications()
        }
        
    }
    
    func send_local_notification_instant() {
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Don't forget your task!"
        
        // Notification will be delivered after 10 seconds
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let request = UNNotificationRequest(identifier: "reminderNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully!")
            }
        }
    }
    
    func convert_date_time_accordingly() {
        // print(Date.getCurrentDateCustom())
        
        let separate_date = Date.getCurrentDateCustom().components(separatedBy: "-")
        
        let yyyy = separate_date[0]
        let mm = separate_date[1]
        let dd = separate_date[2]
        
        let int_YYYY = Int(yyyy)
        let int_MM = Int(mm)
        let int_DD = Int(dd)
        
        let separate_time = self.btn_time_one.titleLabel?.text!.components(separatedBy: ":")
        let hr = separate_time![0]
        let min = separate_time![1]
        
        let int_hr = Int(hr)
        let int_min = Int(min)
        
        if (self.str_users_select_type == "3") {
            self.scheduleCustomDateNotification(year: int_YYYY!, month: int_MM!, day: int_DD!, hour: int_hr!, min: int_min!)
        } else if (self.str_users_select_type == "2") {
            self.scheduleTwoNotifications()
            
        }
        
    }
    func scheduleCustomDateNotification(year:Int,month:Int,day:Int,hour:Int,min:Int) {
        
        let content = UNMutableNotificationContent()
        content.title = local_notification_water_intake_header
        content.body = local_notification_water_intake_body
        content.badge = 1
        content.sound = .default
        
        // Define the date and time components for the trigger
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour // 24 hour format
        dateComponents.minute = min
        
        debugPrint(dateComponents as Any)
        
        // Create a trigger with the specified date and time
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        // Create a request for the notification
        let request = UNNotificationRequest(identifier: "reminderNotification", content: content, trigger: trigger)
        
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
                    self.view.makeToast("Notification scheduled successfully!")
                }
                self.updateBadgeCount()
            }
        }
    }
    
    
    func scheduleTwoNotifications() {
        let content = UNMutableNotificationContent()
        content.title = "Daily Reminder"
        content.body = "Don't forget your task!"
        content.sound = .default
        
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        let calendar = Calendar.current
        let now = Date()
        
        let separate_date = Date.getCurrentDateCustom().components(separatedBy: "-")
        
        let yyyy = separate_date[0]
        let mm = separate_date[1]
        let dd = separate_date[2]
        
        let int_YYYY = Int(yyyy)
        let int_MM = Int(mm)
        let int_DD = Int(dd)
        
        let separate_time1 = self.btn_time_one.titleLabel?.text!.components(separatedBy: ":")
        let separate_time2 = self.btn_time_two.titleLabel?.text!.components(separatedBy: ":")
        let hr1 = separate_time1![0]
        let min1 = separate_time1![1]
        
        let hr2 = separate_time2![0]
        let min2 = separate_time2![1]
        
        let int_hr1 = Int(hr1)
        let int_min1 = Int(min1)
        
        let int_hr2 = Int(hr2)
        let int_min2 = Int(min2)
        
        scheduleNotification(at: int_hr1!, minute: int_min1!, content: content)
        scheduleNotification(at: int_hr2!, minute: int_min2!, content: content)
    }
    func scheduleNotification(at hour: Int, minute: Int, content: UNMutableNotificationContent) {
        let calendar = Calendar.current
        let now = Date()
        
        var dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: now)
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func scheduleMultipleNotifications() {
        let separate_time2 = self.btn_time_two.titleLabel?.text!.components(separatedBy: ":")
        let hr1 = separate_time2![0]
        let min1 = separate_time2![1]
        
        let int_hr1 = Int(hr1)
        let int_min1 = Int(min1)
        
        let content = UNMutableNotificationContent()
        content.title = "Water Intake"
        content.body = "Don't forget your task!"
        content.sound = .default
        
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        let calendar = Calendar.current
        let now = Date()
        
        for hour in int_hr1!...int_min1! { // Example: Schedule notifications every hour from 9 AM to 5 PM
            var dateComponents = calendar.dateComponents([.year, .month, .day, .hour], from: now)
            dateComponents.hour = hour
            dateComponents.minute = 0
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
    }
    
    // LOCAL NOTIFICATION
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func appDidBecomeActive() {
        if (self.str_users_select_type == "3") {
            self.convert_date_time_accordingly()
        } else if (self.str_users_select_type == "2") {
            self.scheduleTwoNotifications()
        }
    }
    
    func requestNotificationAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                print("Notification permission granted")
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
