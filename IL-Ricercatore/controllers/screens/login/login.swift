//
//  login.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 13/12/23.
//

import UIKit
import Alamofire

class login: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txt_email:UITextField! {
        didSet {
            txt_email.layer.cornerRadius = 8
            txt_email.clipsToBounds = true
            txt_email.backgroundColor = .clear
            txt_email.placeholder = "Email"
            txt_email.setLeftPaddingPoints(20)
        }
    }
    
    @IBOutlet weak var txt_password:UITextField! {
        didSet {
            txt_password.layer.cornerRadius = 8
            txt_password.clipsToBounds = true
            txt_password.backgroundColor = .clear
            txt_password.placeholder = "Password"
            txt_password.setLeftPaddingPoints(20)
        }
    }
    
    @IBOutlet weak var btn_not_a_member:UIButton!
    @IBOutlet weak var btn_forgot_password:UIButton!
    
    @IBOutlet weak var view_BG:UIView! {
        didSet {
            view_BG.layer.cornerRadius = 12
            view_BG.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var btn_create_an_account:UIButton! {
        didSet {
            btn_create_an_account.layer.cornerRadius = 8
            btn_create_an_account.clipsToBounds = true
            btn_create_an_account.setTitle("Sign In", for: .normal)
            btn_create_an_account.setTitleColor(.white, for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.txt_email.delegate = self
        self.txt_password.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // self.btn_login.addTarget(self, action: #selector(login_wb), for: .touchUpInside)
        // self.btn_sign_up.addTarget(self, action: #selector(sign_up_click_method), for: .touchUpInside)
        
        self.btn_create_an_account.addTarget(self, action: #selector(login_wb), for: .touchUpInside)
        self.btn_not_a_member.addTarget(self, action: #selector(create_an_Account), for: .touchUpInside)
        
        
        self.setupButton()
    }
    
    deinit {
        // Unregister from keyboard notifications
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = -keyboardHeight / 2
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = 0
        }
    }
    
    // Dismiss the keyboard when the user taps outside the text field
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // UITextFieldDelegate method to dismiss the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setupButton() {
        let fullText = "Not a member ? Register Now"
        let whitePart = "Not a member ?"
        let orangePart = "Register Now"
        
        // Create an attributed string
        let attributedString = NSMutableAttributedString(string: fullText)
        
        // Set the attributes for the white part
        let whiteAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 16)
        ]
        attributedString.addAttributes(whiteAttributes, range: (fullText as NSString).range(of: whitePart))
        
        // Set the attributes for the orange part
        let orangeAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.orange,
            .font: UIFont.boldSystemFont(ofSize: 16)
        ]
        attributedString.addAttributes(orangeAttributes, range: (fullText as NSString).range(of: orangePart))
        
        // Set the attributed text to the button
        btn_not_a_member.setAttributedTitle(attributedString, for: .normal)
        
        // Set the button's background color if needed
        btn_not_a_member.backgroundColor = UIColor.black
        
        // Create a path for the rounded corners
        let maskPath = UIBezierPath(roundedRect: btn_not_a_member.bounds,
                                    byRoundingCorners: [.topLeft, .topRight],
                                    cornerRadii: CGSize(width: 10.0, height: 10.0))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        btn_not_a_member.layer.mask = maskLayer
        
        // Optional: Adjust the button size to fit the content
        btn_not_a_member.sizeToFit()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Update the button mask path if the button size changes
        let maskPath = UIBezierPath(roundedRect: btn_not_a_member.bounds,
                                    byRoundingCorners: [.topLeft, .topRight],
                                    cornerRadii: CGSize(width: 10.0, height: 10.0))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        btn_not_a_member.layer.mask = maskLayer
    }
    
    @objc func sign_up_click_method() {
        // push to dashboard
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "welcome_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    @objc func create_an_Account() {
        // push to dashboard
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "welcome_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    
    @objc func login_wb() {
        
        if (self.txt_email.text == "") {
            return
        }
        
        if (self.txt_password.text == "") {
            return
        }
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        var parameters:Dictionary<AnyHashable, Any>!
        
        
        parameters = [
            "action"    : "login",
            "email"     : String(self.txt_email.text!),
            "password"  : String(self.txt_password.text!),
            "device"    : "iOS",
            
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
                        
                        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "dashboard_id")
                        self.navigationController?.pushViewController(push, animated: true)
                        
                    } else {
                        ERProgressHud.sharedInstance.hide()
                        self.view.makeToast("Email password is wrong")
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
                        
                        self.login_wb()
                        
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
