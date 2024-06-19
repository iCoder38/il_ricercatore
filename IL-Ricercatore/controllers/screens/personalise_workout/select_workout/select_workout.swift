//
//  select_workout.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 21/12/23.
//

import UIKit

class select_workout: UIViewController {

    var arr_all_activities_data:Array<Any>!
    // var arr_add_custom_array:NSMutableArray! = []
    
    var arr_add_custom_array: [[String: Any]] = []
    var isItemSelected = false
    
    var custom: [[String: Any]] = []
    
    let arr_dummy = ["Bench Press","Squats","Push-up","Bicep curl","Burpee","Overhead pass","Pull-up"]
    @IBOutlet weak var btn_back:UIButton! {
        didSet {
            btn_back.tintColor = .black
            btn_back.setImage(UIImage(systemName: "arrow.left"), for: .normal)
            btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var lbl_navigation_title:UILabel! {
        didSet {
            lbl_navigation_title.text = navigation_title_select_workout_en
        }
    }
    
    @IBOutlet weak var tble_view:UITableView! {
        didSet {
            // tble_view.delegate = self
            // tble_view.dataSource = self
            // tble_view.layer.cornerRadius = 22
            // tble_view.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var view_search:UIView! {
        didSet {
            view_search.layer.cornerRadius = 8
            view_search.clipsToBounds = true
            view_search.backgroundColor = .white
        }
    }
    
    @IBOutlet weak var txt_search:UITextField! {
        didSet {
            txt_search.layer.cornerRadius = 8
            txt_search.clipsToBounds = true
            txt_search.backgroundColor = .clear
            txt_search.placeholder = "Search..."
            // txt_search.setLeftPaddingPoints(20)
        }
    }
    
    @IBOutlet weak var btn_continue:UIButton! {
        didSet {
            btn_continue.layer.cornerRadius = 8
            btn_continue.clipsToBounds = true
            btn_continue.setTitle("Continue".uppercased(), for: .normal)
            btn_continue.setTitleColor(.white, for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tble_view.separatorColor = .gray
        
        self.updateContinueButtonVisibility()
        
        self.search_workout()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    @objc func continue_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "workout_details_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    @objc func search_workout() {
        
        let activity = "skiing".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: "https://api.api-ninjas.com/v1/caloriesburned?activity="+activity!)!
        var request = URLRequest(url: url)
        request.setValue("iMmbLV8e289ZG4nuTVCkwg==R8dlRkgN6D60YrAC", forHTTPHeaderField: "X-Api-Key")
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            
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
            
            do {
                // Try parsing JSON
                var json = try JSONSerialization.jsonObject(with: responseData, options: [])
                print("Response JSON: \(json)")
                // Handle the JSON response here
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    ERProgressHud.sharedInstance.hide()
                     self.arr_all_activities_data = (json as! Array<Any>)
                    
                    self.set_custom()
                    
                }
            } catch let error {
                ERProgressHud.sharedInstance.hide()
                print("Error parsing JSON: \(error.localizedDescription)")
                print("Response Data: \(String(data: responseData, encoding: .utf8) ?? "Empty")")
            }
            
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
        }
        task.resume()
        
        
    }
    
    @objc func set_custom() {
        
        for indexx in 0..<self.arr_all_activities_data.count {
            let item = self.arr_all_activities_data[indexx] as? [String:Any]
            
            let custom = [
                "name":(item!["name"] as! String),
                "duration_minutes":"\(item!["duration_minutes"]!)",
                "total_calories":"\(item!["total_calories"]!)",
                "status":"no",
            ]
            // self.arr_add_custom_array.add(custom)
            self.arr_add_custom_array.append(custom)
        }
        
        // print(self.arr_add_custom_array as Any)
        self.tble_view.delegate = self
        self.tble_view.dataSource = self
        self.tble_view.reloadData()
        
    }
    
    
    func updateContinueButtonVisibility() {
        // Show Continue button only if at least one item is selected
        self.btn_continue.isHidden = !isItemSelected
    }
    
    func checkSelectionState() {
        // Check if at least one item is selected
        isItemSelected = arr_add_custom_array.contains { $0["status"] as? String == "yes" }
        
        // Update visibility of Continue button
        updateContinueButtonVisibility()
    }
    
}

//MARK:- TABLE VIEW -
extension select_workout: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_add_custom_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:select_workout_table_cell = tableView.dequeueReusableCell(withIdentifier: "select_workout_table_cell") as! select_workout_table_cell
        
        let item = self.arr_add_custom_array[indexPath.row] as? [String:Any]
        cell.lbl_title.text = (item!["name"] as! String)
        cell.lbl_sub_title.text = "\(item!["duration_minutes"]!) Min"
        cell.lbl_cal.text = "\(item!["total_calories"]!) Cal"
        
        if (item!["status"] as! String) == "yes" {
            cell.btn_add.setImage(UIImage(named: "plus"), for: .normal)
        } else {
            cell.btn_add.setImage(UIImage(named: "plus1"), for: .normal)
        }
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        self.btn_continue.addTarget(self, action: #selector(continue_click_method), for: .touchUpInside)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        for (index, _) in self.arr_add_custom_array.enumerated() {
            self.arr_add_custom_array[index]["status"] = (index == indexPath.row) ? "yes" : "no"
        }
        checkSelectionState()
        self.tble_view.reloadData()
       
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        // Update status of the deselected item
        var item = arr_add_custom_array[indexPath.row]
        item["status"] = "no"
        arr_add_custom_array[indexPath.row] = item
        
        // Check if any item is selected
        checkSelectionState()
        
        // Reload the table view to reflect updated selection state
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}
