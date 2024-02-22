//
//  welcome.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 13/12/23.
//

import UIKit

class welcome: UIViewController {

    var arr_brings:NSMutableArray! = []
    
    var arr_add_number_data:NSMutableArray! = []
    
    var str_save_home_page_category:String!
    
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
        
        self.tble_view.separatorColor = .white
        
        self.remember_me()
    }
    
    @objc func remember_me() {
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            print(person as Any)
            
            if person["role"] as! String == "Member" {
                 
                if (person["gender"] as! String) == "" {
                    
                     let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "complete_profile_id")
                     self.navigationController?.pushViewController(push, animated: true)
                    
                } else if (person["Fitness_goal"] as! String) == "" {
                    
                    let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "complete_profile_two_id")
                    self.navigationController?.pushViewController(push, animated: true)
                    
                } else if (person["food_preference"] as! String) == "" {
                    
                    let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "complete_profile_three_id")
                    self.navigationController?.pushViewController(push, animated: true)
                    
                } else {
                    
                    // push to dashboard
                    let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "dashboard_id")
                    self.navigationController?.pushViewController(push, animated: true)
                    
                }
                
                
                
            } else {
                
                // DRIVER
                // let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "dashboard_id")
                // self.navigationController?.pushViewController(push, animated: true)
                
            }
            
        }
        
    }
    
    @objc func reminders_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! welcome_table_cell
        
        if (cell.btn_reminders.tag == 0){
            cell.btn_reminders_check_box.setImage(UIImage(named: "check"), for: .normal)
            cell.btn_reminders.tag = 1
            
            self.arr_add_number_data.add("1")
            self.after_add_remove_data()
            
        } else {
            cell.btn_reminders_check_box.setImage(UIImage(named: "uncheck"), for: .normal)
            cell.btn_reminders.tag = 0
            
            self.arr_add_number_data.remove("1")
            self.after_add_remove_data()
            
        }
        
    }
    
    @objc func diet_plan_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! welcome_table_cell
        
        if (cell.btn_diet_plan.tag == 0){
            cell.btn_diet_plan_check_box.setImage(UIImage(named: "check"), for: .normal)
            cell.btn_diet_plan.tag = 1
            
            self.arr_add_number_data.add("2")
            self.after_add_remove_data()
            
        } else {
            cell.btn_diet_plan_check_box.setImage(UIImage(named: "uncheck"), for: .normal)
            cell.btn_diet_plan.tag = 0
            
            self.arr_add_number_data.remove("2")
            self.after_add_remove_data()
            
        }
        
    }
    
    // 2
    @objc func weight_loss__click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! welcome_table_cell
        
        if (cell.btn_weight_loss.tag == 0){
            cell.btn_weight_loss_check_box.setImage(UIImage(named: "check"), for: .normal)
            cell.btn_weight_loss.tag = 1
            
            self.arr_add_number_data.add("3")
            self.after_add_remove_data()
            
        } else {
            cell.btn_weight_loss_check_box.setImage(UIImage(named: "uncheck"), for: .normal)
            cell.btn_weight_loss.tag = 0
            
            self.arr_add_number_data.remove("3")
            self.after_add_remove_data()
            
        }
        
    }
    
    @objc func muscle_gain_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! welcome_table_cell
        
        if (cell.btn_muscle_gain.tag == 0){
            cell.btn_muscle_gain_check_box.setImage(UIImage(named: "check"), for: .normal)
            cell.btn_muscle_gain.tag = 1
            
            self.arr_add_number_data.add("4")
            self.after_add_remove_data()
            
        } else {
            cell.btn_muscle_gain_check_box.setImage(UIImage(named: "uncheck"), for: .normal)
            cell.btn_muscle_gain.tag = 0
            
            self.arr_add_number_data.remove("4")
            self.after_add_remove_data()
            
        }
        
    }
    
    // 5
    @objc func mean_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! welcome_table_cell
        
        if (cell.btn_meal.tag == 0){
            cell.btn_meal_check_box.setImage(UIImage(named: "check"), for: .normal)
            cell.btn_meal.tag = 1
            
            self.arr_add_number_data.add("5")
            self.after_add_remove_data()
            
        } else {
            cell.btn_meal_check_box.setImage(UIImage(named: "uncheck"), for: .normal)
            cell.btn_meal.tag = 0
            
            self.arr_add_number_data.remove("5")
            self.after_add_remove_data()
            
        }
        
    }
    
    // 6
    @objc func count_calorie_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! welcome_table_cell
        
        if (cell.btn_count_calorie.tag == 0){
            cell.btn_count_calorie_check_box.setImage(UIImage(named: "check"), for: .normal)
            cell.btn_count_calorie.tag = 1
            
            self.arr_add_number_data.add("6")
            self.after_add_remove_data()
            
        } else {
            cell.btn_count_calorie_check_box.setImage(UIImage(named: "uncheck"), for: .normal)
            cell.btn_count_calorie.tag = 0
            
            self.arr_add_number_data.remove("6")
            self.after_add_remove_data()
            
        }
        
    }
    
    
    // 7
    @objc func routine_track_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! welcome_table_cell
        
        if (cell.btn_routine_track.tag == 0){
            cell.btn_routine_track_check_box.setImage(UIImage(named: "check"), for: .normal)
            cell.btn_routine_track.tag = 1
            
            self.arr_add_number_data.add("7")
            self.after_add_remove_data()
            
        } else {
            cell.btn_routine_track_check_box.setImage(UIImage(named: "uncheck"), for: .normal)
            cell.btn_routine_track.tag = 0
            
            self.arr_add_number_data.remove("7")
            self.after_add_remove_data()
            
        }
        
    }
    
    // 8
    @objc func workout_yoga_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! welcome_table_cell
        
        if (cell.btn_workout_yoga.tag == 0){
            cell.btn_workout_yoga_check_box.setImage(UIImage(named: "check"), for: .normal)
            cell.btn_workout_yoga.tag = 1
            
            self.arr_add_number_data.add("8")
            self.after_add_remove_data()
            
        } else {
            cell.btn_workout_yoga_check_box.setImage(UIImage(named: "uncheck"), for: .normal)
            cell.btn_workout_yoga.tag = 0
            
            self.arr_add_number_data.remove("8")
            self.after_add_remove_data()
            
        }
        
    }
    
    @objc func after_add_remove_data() {

        let swiftArray = NSArray(array: self.arr_add_number_data) as? [String]
        let string = swiftArray!.joined(separator: ",")
        
        self.str_save_home_page_category = String(string)
    }
    
    @objc func continue_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! welcome_table_cell
        
        if (self.arr_add_number_data.count == 0) {
            self.alert_custom(message: str_select_one_category_en)
            return
        }
        
        if (self.str_save_home_page_category == "") {
            self.alert_custom(message: str_select_one_category_en)
            return
        }
        
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "create_an_account_id") as! create_an_account
        push.str_get_home_category = String(str_save_home_page_category)
        self.navigationController?.pushViewController(push, animated: true)
        
        // let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "breakfast_food_id")
        // self.navigationController?.pushViewController(push, animated: true)
    }
    
}

