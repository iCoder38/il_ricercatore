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
        
        let alert = NewYorkAlertController(title: String("Error").uppercased(), message: String(field_name)+String(" field should not be empty"), style: .alert)
        let cancel = NewYorkButton(title: "dismiss", style: .cancel)
        alert.addButtons([cancel])
        self.present(alert, animated: true)
        
        
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
    
    func dateString(_ format: String = "MMM-dd-YYYY, hh:mm a") -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: self)
    }
    
    func dateByAddingYears(_ dYears: Int) -> Date {
        
        var dateComponents = DateComponents()
        dateComponents.year = dYears
        
        return Calendar.current.date(byAdding: dateComponents, to: self)!
    }
}


extension Date {
 static func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: Date())
    }
}
