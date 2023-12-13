//
//  welcome.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 13/12/23.
//

import UIKit

class welcome: UIViewController {

    var arr_brings:NSMutableArray! = []
    
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
    }
    
    @objc func reminders_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! welcome_table_cell
        
        if (cell.btn_reminders.tag == 0){
            cell.btn_reminders_check_box.setImage(UIImage(named: "check"), for: .normal)
            cell.btn_reminders.tag = 1
        } else {
            cell.btn_reminders_check_box.setImage(UIImage(named: "uncheck"), for: .normal)
            cell.btn_reminders.tag = 0
        }
        
    }
    
    @objc func diet_plan_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! welcome_table_cell
        
        if (cell.btn_diet_plan.tag == 0){
            cell.btn_diet_plan_check_box.setImage(UIImage(named: "check"), for: .normal)
            cell.btn_diet_plan.tag = 1
        } else {
            cell.btn_diet_plan_check_box.setImage(UIImage(named: "uncheck"), for: .normal)
            cell.btn_diet_plan.tag = 0
        }
        
    }
    
    // 2
    @objc func weight_loss__click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! welcome_table_cell
        
        if (cell.btn_weight_loss.tag == 0){
            cell.btn_weight_loss_check_box.setImage(UIImage(named: "check"), for: .normal)
            cell.btn_weight_loss.tag = 1
        } else {
            cell.btn_weight_loss_check_box.setImage(UIImage(named: "uncheck"), for: .normal)
            cell.btn_weight_loss.tag = 0
        }
        
    }
    
    @objc func muscle_gain_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! welcome_table_cell
        
        if (cell.btn_muscle_gain.tag == 0){
            cell.btn_muscle_gain_check_box.setImage(UIImage(named: "check"), for: .normal)
            cell.btn_muscle_gain.tag = 1
        } else {
            cell.btn_muscle_gain_check_box.setImage(UIImage(named: "uncheck"), for: .normal)
            cell.btn_muscle_gain.tag = 0
        }
        
    }
    
    // 5
    @objc func mean_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! welcome_table_cell
        
        if (cell.btn_meal.tag == 0){
            cell.btn_meal_check_box.setImage(UIImage(named: "check"), for: .normal)
            cell.btn_meal.tag = 1
        } else {
            cell.btn_meal_check_box.setImage(UIImage(named: "uncheck"), for: .normal)
            cell.btn_meal.tag = 0
        }
        
    }
    
    // 6
    @objc func count_calorie_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! welcome_table_cell
        
        if (cell.btn_count_calorie.tag == 0){
            cell.btn_count_calorie_check_box.setImage(UIImage(named: "check"), for: .normal)
            cell.btn_count_calorie.tag = 1
        } else {
            cell.btn_count_calorie_check_box.setImage(UIImage(named: "uncheck"), for: .normal)
            cell.btn_count_calorie.tag = 0
        }
        
    }
    
    
    // 7
    @objc func routine_track_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! welcome_table_cell
        
        if (cell.btn_routine_track.tag == 0){
            cell.btn_routine_track_check_box.setImage(UIImage(named: "check"), for: .normal)
            cell.btn_routine_track.tag = 1
        } else {
            cell.btn_routine_track_check_box.setImage(UIImage(named: "uncheck"), for: .normal)
            cell.btn_routine_track.tag = 0
        }
        
    }
    
    // 8
    @objc func workout_yoga_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! welcome_table_cell
        
        if (cell.btn_workout_yoga.tag == 0){
            cell.btn_workout_yoga_check_box.setImage(UIImage(named: "check"), for: .normal)
            cell.btn_workout_yoga.tag = 1
        } else {
            cell.btn_workout_yoga_check_box.setImage(UIImage(named: "uncheck"), for: .normal)
            cell.btn_workout_yoga.tag = 0
        }
        
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
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
    }

}


