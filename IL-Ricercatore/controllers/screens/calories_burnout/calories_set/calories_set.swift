//
//  calories_set.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 10/05/24.
//

import UIKit

class calories_set: UIViewController {

    var arr_all_activities_data:Array<Any>!
    
    @IBOutlet weak var btn_back:UIButton! {
        didSet {
            btn_back.tintColor = .white
            btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        }
    }
   
    @IBOutlet weak var view_navigation_title:UILabel! {
        didSet {
            view_navigation_title.text = "SET CALORIES"
            view_navigation_title.textColor = .white
        }
    }
    
    @IBOutlet weak var txt_activity:UITextField! {
        didSet {
            txt_activity.layer.cornerRadius = 8
            txt_activity.clipsToBounds = true
            txt_activity.backgroundColor = light_pink_color
            txt_activity.placeholder = "Activity"
            txt_activity.setLeftPaddingPoints(20)
            txt_activity.keyboardType = .default
        }
    }
    
    @IBOutlet weak var txt_weight:UITextField! {
        didSet {
            txt_weight.layer.cornerRadius = 8
            txt_weight.clipsToBounds = true
            txt_weight.backgroundColor = light_pink_color
            txt_weight.placeholder = "Weight"
            txt_weight.setLeftPaddingPoints(20)
        }
    }
    
    @IBOutlet weak var txt_distance:UITextField! {
        didSet {
            txt_distance.layer.cornerRadius = 8
            txt_distance.clipsToBounds = true
            txt_distance.backgroundColor = light_pink_color
            txt_distance.placeholder = "Distance"
            txt_distance.setLeftPaddingPoints(20)
        }
    }
    
    @IBOutlet weak var btn_continue:UIButton!  {
        didSet {
            btn_continue.layer.cornerRadius = 8
            btn_continue.clipsToBounds = true
            btn_continue.setTitle("continue".uppercased(), for: .normal)
            btn_continue.setTitleColor(.white, for: .normal)
        }
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btn_continue.addTarget(self, action: #selector(rapid_api_cal_burnt), for: .touchUpInside)
    }

    func kilogramsToPounds(_ kilograms: Double) -> Double {
        return kilograms * 2.20462 // 1 kilogram = 2.20462 pounds
    }
    
    @objc func rapid_api_cal_burnt() {
        
        if (self.txt_activity.text == "") {
            self.view.makeToast("Please enter activity")
            return
        }
        
        if (self.txt_weight.text == "") {
            self.view.makeToast("Please enter weight")
            return
        }
        
        if (self.txt_distance.text == "") {
            self.view.makeToast("Please enter distance")
            return
        }
        
        var double_value:String!
        
        let stringValue = self.txt_weight.text
        if let doubleValue = Double(stringValue!) {
            print("Double value: \(doubleValue)")
            
            let pounds = kilogramsToPounds(doubleValue)
            
            double_value = "\(pounds)"
        } else {
            print("Invalid string for conversion to Double.")
        }
        
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        // Define headers
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "X-RapidAPI-Key": str_rapid_api_header,
            "X-RapidAPI-Host": str_rapid_api_host
        ]
        
        var dynamic_URL = "https://calories-burned-by-api-ninjas.p.rapidapi.com/v1/caloriesburned?activity=\(self.txt_activity.text!)&weight=\(double_value!)&duration=\(self.txt_distance.text!)"
        // Create the request
        
        debugPrint(dynamic_URL)
        
        guard let url = URL(string: dynamic_URL) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        // Perform the request
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            // Check for errors
            if let error = error {
                print("Error: \(error.localizedDescription)")
                ERProgressHud.sharedInstance.hide()
                return
            }
            
            // Check if a response was received
            guard let httpResponse = response as? HTTPURLResponse else {
                print("No response received")
                ERProgressHud.sharedInstance.hide()
                return
            }
            
            // Check for valid status code
            guard (200...299).contains(httpResponse.statusCode) else {
                print("Invalid response: \(httpResponse.statusCode)")
                ERProgressHud.sharedInstance.hide()
                return
            }
            
            // Check if data was received
            guard let responseData = data else {
                print("No data received")
                ERProgressHud.sharedInstance.hide()
                return
            }
            
            // Parse the JSON data
            do {
                // Try parsing JSON
                var json = try JSONSerialization.jsonObject(with: responseData, options: [])
                print("Response JSON: \(json)")
                // Handle the JSON response here
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    ERProgressHud.sharedInstance.hide()
                    self.arr_all_activities_data = (json as! Array<Any>)
                    
                    let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "show_all_cal_burnt_ctivity_id") as? show_all_cal_burnt_ctivity
                    push!.get_array = self.arr_all_activities_data
                    self.navigationController?.pushViewController(push!, animated: true)
                }
            } catch let error {
                ERProgressHud.sharedInstance.hide()
                print("Error parsing JSON: \(error.localizedDescription)")
                print("Response Data: \(String(data: responseData, encoding: .utf8) ?? "Empty")")
            }
        }
        
        dataTask.resume()
        
    }
    
}
