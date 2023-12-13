//
//  table_cells.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 13/12/23.
//

import UIKit

class table_cells: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// /* ************** WELCOME ************************* */
// /* ************************************************ */

class welcome_table_cell : UITableViewCell {
    
    @IBOutlet weak var btn_reminders:UIButton! {
        didSet {
            btn_reminders.tag = 0
            btn_reminders.layer.cornerRadius = 14
            btn_reminders.clipsToBounds = true
            btn_reminders.setBackgroundImage(UIImage(named: "blue"), for: .normal)
        }
    }
    @IBOutlet weak var btn_diet_plan:UIButton! {
        didSet {
            btn_diet_plan.tag = 0
            btn_diet_plan.layer.cornerRadius = 14
            btn_diet_plan.clipsToBounds = true
            btn_diet_plan.setBackgroundImage(UIImage(named: "blue"), for: .normal)
        }
    }
    
    @IBOutlet weak var btn_reminders_check_box:UIButton!
    @IBOutlet weak var btn_diet_plan_check_box:UIButton!
    
    // 2
    @IBOutlet weak var btn_weight_loss:UIButton! {
        didSet {
            btn_weight_loss.tag = 0
            btn_weight_loss.layer.cornerRadius = 14
            btn_weight_loss.clipsToBounds = true
            btn_weight_loss.setBackgroundImage(UIImage(named: "blue"), for: .normal)
            btn_weight_loss.setTitle("Weight Loss", for: .normal)
        }
    }
    @IBOutlet weak var btn_muscle_gain:UIButton! {
        didSet {
            btn_muscle_gain.tag = 0
            btn_muscle_gain.layer.cornerRadius = 14
            btn_muscle_gain.clipsToBounds = true
            btn_muscle_gain.setBackgroundImage(UIImage(named: "blue"), for: .normal)
            btn_muscle_gain.setTitle("Muscle Gain", for: .normal)
        }
    }
    
    @IBOutlet weak var btn_weight_loss_check_box:UIButton!
    @IBOutlet weak var btn_muscle_gain_check_box:UIButton!
    
    // 3
    @IBOutlet weak var btn_meal:UIButton! {
        didSet {
            btn_meal.tag = 0
            btn_meal.layer.cornerRadius = 14
            btn_meal.clipsToBounds = true
            btn_meal.setBackgroundImage(UIImage(named: "blue"), for: .normal)
            btn_meal.setTitle("Meal", for: .normal)
        }
    }
    @IBOutlet weak var btn_count_calorie:UIButton! {
        didSet {
            btn_count_calorie.tag = 0
            btn_count_calorie.layer.cornerRadius = 14
            btn_count_calorie.clipsToBounds = true
            btn_count_calorie.setBackgroundImage(UIImage(named: "blue"), for: .normal)
            btn_count_calorie.setTitle("Count Calorie", for: .normal)
        }
    }
    
    @IBOutlet weak var btn_meal_check_box:UIButton!
    @IBOutlet weak var btn_count_calorie_check_box:UIButton!
    
    // 4
    @IBOutlet weak var btn_routine_track:UIButton! {
        didSet {
            btn_routine_track.tag = 0
            btn_routine_track.layer.cornerRadius = 14
            btn_routine_track.clipsToBounds = true
            btn_routine_track.setBackgroundImage(UIImage(named: "blue"), for: .normal)
            btn_routine_track.setTitle("Routine Track", for: .normal)
        }
    }
    @IBOutlet weak var btn_workout_yoga:UIButton! {
        didSet {
            btn_workout_yoga.tag = 0
            btn_workout_yoga.layer.cornerRadius = 14
            btn_workout_yoga.clipsToBounds = true
            btn_workout_yoga.setBackgroundImage(UIImage(named: "blue"), for: .normal)
            btn_workout_yoga.setTitle("Workout / Yoga", for: .normal)
        }
    }
    
    @IBOutlet weak var btn_routine_track_check_box:UIButton!
    @IBOutlet weak var btn_workout_yoga_check_box:UIButton!
    
}

// /* ************** WELCOME ************************* */
// /* ************************************************ */
