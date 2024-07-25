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

var app_name = "IL-Recercatore"
var appstore_URL = "https://www.google.co.in"

// api keys
var excercise_api_key = "iMmbLV8e289ZG4nuTVCkwg==R8dlRkgN6D60YrAC"

// rapid api
var str_rapid_api_header = "23faaa439fmsh27a2b4cf902db09p183b39jsn534baaae20b4"
var str_rapid_api_host = "calories-burned-by-api-ninjas.p.rapidapi.com"
var str_rapid_api_host_for_level = "fitness-calculator.p.rapidapi.com"

var set_URL = "https://calories-burned-by-api-ninjas.p.rapidapi.com/v1/caloriesburned?activity="
var search_food_query_URL = "https://api.api-ninjas.com/v1/nutrition?query="
var excercise_URL = "https://exercise-db-fitness-workout-gym.p.rapidapi.com/"
var calories_burned_aerobics_URL = "https://api.api-ninjas.com/v1/caloriesburned?activity="

var all_exercise_host = "exercise-db-fitness-workout-gym.p.rapidapi.com"
var all_exercise_api_key = "a549c19e42msh291ffe0591026cep1d1f1ejsnea1fdd0d9fc8"
var all_exercise_list_URL = "https://exercise-db-fitness-workout-gym.p.rapidapi.com/exercises"

// days
var day_sunday = 1
var day_monday = 2
var day_tuesday = 3
var day_wednesday = 4
var day_thursday = 5
var day_friday = 6
var day_saturday = 7

// type
var type_breakfast = "Breakfast"
var type_morning_snack = "Morning snack"
var type_lunch = "Lunch"
var type_evening_snack = "Evening snack"
var type_dinner = "Dinner"
var type_every_day = "Every day"
var type_sunday = "Sunday"
var type_monday = "Monday"
var type_tuesday = "Tuesday"
var type_wednesday = "Wednesday"
var type_thursday = "Thursday"
var type_friday = "Friday"
var type_saturday = "Saturday"

var type_workout_remind_me_every_at = "Remind me every at"

// for local notification
var local_notification_water_intake_header = "Water intake"
var local_notification_water_intake_body = "Drink water"


var local_notification_workout_reminder_header = "Workout reminder"
var local_notification_workout_reminder_body = "Daily task"


var local_notification_walk_reminder_header = "Walk reminder"
var local_notification_walk_reminder_body = "Daily task"


var local_notification_weight_reminder_header = "Weight reminder"
var local_notification_weight_reminder_body = "Daily task"


var local_notification_health_reminder_header = "Health reminder"
var local_notification_health_reminder_body = "Daily task"

// identifiers

// health
var identifier_health_reminder_remind_me_every_at = "reminder_health_remind_me_at"
var identifier_health_reminder_remind_me_only1 = "reminder_health_remind_me_only1"
// var identifier_health_reminder_remind_me_every_at = "reminder_health_remind_me_at"

// weight
var identifier_weight_reminder_remind_me_every_at = "reminder_weight_remind_me_at"
var identifier_weight_reminder_remind_me_only1 = "reminder_weight_remind_me_only1"

// walk
var identifier_walk_reminder_remind_me_every_at = "reminder_walk_remind_me_at"
var identifier_walk_sunday = "reminder_walk_sunday"
var identifier_walk_monday = "reminder_walk_monday"
var identifier_walk_tuesday = "reminder_walk_tuesday"
var identifier_walk_wednesday = "reminder_walk_wednesday"
var identifier_walk_thursday = "reminder_walk_thursday"
var identifier_walk_friday = "reminder_walk_friday"
var identifier_walk_saturday = "reminder_walk_saturday"

// workout
var identifier_meal_reminder_remind_me_every_at = "reminder_workout_remind_me_at"
var identifier_meal_sunday = "reminder_workout_sunday"
var identifier_meal_monday = "reminder_workout_monday"
var identifier_meal_tuesday = "reminder_workout_tuesday"
var identifier_meal_wednesday = "reminder_workout_wednesday"
var identifier_meal_thursday = "reminder_workout_thursday"
var identifier_meal_friday = "reminder_workout_friday"
var identifier_meal_saturday = "reminder_workout_saturday"

// meal
var identifier_meal_reminder_dinner = "reminder_meal_dinner"
var identifier_meal_reminder_evening_snack = "reminder_meal_evening_snack"
var identifier_meal_reminder_lunch = "reminder_meal_lunch"
var identifier_meal_reminder_breakfast = "reminder_meal_breakfast"
var identifier_meal_reminder_morning_snack = "reminder_meal_morning_snack"
// var identifier_meal_reminder_every_day = "reminder_meal_remind_every_day"

