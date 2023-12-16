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

// /* ************** CREATE AN ACCOUNT ************************* */
// /* ********************************************************** */
class create_an_account_table_cell : UITableViewCell {
    
    @IBOutlet weak var txt_name:UITextField! {
        didSet {
            txt_name.layer.cornerRadius = 8
            txt_name.clipsToBounds = true
            txt_name.backgroundColor = .clear
            txt_name.placeholder = "name"
            txt_name.setLeftPaddingPoints(20)
        }
    }
    @IBOutlet weak var view_name:UIView! {
        didSet {
            view_name.layer.cornerRadius = 8
            view_name.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var txt_email:UITextField! {
        didSet {
            txt_email.layer.cornerRadius = 8
            txt_email.clipsToBounds = true
            txt_email.backgroundColor = .clear
            txt_email.placeholder = "email"
            txt_email.setLeftPaddingPoints(20)
        }
    }
    
    @IBOutlet weak var view_email:UIView! {
        didSet {
            view_email.layer.cornerRadius = 8
            view_email.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var txt_phone:UITextField! {
        didSet {
            txt_phone.layer.cornerRadius = 8
            txt_phone.clipsToBounds = true
            txt_phone.backgroundColor = .clear
            txt_phone.placeholder = "phone"
            txt_phone.setLeftPaddingPoints(20)
        }
    }
    
    @IBOutlet weak var view_phone:UIView! {
        didSet {
            view_phone.layer.cornerRadius = 8
            view_phone.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var txt_password:UITextField! {
        didSet {
            txt_password.layer.cornerRadius = 8
            txt_password.clipsToBounds = true
            txt_password.backgroundColor = .clear
            txt_password.placeholder = "password"
            txt_password.setLeftPaddingPoints(20)
        }
    }
    
    @IBOutlet weak var view_asswprd:UIView! {
        didSet {
            view_asswprd.layer.cornerRadius = 8
            view_asswprd.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var btn_create_an_account:UIButton! {
        didSet {
            btn_create_an_account.layer.cornerRadius = 8
            btn_create_an_account.clipsToBounds = true
            btn_create_an_account.setTitle("Create an account", for: .normal)
            btn_create_an_account.setTitleColor(.white, for: .normal)
        }
    }
    
}


// /* ************** COMPLETE PROFILE ************************* */
// /* ********************************************************** */
class complete_profile_table_cell : UITableViewCell {
    
    @IBOutlet weak var btn_male:UIButton! {
        didSet {
            btn_male.layer.cornerRadius = 8
            btn_male.clipsToBounds = true
            btn_male.setTitle("Male", for: .normal)
        }
    }
    
    @IBOutlet weak var btn_female:UIButton! {
        didSet {
            btn_female.layer.cornerRadius = 8
            btn_female.clipsToBounds = true
            btn_female.setTitle("Female", for: .normal)
        }
    }
    
    @IBOutlet weak var btn_other:UIButton! {
        didSet {
            btn_other.layer.cornerRadius = 8
            btn_other.clipsToBounds = true
            btn_other.setTitle("Other", for: .normal)
        }
    }
     
    // textfield
    @IBOutlet weak var view_age:UIView! {
        didSet {
            view_age.layer.cornerRadius = 8
            view_age.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var txt_age:UITextField! {
        didSet {
            txt_age.layer.cornerRadius = 8
            txt_age.clipsToBounds = true
            txt_age.backgroundColor = .clear
            txt_age.placeholder = "age"
            txt_age.setLeftPaddingPoints(20)
        }
    }
    
    // daily activity
    @IBOutlet weak var view_daily_activity:UIView! {
        didSet {
            view_daily_activity.layer.cornerRadius = 8
            view_daily_activity.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var txt_daily_activity:UITextField! {
        didSet {
            txt_daily_activity.layer.cornerRadius = 8
            txt_daily_activity.clipsToBounds = true
            txt_daily_activity.backgroundColor = .clear
            txt_daily_activity.placeholder = "Daily Activity"
            txt_daily_activity.setLeftPaddingPoints(20)
        }
    }
    
    // height
    @IBOutlet weak var view_height:UIView! {
        didSet {
            view_height.layer.cornerRadius = 8
            view_height.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var view_height_measure:UIView! {
        didSet {
            view_height_measure.layer.cornerRadius = 16
            view_height_measure.clipsToBounds = true
            view_height_measure.layer.borderColor = UIColor.black.cgColor
            view_height_measure.layer.borderWidth = 0.8
            view_height_measure.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var txt_height:UITextField! {
        didSet {
            txt_height.layer.cornerRadius = 8
            txt_height.clipsToBounds = true
            txt_height.backgroundColor = .clear
            txt_height.placeholder = "Height"
            txt_height.setLeftPaddingPoints(20)
        }
    }
    
    // height
    @IBOutlet weak var view_current_weight:UIView! {
        didSet {
            view_current_weight.layer.cornerRadius = 8
            view_current_weight.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var view_current_weight_measure:UIView! {
        didSet {
            view_current_weight_measure.layer.cornerRadius = 16
            view_current_weight_measure.clipsToBounds = true
            view_current_weight_measure.layer.borderColor = UIColor.black.cgColor
            view_current_weight_measure.layer.borderWidth = 0.8
            view_current_weight_measure.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var txt_current_weight:UITextField! {
        didSet {
            txt_current_weight.layer.cornerRadius = 8
            txt_current_weight.clipsToBounds = true
            txt_current_weight.backgroundColor = .clear
            txt_current_weight.placeholder = "Current Weight"
            txt_current_weight.setLeftPaddingPoints(20)
        }
    }
    
    // target weight
    @IBOutlet weak var view_target_weight:UIView! {
        didSet {
            view_target_weight.layer.cornerRadius = 8
            view_target_weight.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var view_target_weight_measure:UIView! {
        didSet {
            view_target_weight_measure.layer.cornerRadius = 16
            view_target_weight_measure.clipsToBounds = true
            view_target_weight_measure.layer.borderColor = UIColor.black.cgColor
            view_target_weight_measure.layer.borderWidth = 0.8
            view_target_weight_measure.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var txt_target_weight:UITextField! {
        didSet {
            txt_target_weight.layer.cornerRadius = 8
            txt_target_weight.clipsToBounds = true
            txt_target_weight.backgroundColor = .clear
            txt_target_weight.placeholder = "Target Weight"
            txt_target_weight.setLeftPaddingPoints(20)
        }
    }
    
    // emotinal health
    @IBOutlet weak var view_emotinal_health:UIView! {
        didSet {
            view_emotinal_health.layer.cornerRadius = 8
            view_emotinal_health.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var txt_emotional_health:UITextField! {
        didSet {
            txt_emotional_health.layer.cornerRadius = 8
            txt_emotional_health.clipsToBounds = true
            txt_emotional_health.backgroundColor = .clear
            txt_emotional_health.placeholder = "Emotional Health"
            txt_emotional_health.setLeftPaddingPoints(20)
        }
    }
    
    @IBOutlet weak var btn_continue:UIButton! {
        didSet {
            btn_continue.layer.cornerRadius = 8
            btn_continue.clipsToBounds = true
            btn_continue.setTitle("Continue", for: .normal)
            btn_continue.setTitleColor(.white, for: .normal)
        }
    }
    
}

// /* ************** COMPLETE PROFILE 2 ************************* */
// /* ********************************************************** */
class complete_profile_two_table_cell : UITableViewCell {
    
    // emotinal health
    @IBOutlet weak var view_fitness_goal:UIView! {
        didSet {
            view_fitness_goal.layer.cornerRadius = 8
            view_fitness_goal.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var txt_fitness_goal:UITextField! {
        didSet {
            txt_fitness_goal.layer.cornerRadius = 8
            txt_fitness_goal.clipsToBounds = true
            txt_fitness_goal.backgroundColor = .clear
            txt_fitness_goal.placeholder = "Fitness Goal"
            txt_fitness_goal.setLeftPaddingPoints(20)
        }
    }
    
    
    // emotinal health
    @IBOutlet weak var view_select_option:UIView! {
        didSet {
            view_select_option.layer.cornerRadius = 8
            view_select_option.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var txt_select_option:UITextField! {
        didSet {
            txt_select_option.layer.cornerRadius = 8
            txt_select_option.clipsToBounds = true
            txt_select_option.backgroundColor = .clear
            txt_select_option.placeholder = "Select Option"
            txt_select_option.setLeftPaddingPoints(20)
        }
    }
    
    @IBOutlet weak var btn_continue:UIButton! {
        didSet {
            btn_continue.layer.cornerRadius = 8
            btn_continue.clipsToBounds = true
            btn_continue.setTitle("Continue", for: .normal)
            btn_continue.setTitleColor(.white, for: .normal)
        }
    }
    
    
}


// /* ************** COMPLETE PROFILE 3 ************************* */
// /* ********************************************************** */
class complete_profile_three_table_cell : UITableViewCell {
    
    // emotinal health
    @IBOutlet weak var view_food_preferences:UIView! {
        didSet {
            view_food_preferences.layer.cornerRadius = 8
            view_food_preferences.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var txt_food_preferences:UITextField! {
        didSet {
            txt_food_preferences.layer.cornerRadius = 8
            txt_food_preferences.clipsToBounds = true
            txt_food_preferences.backgroundColor = .clear
            txt_food_preferences.placeholder = "Food preferences"
            txt_food_preferences.setLeftPaddingPoints(20)
        }
    }
    
    
    @IBOutlet weak var view_breakfast:UIView! {
        didSet {
            view_breakfast.layer.cornerRadius = 8
            view_breakfast.clipsToBounds = true
            view_breakfast.backgroundColor = UIColor.init(red: 245.0/255.0, green: 236.0/255.0, blue: 255.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var view_morning_snack:UIView! {
        didSet {
            view_morning_snack.layer.cornerRadius = 8
            view_morning_snack.clipsToBounds = true
            view_morning_snack.backgroundColor = UIColor.init(red: 245.0/255.0, green: 236.0/255.0, blue: 255.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var view_lunch:UIView! {
        didSet {
            view_lunch.layer.cornerRadius = 8
            view_lunch.clipsToBounds = true
            view_lunch.backgroundColor = UIColor.init(red: 245.0/255.0, green: 236.0/255.0, blue: 255.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var view_evening_snack:UIView! {
        didSet {
            view_evening_snack.layer.cornerRadius = 8
            view_evening_snack.clipsToBounds = true
            view_evening_snack.backgroundColor = UIColor.init(red: 245.0/255.0, green: 236.0/255.0, blue: 255.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var view_dinner:UIView! {
        didSet {
            view_dinner.layer.cornerRadius = 8
            view_dinner.clipsToBounds = true
            view_dinner.backgroundColor = UIColor.init(red: 245.0/255.0, green: 236.0/255.0, blue: 255.0/255.0, alpha: 1)
        }
    }
    
    
    
    @IBOutlet weak var btn_continue:UIButton! {
        didSet {
            btn_continue.layer.cornerRadius = 8
            btn_continue.clipsToBounds = true
            btn_continue.setTitle("Continue", for: .normal)
            btn_continue.setTitleColor(.white, for: .normal)
        }
    }
    
}



// /* ************** BREAKFAST FOOD (((************************* */
// /* ********************************************************** */
class breakfast_food_table_cell : UITableViewCell {
    
    @IBOutlet weak var lbl_title:UILabel!
    @IBOutlet weak var lbl_sub_title:UILabel!
    @IBOutlet weak var lbl_cal_count:UILabel!
    @IBOutlet weak var btn_add:UIButton!
}
