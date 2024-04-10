//
//  Utils.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 16/12/23.
//

import UIKit

var application_base_url = "https://demo4.evirtualservices.net/il_recreator/services/index"

let str_save_login_user_data = "keyLoginFullData"
let str_save_last_api_token = "key_last_api_token"

let your_are_not_auth = "You are not authorize to access the API"

let date_fomatter = "MM-dd-yyyy"
let date_fomatter_yyyy_MM_dd = "yyyy-MM-dd"

class Utils: NSObject {
    
}

extension UIViewController {
    
    @objc func please_check_your_internet_connection() {
        let alert = NewYorkAlertController(title: String("Error").uppercased(), message: String("Please check your Internet Connection"), style: .alert)
        let cancel = NewYorkButton(title: "dismiss", style: .cancel)
        alert.addButtons([cancel])
        self.present(alert, animated: true)
    }
    
    @objc func alert_show_error(field_name:String) {
        
        let alert = NewYorkAlertController(title: String("Alert").uppercased(), message: String(field_name)+String(" field should not be empty"), style: .alert)
        let cancel = NewYorkButton(title: "dismiss", style: .cancel)
        alert.addButtons([cancel])
        self.present(alert, animated: true)
        
    }
    @objc func success_with_back_show_alert(message:String) {
        
        let alert = NewYorkAlertController(title: String("Success").uppercased(), message: String(message), style: .alert)
        let cancel = NewYorkButton(title: "ok", style: .cancel) {
            _ in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addButtons([cancel])
        self.present(alert, animated: true)
        
    }
    
    @objc func light_vibration() {
        
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        
    }
    
    @objc func alert_custom(message:String) {
        
        let alert = NewYorkAlertController(title: String("Alert").uppercased(), message: String(message), style: .alert)
        let cancel = NewYorkButton(title: "dismiss", style: .cancel)
        alert.addButtons([cancel])
        self.present(alert, animated: true)
        
    }
    
    @objc func menu_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "side_bar_menu_id")
        self.navigationController?.pushViewController(push, animated: false)
    }
    
    @objc func back_click_method() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    @objc func time_format_converter(time:String)->String {
        // print(time as Any)
        let separate_time = String(time).components(separatedBy: ":")
        
        let before_space_value = separate_time[0]
        // print(before_space_value)
        
        var set_starting_value:String! = ""
        var merge:String! = ""
        
        if String(before_space_value) == "13" {
            set_starting_value = "01"
            merge = String(set_starting_value)+":"+String(separate_time[0])+" PM"
        } else if String(before_space_value) == "14" {
            set_starting_value = "02"
            merge = String(set_starting_value)+":"+String(separate_time[0])+" PM"
        } else if String(before_space_value) == "15" {
            set_starting_value = "03"
            merge = String(set_starting_value)+":"+String(separate_time[0])+" PM"
        } else if String(before_space_value) == "16" {
            set_starting_value = "04"
            merge = String(set_starting_value)+":"+String(separate_time[0])+" PM"
        } else if String(before_space_value) == "17" {
            set_starting_value = "05"
            merge = String(set_starting_value)+":"+String(separate_time[0])+" PM"
        } else if String(before_space_value) == "18" {
            set_starting_value = "06"
            merge = String(set_starting_value)+":"+String(separate_time[0])+" PM"
        } else if String(before_space_value) == "19" {
            set_starting_value = "07"
            merge = String(set_starting_value)+":"+String(separate_time[0])+" PM"
        } else if String(before_space_value) == "20" {
            set_starting_value = "08"
            merge = String(set_starting_value)+":"+String(separate_time[0])+" PM"
        } else if String(before_space_value) == "21" {
            set_starting_value = "09"
            merge = String(set_starting_value)+":"+String(separate_time[0])+" PM"
        } else if String(before_space_value) == "22" {
            set_starting_value = "10"
            merge = String(set_starting_value)+":"+String(separate_time[0])+" PM"
        } else if String(before_space_value) == "23" {
            set_starting_value = "11"
            merge = String(set_starting_value)+":"+String(separate_time[0])+" PM"
        } else if String(before_space_value) == "24" {
            set_starting_value = "12"
            merge = String(set_starting_value)+":"+String(separate_time[0])+" PM"
        } else {
            // print(time)
            set_starting_value = String(time)
            merge = String(set_starting_value)+" AM"
        }
        
        // print(set_starting_value as Any)
        
        return merge
        
        
    }
    
    
    @objc func time_difference(start_time:String,end_time:String)-> String {
        let time1 = String(start_time)
        let time2 = String(end_time)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        let date1 = formatter.date(from: time1)!
        let date2 = formatter.date(from: time2)!
        
        let elapsedTime = date2.timeIntervalSince(date1)
        
        // convert from seconds to hours, rounding down to the nearest hour
        let hours = floor(elapsedTime / 60 / 60)
        
        // we have to subtract the number of seconds in hours from minutes to get
        // the remaining minutes, rounding down to the nearest minute (in case you
        // want to get seconds down the road)
        let minutes = floor((elapsedTime - (hours * 60 * 60)) / 60)
        
        // print("\(Int(hours)).\(Int(minutes))")
        return "\(Int(hours)).\(Int(minutes))"
    }
    
    
    
    @objc func get_number_convert_into_months(date_one:String)-> String {
        
        print(date_one)
        
        let separate_date = String(date_one).components(separatedBy: "-")
        
        let get_date_data = separate_date[1]
        print(get_date_data as Any)
        
        var month_name:String! = ""
        if (get_date_data == "01") {
            month_name = "January"
        } else if (get_date_data == "02") {
            month_name = "February"
        } else if (get_date_data == "03") {
            month_name = "March"
        } else if (get_date_data == "04") {
            month_name = "April"
        } else if (get_date_data == "05") {
            month_name = "May"
        } else if (get_date_data == "06") {
            month_name = "June"
        } else if (get_date_data == "07") {
            month_name = "July"
        } else if (get_date_data == "08") {
            month_name = "August"
        } else if (get_date_data == "09") {
            month_name = "September"
        } else if (get_date_data == "10") {
            month_name = "October"
        } else if (get_date_data == "11") {
            month_name = "November"
        } else if (get_date_data == "12") {
            month_name = "December"
        } else {
            month_name = "N.A."
        }
        
        return separate_date[2]+" "+month_name
    }
    
     func getDayOfWeek(_ today:String)-> String {
        let formatter  = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
         guard let todayDate = formatter.date(from: today) else
         {
             return "Wrong input"
         }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
         
         var day_is:String!
         if (weekDay == 1) {
             day_is = "Sunday"
         } else if (weekDay == 2) {
             day_is =  "Monday"
         } else if (weekDay == 3) {
             day_is =  "Tuesday"
         } else if (weekDay == 4) {
             day_is =  "Wednesday"
         } else if (weekDay == 5) {
             day_is =  "Thursday"
         } else if (weekDay == 6) {
             day_is =  "Friday"
         } else if (weekDay == 7) {
             day_is =  "Saturday"
         }
        return day_is
    }
}

extension UITextField {
    
    func setLeftPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
}

extension Date {
    
    func dateString(_ format: String = "MM-dd-yyyy, hh:mm a") -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: self)
    }
    func dateString2(_ format: String = "yyyy-MM-dd") -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: self)
    }
    
    func dateByAddingYears(_ dYears: Int) -> Date {
        
        var dateComponents = DateComponents()
        dateComponents.year = dYears
        
        return Calendar.current.date(byAdding: dateComponents, to: self)!
    }
    func dateByAddingDays(_ dDays: Int) -> Date {
        
        var dateComponents = DateComponents()
        dateComponents.day = dDays
        
        return Calendar.current.date(byAdding: dateComponents, to: self)!
    }
}


extension Date {
    
     
    
    static func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = date_fomatter
        return dateFormatter.string(from: Date())
    }
    
    static func getCurrentDateCustom() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = date_fomatter_yyyy_MM_dd
        return dateFormatter.string(from: Date())
    }
    
    
    static func getCurrentTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: Date())
    }
}