var local_notification_meal_reminder_breakfast_header = "Meal reminder"
var local_notification_meal_reminder_breakfast_body = "Reminder: meal"

class Utils: NSObject {
    
}

class UserUtility {
    
    static func getUserId() -> Int? {
        guard let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String: Any],
              let userId = person["userId"] as? Int else {
            return nil
        }
        return userId
    }
    
}


struct ConversionUtils {
    static func convertLbsToKg(_ lbs: Double) -> Double {
        let lbsToKgConversionFactor = 0.453592
        return lbs * lbsToKgConversionFactor
    }
}

extension UIButton {
    func addBottomBorder(color: UIColor, height: CGFloat = 2.0) {
        // Remove existing borders
        for subview in self.subviews where subview.tag == 999 {
            subview.removeFromSuperview()
        }
        
        // Create a UIView for the bottom border
        let border = UIView()
        border.backgroundColor = color
        border.tag = 999 // Tag to identify the border view
        border.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(border)

        // Add constraints to position the border at the bottom of the button
        NSLayoutConstraint.activate([
            border.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            border.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            border.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            border.heightAnchor.constraint(equalToConstant: height) // Adjust the height of the border as needed
        ])
    }
}


extension UIViewController {
    
    func calculatePercentage(userValueString: String, serverValueString: String) -> Double? {
        guard let userValue = Double(userValueString), let serverValue = Double(serverValueString) else {
                print("Invalid input for userValue or serverValue")
                return nil
            }
            
            // Calculate the percentage
            let percentage = (userValue / 100) * serverValue
            
            // Format to two decimal places
            let formattedPercentage = Double(String(format: "%.2f", percentage))
            
            return formattedPercentage
    }
    
    func addThreeValues(value1: String, value2: String, value3: String) -> Int? {
        // Convert strings to Double
        guard let num1 = Double(value1), let num2 = Double(value2), let num3 = Double(value3) else {
                print("Invalid input")
                return nil
            }
            
            // Perform the addition
            let sum = num1 + num2 + num3
            
            // Convert sum to Int
            let sumInt = Int(sum)
            
            return sumInt
    }
    
    func addFiveValues(value1: String, value2: String, value3: String, value4: String, value5: String) -> Int? {
        // Convert strings to Double
        guard let num1 = Double(value1), let num2 = Double(value2), let num3 = Double(value3), let num4 = Double(value4), let num5 = Double(value5) else {
                print("Invalid input")
                return nil
            }
            
            // Perform the addition
            let sum = num1 + num2 + num3 + num4 + num5
            
            // Convert sum to Int
            let sumInt = Int(sum)
            
            return sumInt
    }
    
    func calculateProteinGrams(caloriesString: String, proteinPercentageString: String) -> String? {
        // Convert strings to Double
        guard let calories = Double(caloriesString), let proteinPercentage = Double(proteinPercentageString) else {
            print("Invalid input")
            return nil
        }
        
        // Perform the calculation
        let proteinGrams = (calories * (proteinPercentage / 100)) / 4
        
        // Format the result to 2 decimal places
        let formattedProteinGrams = String(format: "%.2f", proteinGrams)
        return formattedProteinGrams
    }
    
    func calculateCarbsGrams(caloriesString: String, proteinPercentageString: String) -> String? {
        // Convert strings to Double
        guard let calories = Double(caloriesString), let proteinPercentage = Double(proteinPercentageString) else {
            print("Invalid input")
            return nil
        }
        
        // Perform the calculation
        let proteinGrams = (calories * (proteinPercentage / 100)) / 4
        
        // Format the result to 2 decimal places
        let formattedProteinGrams = String(format: "%.2f", proteinGrams)
        return formattedProteinGrams
    }
    
    func calculateFatsGrams(caloriesString: String, proteinPercentageString: String) -> String? {
        // Convert strings to Double
        guard let calories = Double(caloriesString), let proteinPercentage = Double(proteinPercentageString) else {
            print("Invalid input")
            return nil
        }
        
        // Perform the calculation
        let proteinGrams = (calories * (proteinPercentage / 100)) / 9
        
        // Format the result to 2 decimal places
        let formattedProteinGrams = String(format: "%.2f", proteinGrams)
        return formattedProteinGrams
    }
    
    
    
    
    
