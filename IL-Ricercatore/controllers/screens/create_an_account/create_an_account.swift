//
//  create_an_account.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 16/12/23.
//

import UIKit
import Alamofire

class create_an_account: UIViewController, UITextFieldDelegate {

    var str_get_home_category:String!
    
    @IBOutlet weak var btn_back:UIButton! {
        didSet {
            btn_back.isHidden = false
            btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
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
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tble_view.separatorColor = .white
        
        print("===============================")
        print(self.str_get_home_category as Any)
        print("===============================")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! create_an_account_table_cell
        
        
        if (textField == cell.txt_phone) {
            
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            
            // make sure the result is under 16 characters
            return updatedText.count <= 10
            
        } else {
            
            
            let currentText = textField.text ?? ""
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            
            // make sure the result is under 16 characters
            return updatedText.count <= 40
            
        }
        
    }
    
    @objc func complete_profile_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! create_an_account_table_cell
        
        self.view.endEditing(true)
        
        if (cell.txt_name.text == "") {
            self.alert_show_error(field_name: "Name")
        } else if (cell.txt_email.text == "") {
            self.alert_show_error(field_name: "Email")
        } else if (cell.txt_phone.text == "") {
            self.alert_show_error(field_name: "Phone")
        } else if (cell.txt_password.text == "") {
            self.alert_show_error(field_name: "Password")
        } else {
            self.create_an_account()
        }
        
        
        
        // let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "side_bar_menu_id")
        // self.navigationController?.pushViewController(push, animated: true)
        
    }
    
    @objc func create_an_account() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! create_an_account_table_cell
        
        
        var parameters:Dictionary<AnyHashable, Any>!
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
        parameters = [
            "action"        : "registration",
            "fullName"      : String(cell.txt_name.text!),
            "email"         : String(cell.txt_email.text!),
            "contactNumber" : String(cell.txt_phone.text!),
            "password"      : String(cell.txt_password.text!),
            "home_page_category"      : String(self.str_get_home_category),
            "role"          : String("Member"),
            "device"        : String("iOS")
        ]
        
        
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
                        ERProgressHud.sharedInstance.hide()
                        
                        var dict: Dictionary<AnyHashable, Any>
                        dict = JSON["data"] as! Dictionary<AnyHashable, Any>
                        
                        let defaults = UserDefaults.standard
                        defaults.setValue(dict, forKey: str_save_login_user_data)
                        
                        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "complete_profile_id")
                        self.navigationController?.pushViewController(push, animated: true)
                        
                        
                    }
                    else {
                        // self.login_refresh_token_wb()
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
extension create_an_account: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:create_an_account_table_cell = tableView.dequeueReusableCell(withIdentifier: "create_an_account_table_cell") as! create_an_account_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        cell.txt_name.delegate = self
        cell.txt_email.delegate = self
        cell.txt_phone.delegate = self
        cell.txt_password.delegate = self
        
        cell.btn_create_an_account.addTarget(self, action: #selector(complete_profile_click_method), for: .touchUpInside)
        
         
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 800
    }

}

 