//MARK:- TABLE VIEW -
extension welcome: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:welcome_table_cell = tableView.dequeueReusableCell(withIdentifier: "welcome_table_cell") as! welcome_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        cell.btn_reminders.addTarget(self, action: #selector(reminders_click_method), for: .touchUpInside)
        cell.btn_diet_plan.addTarget(self, action: #selector(diet_plan_click_method), for: .touchUpInside)
        
        cell.btn_weight_loss.addTarget(self, action: #selector(weight_loss__click_method), for: .touchUpInside)
        cell.btn_muscle_gain.addTarget(self, action: #selector(muscle_gain_click_method), for: .touchUpInside)
        
        cell.btn_meal.addTarget(self, action: #selector(mean_click_method), for: .touchUpInside)
        cell.btn_count_calorie.addTarget(self, action: #selector(count_calorie_click_method), for: .touchUpInside)
        
        cell.btn_routine_track.addTarget(self, action: #selector(routine_track_click_method), for: .touchUpInside)
        cell.btn_workout_yoga.addTarget(self, action: #selector(workout_yoga_click_method), for: .touchUpInside)
        
        // dummy
        // cell.btn_workout_yoga.addTarget(self, action: #selector(breakfast_food_click_method), for: .touchUpInside)
        
        
        cell.btn_continue.addTarget(self, action: #selector(continue_click_method), for: .touchUpInside)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 646
    }

}