    func calculateCalories(currentWeight: Double, weightUnit: String, height: Double, heightUnit: String, age: Double, gender: String, selectedLevel: String) -> Double {
        // Convert weight to kg if it is in lbs
        let weightInKg: Double
        if weightUnit == "lbs" {
            weightInKg = currentWeight * 0.453592
        } else {
            weightInKg = currentWeight
        }
        
        // Convert height to cm if it is in feet
        let heightInCm: Double
        if heightUnit == "ft" {
            heightInCm = height * 30.48
        } else {
            heightInCm = height
        }
        
        let calculate = (10 * weightInKg) + (6.25 * heightInCm) - (5 * age)
        
        // Adjust the calculation based on gender
        let minusGenerWise: Double
        if gender.lowercased() == "male" {
            minusGenerWise = calculate - 5.0
        } else if gender.lowercased() == "female" {
            minusGenerWise = calculate - 161.0
        } else {
            fatalError("Invalid gender specified. Use 'male' or 'female'.")
        }
        
        var DT_value: Double
        
        switch selectedLevel {
        case "1":
            DT_value = 1.2
        case "2":
            DT_value = 1.375
        case "3":
            DT_value = 1.55
        case "4":
            DT_value = 1.725
        case "5":
            DT_value = 1.9
        default:
            DT_value = 1.2
        }
        
        let calResult = minusGenerWise * DT_value
        return calResult
    }
    
    func calculateCaloriesWithBurn(currentWeight: Double,
                                   weightUnit: String,
                                   height: Double,
                                   heightUnit: String,
                                   age: Double,
                                   gender: String,
                                   selectedLevel: String,
                                   serverKeyData: String) -> Double {
        // Convert weight to kg if it is in lbs
        let weightInKg: Double
        if weightUnit == "lbs" {
            weightInKg = currentWeight * 0.453592
        } else {
            weightInKg = currentWeight
        }
        
        // Convert height to cm if it is in feet
        let heightInCm: Double
        if heightUnit == "ft" {
            heightInCm = height * 30.48
        } else {
            heightInCm = height
        }
        
        let calculate = (10 * weightInKg) + (6.25 * heightInCm) - (5 * age)
        
        // Adjust the calculation based on gender
        let minusGenerWise: Double
        if gender.lowercased() == "male" {
            minusGenerWise = calculate - 5.0
        } else if gender.lowercased() == "female" {
            minusGenerWise = calculate - 161.0
        } else {
            fatalError("Invalid gender specified. Use 'male' or 'female'.")
        }
        
        var DT_value: Double
        
        switch selectedLevel {
        case "1":
            DT_value = 1.2
        case "2":
            DT_value = 1.375
        case "3":
            DT_value = 1.55
        case "4":
            DT_value = 1.725
        case "5":
            DT_value = 1.9
        default:
            DT_value = 1.2
        }
        
        let calResult = minusGenerWise * DT_value
        
        let cal_calResult = calResult * DT_value
        
        let serverKeyIntArray = convertStringToIntArray(serverKeyData)
        
        let containsThree = serverKeyIntArray.contains(3)
        let containsFour = serverKeyIntArray.contains(4)
            
            let finalResult: Double
            
            if containsThree && containsFour {
                finalResult = cal_calResult * 1.0
            } else if containsThree {
                finalResult = cal_calResult * 0.25
            } else if containsFour {
                finalResult = cal_calResult * 0.10
            } else {
                finalResult = cal_calResult
            }
        
        let formattedFinalResult = Double(String(format: "%.2f", finalResult)) ?? finalResult
        
        return formattedFinalResult
    }

    func convertStringToIntArray(_ data: String) -> [Int] {
        return data.split(separator: ",").compactMap { Int($0.trimmingCharacters(in: .whitespaces)) }
    }
    
    func addBottomBorderSelected(to button: UIButton) {
            // Create a UIView for the bottom border
            let border = UIView()
            border.backgroundColor = UIColor.black
            border.translatesAutoresizingMaskIntoConstraints = false
            button.addSubview(border)

            // Add constraints to position the border at the bottom of the button
            NSLayoutConstraint.activate([
                border.leadingAnchor.constraint(equalTo: button.leadingAnchor),
                border.trailingAnchor.constraint(equalTo: button.trailingAnchor),
                border.bottomAnchor.constraint(equalTo: button.bottomAnchor),
                border.heightAnchor.constraint(equalToConstant: 2) // Adjust the height of the border as needed
            ])
    }
    
    func addBottomBorderNotSelected(to button: UIButton) {
            // Create a UIView for the bottom border
            let border = UIView()
            border.backgroundColor = UIColor.systemOrange
            border.translatesAutoresizingMaskIntoConstraints = false
            button.addSubview(border)

            // Add constraints to position the border at the bottom of the button
            NSLayoutConstraint.activate([
                border.leadingAnchor.constraint(equalTo: button.leadingAnchor),
                border.trailingAnchor.constraint(equalTo: button.trailingAnchor),
                border.bottomAnchor.constraint(equalTo: button.bottomAnchor),
                border.heightAnchor.constraint(equalToConstant: 2) // Adjust the height of the border as needed
            ])
    }
    

    
    func getDayNameAndNumber() -> (String, Int) {
        // Get the current date
        let today = Date()
        
        // Create a DateFormatter instance for the day name
        let dayNameFormatter = DateFormatter()
        dayNameFormatter.dateFormat = "EEEE"
        
        // Format the date to get the day name
        let dayName = dayNameFormatter.string(from: today)
        
        // Use Calendar to get the day number
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: today)
        
        // Map the weekday to Monday = 1, Tuesday = 2, ..., Sunday = 7
        let dayNumber = (weekday + 5) % 7 + 1
        
        return (dayName, dayNumber)
    }
    
    func weekday_reminder(header:String,body:String,day:Int,get_full_time:String,identifier:String,type:String) {
        var int_hr:Int!
        var int_min:Int!
        
        let separate_time = "\(get_full_time)".components(separatedBy: ":")
        debugPrint(separate_time.count as Any)
        debugPrint(separate_time as Any)
        
        let hr = separate_time[0]
        if (hr == ""){
            return
        }
        let min = separate_time[1]
        
        int_hr = Int(hr)
        int_min = Int(min)
        
        let content = UNMutableNotificationContent()
        content.title = header
        content.body = body
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.weekday = day
        dateComponents.hour = int_hr
        dateComponents.minute = int_min
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
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
        
        
    }
    
    func scheduleDailyReminder(hour: Int, minute: Int,header:String,body:String,identifier:String,text:String) {
        let content = UNMutableNotificationContent()
        content.title = header
        content.body = body
        content.sound = .default
        
        let center = UNUserNotificationCenter.current()
        // center.removeAllPendingNotificationRequests()
        
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
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
                    self.set_local_notification_toast(type: text, status: "e")
                }
                // self.updateBadgeCount()
            }
        }
        
    }
    
    
    func scheduleReminderCustomDayAndTime(for year: Int, month: Int, day: Int, hour: Int, minute: Int,identifier:String,type:String) {
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = "Don't forget your task!"
        content.sound = .default
        
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
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
                    self.set_local_notification_toast(type: type, status: "enable")
                }
                // self.updateBadgeCount()
            }
        }
        
    }
    
    
    
    func disable_reminder(identifier:String,text:String) {
        debugPrint(identifier as Any)
        
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [identifier])
        
        self.set_local_notification_toast(type: text, status: "d")
    }
    
    func disable_reminder2(identifier:String,text:String,type:String) {
        debugPrint(identifier as Any)
        
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [identifier])
        
        if (type == "all") {
            self.view.makeToast("All weekdays notifications are cleared")
        } else {
            self.set_local_notification_toast(type: text, status: "d")
        }
        
    }
    
    
    @objc func set_local_notification_toast(type:String,status:String) {
        if (status == "enable" || status == "e") {
            self.view.makeToast("\(type): Notification scheduled successfully!")
        } else {
            self.view.makeToast("\(type): Notification disabled successfully!")
        }
        
    }
    
    func convertTo12HourFormat(time: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        
        if let date = dateFormatter.date(from: time) {
            dateFormatter.dateFormat = "h:mm a"
            return dateFormatter.string(from: date)
        }
        
        return nil
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
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
    
    @objc func get_number_convert_into_months_slash(date_one:String)-> String {
        
        print(date_one)
        
        let separate_date = String(date_one).components(separatedBy: "/")
        
        let get_date_data = separate_date[0]
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
        
        return separate_date[1]+" - "+month_name
    }
    
    @objc func get_number_convert_into_months_slash_glucose(date_one:String)-> String {
        
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
        
        return separate_date[1]+" - "+month_name
    }
    
    func getDayOfWeek(_ today:String)-> String {
        // print(today);
        // let separate_date = String(today).components(separatedBy: "/")
        
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
    
    func dateStringCustommmm(_ format: String = "dd/MM, hh:mm a") -> String {
        
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
    
    static func dateCustomForWaterTaken() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        return dateFormatter.string(from: Date())
    }
    
    static func getCurrentTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: Date())
    }
}
