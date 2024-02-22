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

// /* ************** SIDE BAR MENU ***************************** */
// /* ********************************************************** */
class side_bar_menu_table_cell : UITableViewCell {
    
    @IBOutlet weak var view_profile:UIView! {
        didSet {
            view_profile.backgroundColor = .clear
            
        }
    }
    
    @IBOutlet weak var img_profile:UIImageView! {
        didSet {
            img_profile.layer.cornerRadius = 30
            img_profile.clipsToBounds = true
            img_profile.layer.borderWidth = 0.8
            img_profile.layer.borderColor = UIColor.black.cgColor
        }
    }
    @IBOutlet weak var lbl_name:UILabel! {
        didSet {
            lbl_name.textColor = .white
        }
    }
    @IBOutlet weak var lbl_email:UILabel! {
        didSet {
            lbl_email.textColor = .white
        }
    }
    
    // # 1
    @IBOutlet weak var view_one:UIView! {
        didSet {
            view_one.backgroundColor = .clear
            
        }
    }
    
    @IBOutlet weak var btn_dashboard:UIButton! {
        didSet {
            btn_dashboard.backgroundColor = .white
            btn_dashboard.layer.cornerRadius = 12
        }
    }
    @IBOutlet weak var btn_friends:UIButton!  {
        didSet {
            btn_friends.backgroundColor = .white
            btn_friends.layer.cornerRadius = 12
        }
    }
    
    // # 2
    @IBOutlet weak var view_two:UIView! {
        didSet {
            view_two.backgroundColor = .clear
            
        }
    }
    @IBOutlet weak var btn_goal_setting:UIButton!    {
        didSet {
            btn_goal_setting.backgroundColor = .white
            btn_goal_setting.layer.cornerRadius = 12
        }
    }
    @IBOutlet weak var btn_reminders:UIButton!   {
        didSet {
            btn_reminders.backgroundColor = .white
            btn_reminders.layer.cornerRadius = 12
        }
    }
    
    // # 3
    @IBOutlet weak var view_three:UIView! {
        didSet {
            view_three.backgroundColor = .clear
            
        }
    }
    @IBOutlet weak var btn_workout_setting:UIButton!    {
        didSet {
            btn_workout_setting.backgroundColor = .white
            btn_workout_setting.layer.cornerRadius = 12
        }
    }
    @IBOutlet weak var btn_health_logs:UIButton!   {
        didSet {
            btn_health_logs.backgroundColor = .white
            btn_health_logs.layer.cornerRadius = 12
        }
    }
    
    // # 4
    @IBOutlet weak var view_four:UIView! {
        didSet {
            view_four.backgroundColor = .clear
            
        }
    }
    @IBOutlet weak var btn_chat:UIButton!    {
        didSet {
            btn_chat.backgroundColor = .white
            btn_chat.layer.cornerRadius = 12
        }
    }
    @IBOutlet weak var btn_trackers:UIButton!   {
        didSet {
            btn_trackers.backgroundColor = .white
            btn_trackers.layer.cornerRadius = 12
        }
    }
    
    
    // # 5
    @IBOutlet weak var view_five:UIView! {
        didSet {
            view_five.backgroundColor = .clear
            
        }
    }
    @IBOutlet weak var btn_search_friends:UIButton!    {
        didSet {
            btn_search_friends.backgroundColor = .white
            btn_search_friends.layer.cornerRadius = 12
        }
    }
    @IBOutlet weak var btn_music:UIButton!   {
        didSet {
            btn_music.backgroundColor = .white
            btn_music.layer.cornerRadius = 12
        }
    }
    
    // # 6
    @IBOutlet weak var view_six:UIView! {
        didSet {
            view_six.backgroundColor = .clear
            
        }
    }
    @IBOutlet weak var btn_edit_profile:UIButton!    {
        didSet {
            btn_edit_profile.backgroundColor = .white
            btn_edit_profile.layer.cornerRadius = 12
        }
    }
    @IBOutlet weak var btn_logout:UIButton!   {
        didSet {
            btn_logout.backgroundColor = .white
            btn_logout.layer.cornerRadius = 12
        }
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
    
    @IBOutlet weak var btn_continue:UIButton! {
        didSet {
            btn_continue.layer.cornerRadius = 8
            btn_continue.clipsToBounds = true
            btn_continue.setTitle("continue".uppercased(), for: .normal)
            btn_continue.setTitleColor(.white, for: .normal)
        }
    }
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
            txt_email.keyboardType = .emailAddress
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
            txt_phone.keyboardType = .phonePad
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
            txt_password.isSecureTextEntry = true
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
            txt_age.keyboardType = .numberPad
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
            txt_current_weight.placeholder = placeholder_current_weight
            txt_current_weight.setLeftPaddingPoints(20)
            txt_current_weight.keyboardType = .numberPad
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
            txt_target_weight.placeholder = placeholder_target_weight
            txt_target_weight.setLeftPaddingPoints(20)
            txt_target_weight.keyboardType = .numberPad
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
    
    @IBOutlet weak var btn_daily_activity:UIButton!
    @IBOutlet weak var btn_height:UIButton!
    
    @IBOutlet weak var lbl_height_select_popup:UILabel!
    @IBOutlet weak var lbl_height_message:UILabel!
    @IBOutlet weak var btn_height_select_popup:UIButton!
    
    @IBOutlet weak var btn_current_weight:UIButton!
    @IBOutlet weak var btn_target_weight:UIButton!
    
    @IBOutlet weak var lbl_current_weight_message:UILabel!
    @IBOutlet weak var lbl_target_weight_message:UILabel!
    
    @IBOutlet weak var lbl_current_weight_text:UILabel!
    @IBOutlet weak var lbl_target_weight_text:UILabel!
    
}

// /* ************** COMPLETE PROFILE 2 ************************* */
// /* ********************************************************** */
class complete_profile_two_table_cell : UITableViewCell {
    
    @IBOutlet weak var btn_fitness_goal:UIButton!
    @IBOutlet weak var btn_select_option:UIButton!
    
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
    
    @IBOutlet weak var btn_medicine_yes:UIButton!
    @IBOutlet weak var btn_medicine_no:UIButton!
    
    @IBOutlet weak var btn_smoke_yes:UIButton!
    @IBOutlet weak var btn_smoke_no:UIButton!
    @IBOutlet weak var btn_smoke_occasionally:UIButton!
    
    @IBOutlet weak var btn_drink_yes:UIButton!
    @IBOutlet weak var btn_drink_no:UIButton!
    @IBOutlet weak var btn_drink_occasionally:UIButton!
    
    @IBOutlet weak var lbl_diseases_names:UILabel!
    
    @IBOutlet weak var btn_clear:UIButton! {
        didSet {
            btn_clear.isHidden = true
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
    
    @IBOutlet weak var btn_food_prefrence:UIButton!
    
    @IBOutlet weak var btn_checkmark_breakfast:UIButton! {
        didSet {
            btn_checkmark_breakfast.setImage(UIImage(named: "uncheck"), for: .normal)
        }
    }
    @IBOutlet weak var btn_checkmark_morning_snack:UIButton!
    @IBOutlet weak var btn_checkmark_lunch:UIButton!
    @IBOutlet weak var btn_checkmark_evening_snack:UIButton!
    @IBOutlet weak var btn_checkmark_dinner:UIButton!
    
    
    @IBOutlet weak var lbl_checkmark_breakfast_time:UILabel! {
        didSet {
            lbl_checkmark_breakfast_time.textColor = UIColor.gray
            lbl_checkmark_breakfast_time.text = "disabled"
        }
    }
    
    @IBOutlet weak var lbl_checkmark_morning_snack_time:UILabel!  {
        didSet {
            lbl_checkmark_morning_snack_time.textColor = UIColor.gray
            lbl_checkmark_morning_snack_time.text = "disabled"
        }
    }
    @IBOutlet weak var lbl_checkmark_lunch_time:UILabel!  {
        didSet {
            lbl_checkmark_lunch_time.textColor = UIColor.gray
            lbl_checkmark_lunch_time.text = "disabled"
        }
    }
    @IBOutlet weak var lbl_checkmark_evening_snack_time:UILabel!  {
        didSet {
            lbl_checkmark_evening_snack_time.textColor = UIColor.gray
            lbl_checkmark_evening_snack_time.text = "disabled"
        }
    }
    @IBOutlet weak var lbl_checkmark_dinner_time:UILabel!  {
        didSet {
            lbl_checkmark_dinner_time.textColor = UIColor.gray
            lbl_checkmark_dinner_time.text = "disabled"
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

// /* ************** DASHBOARD ********************************* */
// /* ********************************************************** */
class dashboard_table_cell : UITableViewCell {
    
    @IBOutlet weak var view_profile_name:UIView! {
        didSet {
            view_profile_name.layer.cornerRadius = 12
            view_profile_name.clipsToBounds = true
            view_profile_name.backgroundColor = light_purple_color
        }
    }
    
    @IBOutlet weak var view_weight:UIView! {
        didSet {
            view_weight.layer.cornerRadius = 12
            view_weight.clipsToBounds = true
            view_weight.backgroundColor = .clear
        }
    }
    
    // profile view
    @IBOutlet weak var img_view_profile:UIImageView! {
        didSet {
            img_view_profile.layer.cornerRadius = 30
            img_view_profile.clipsToBounds = true
            img_view_profile.layer.borderWidth = 0.8
            img_view_profile.layer.borderColor = UIColor.gray.cgColor
        }
    }
    
    @IBOutlet weak var lbl_name:UILabel!
    @IBOutlet weak var lbl_email:UILabel!
   
    // weight
    @IBOutlet weak var lbl_weight:UILabel! {
        didSet {
            lbl_weight.textColor = .white
        }
    }
    @IBOutlet weak var lbl_weight_status:UILabel! {
        didSet {
            lbl_weight_status.textColor = .white
        }
    }
   
    @IBOutlet weak var view_nutrition:UIView! {
        didSet {
            view_nutrition.backgroundColor = dark_purple_color
            view_nutrition.layer.cornerRadius = 14
        }
    }
    
    @IBOutlet weak var view_protine:UIView! {
        didSet {
            view_protine.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var view_fats:UIView! {
        didSet {
            view_fats.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var view_carbs:UIView! {
        didSet {
            view_carbs.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var view_fiber:UIView! {
        didSet {
            view_fiber.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var btn_cal_burn:UIButton! {
        didSet {
            btn_cal_burn.layer.cornerRadius = 12
            btn_cal_burn.clipsToBounds = true
            btn_cal_burn.backgroundColor = light_purple_color
            btn_cal_burn.setTitleColor(.black, for: .normal)
            btn_cal_burn.setTitle("Cal Burnt", for: .normal)
        }
    }
    
    @IBOutlet weak var lbl_counter:UILabel!
     
    
    @IBOutlet weak var btn_track:UIButton! {
        didSet {
            btn_track.layer.cornerRadius = 12
            btn_track.clipsToBounds = true
            btn_track.backgroundColor = light_purple_color
            btn_track.setTitleColor(.black, for: .normal)
            btn_track.setTitle("Water Intake", for: .normal)
        }
    }
    
}


// /* ************** CALORIE INFORMATION ************************ */
// /* ********************************************************** */
class calorie_information_table_cell : UITableViewCell {
    
    @IBOutlet weak var view_calorie_budget:UIView! {
        didSet {
            view_calorie_budget.layer.cornerRadius = 8
            view_calorie_budget.clipsToBounds = true
            view_calorie_budget.backgroundColor = UIColor.init(red: 245.0/255.0, green: 236.0/255.0, blue: 255.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var lbl_recommended:UILabel!
    
    
    @IBOutlet weak var view_protien:UIView! {
        didSet {
            view_protien.layer.cornerRadius = 8
            view_protien.clipsToBounds = true
            view_protien.backgroundColor = UIColor.init(red: 245.0/255.0, green: 236.0/255.0, blue: 255.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var view_carb:UIView! {
        didSet {
            view_carb.layer.cornerRadius = 8
            view_carb.clipsToBounds = true
            view_carb.backgroundColor = UIColor.init(red: 245.0/255.0, green: 236.0/255.0, blue: 255.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var view_fat:UIView! {
        didSet {
            view_fat.layer.cornerRadius = 8
            view_fat.clipsToBounds = true
            view_fat.backgroundColor = UIColor.init(red: 245.0/255.0, green: 236.0/255.0, blue: 255.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var lbl_protien_percentage:UILabel! {
        didSet {
            lbl_protien_percentage.layer.cornerRadius = 12
            lbl_protien_percentage.clipsToBounds = true
            lbl_protien_percentage.backgroundColor = .white
        }
    }
    @IBOutlet weak var lbl_carb_percentage:UILabel! {
        didSet {
            lbl_carb_percentage.layer.cornerRadius = 12
            lbl_carb_percentage.clipsToBounds = true
            lbl_carb_percentage.backgroundColor = .white
        }
    }
    @IBOutlet weak var lbl_fat_percentage:UILabel! {
        didSet {
            lbl_fat_percentage.layer.cornerRadius = 12
            lbl_fat_percentage.clipsToBounds = true
            lbl_fat_percentage.backgroundColor = .white
        }
    }
    
    @IBOutlet weak var btn_calories_budget:UIButton!
}


// /* ************** EAT MEAL TIME ***************************** */
// /* ********************************************************** */
class eat_meal_time_table_cell : UITableViewCell {
    
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
    
    
    
   
    
}

// /* ************** edit meal and calories ******************** */
// /* ********************************************************** */
class edit_meals_and_calories_table_cell : UITableViewCell {
    
    @IBOutlet weak var view:UIView! {
        didSet {
            view.layer.cornerRadius = 8
            view.clipsToBounds = true
            view.backgroundColor = UIColor.init(red: 245.0/255.0, green: 236.0/255.0, blue: 255.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var view_bottom:UIView! {
        didSet {
            view_bottom.layer.cornerRadius = 8
            view_bottom.clipsToBounds = true
            view_bottom.backgroundColor = dark_purple_color
        }
    }
    
    @IBOutlet weak var lbl_break_fast_one:UILabel! {
        didSet {
            lbl_break_fast_one.backgroundColor = .white
            lbl_break_fast_one.layer.cornerRadius = 12
            lbl_break_fast_one.clipsToBounds = true
            lbl_break_fast_one.text = "25.0"
        }
    }
    
    @IBOutlet weak var lbl_morning_snack_one:UILabel! {
        didSet {
            lbl_morning_snack_one.backgroundColor = .white
            lbl_morning_snack_one.layer.cornerRadius = 12
            lbl_morning_snack_one.clipsToBounds = true
            lbl_morning_snack_one.text = "25.0"
        }
    }
    
    @IBOutlet weak var lbl_lunch_one:UILabel! {
        didSet {
            lbl_lunch_one.backgroundColor = .white
            lbl_lunch_one.layer.cornerRadius = 12
            lbl_lunch_one.clipsToBounds = true
            lbl_lunch_one.text = "25.0"
        }
    }
    
    @IBOutlet weak var lbl_evening_snack_one:UILabel! {
        didSet {
            lbl_evening_snack_one.backgroundColor = .white
            lbl_evening_snack_one.layer.cornerRadius = 12
            lbl_evening_snack_one.clipsToBounds = true
            lbl_evening_snack_one.text = "25.0"
        }
    }
    
    @IBOutlet weak var lbl_dinner_one:UILabel! {
        didSet {
            lbl_dinner_one.backgroundColor = .white
            lbl_dinner_one.layer.cornerRadius = 12
            lbl_dinner_one.clipsToBounds = true
            lbl_dinner_one.text = "25.0"
        }
    }
    
    // two
    @IBOutlet weak var lbl_break_fast_two:UILabel! {
        didSet {
            lbl_break_fast_two.backgroundColor = .clear
            lbl_break_fast_two.layer.cornerRadius = 12
            lbl_break_fast_two.clipsToBounds = true
            lbl_break_fast_two.text = "212"
        }
    }
    
    @IBOutlet weak var lbl_morning_snack_two:UILabel! {
        didSet {
            lbl_morning_snack_two.backgroundColor = .clear
            lbl_morning_snack_two.layer.cornerRadius = 12
            lbl_morning_snack_two.clipsToBounds = true
            lbl_morning_snack_two.text = "212"
        }
    }
    
    @IBOutlet weak var lbl_lunch_two:UILabel! {
        didSet {
            lbl_lunch_two.backgroundColor = .clear
            lbl_lunch_two.layer.cornerRadius = 12
            lbl_lunch_two.clipsToBounds = true
            lbl_lunch_two.text = "212"
        }
    }
    
    @IBOutlet weak var lbl_evening_snack_two:UILabel! {
        didSet {
            lbl_evening_snack_two.backgroundColor = .clear
            lbl_evening_snack_two.layer.cornerRadius = 12
            lbl_evening_snack_two.clipsToBounds = true
            lbl_evening_snack_two.text = "212"
        }
    }
    
    @IBOutlet weak var lbl_dinner_two:UILabel! {
        didSet {
            lbl_dinner_two.backgroundColor = .clear
            lbl_dinner_two.layer.cornerRadius = 12
            lbl_dinner_two.clipsToBounds = true
            lbl_dinner_two.text = "212"
        }
    }
    
}


// /* ************** edit meal and calories ******************** */
// /* ********************************************************** */
class track_meal_reminder_table_cell : UITableViewCell {
    
    @IBOutlet weak var lbl_breakfast:UILabel! {
        didSet {
            lbl_breakfast.backgroundColor = .clear
        }
    }
    @IBOutlet weak var lbl_morning_snack:UILabel! {
        didSet {
            lbl_morning_snack.backgroundColor = .clear
        }
    }
    @IBOutlet weak var lbl_lunch:UILabel! {
        didSet {
            lbl_lunch.backgroundColor = .clear
        }
    }
    @IBOutlet weak var lbl_evening_snack:UILabel! {
        didSet {
            lbl_evening_snack.backgroundColor = .clear
        }
    }
    @IBOutlet weak var lbl_dinner:UILabel! {
        didSet {
            lbl_dinner.backgroundColor = .clear
        }
    }
    
}

// /* ************** WATER INTAKE ****************************** */
// /* ********************************************************** */
class water_intake_table_cell : UITableViewCell {
    
    @IBOutlet weak var view_glass:UIView! {
        didSet {
            view_glass.layer.cornerRadius = 8
            view_glass.clipsToBounds = true
            view_glass.backgroundColor = UIColor.init(red: 245.0/255.0, green: 236.0/255.0, blue: 255.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var lbl_water_glass_count:UILabel!
    
    @IBOutlet weak var view_glass_measure:UIView! {
        didSet {
            view_glass_measure.layer.cornerRadius = 8
            view_glass_measure.clipsToBounds = true
            view_glass_measure.backgroundColor = UIColor.init(red: 245.0/255.0, green: 236.0/255.0, blue: 255.0/255.0, alpha: 1)
        }
    }
    
    //
    @IBOutlet weak var view_reminder:UIView! {
        didSet {
            view_reminder.layer.cornerRadius = 8
            view_reminder.clipsToBounds = true
            view_reminder.backgroundColor = UIColor.init(red: 245.0/255.0, green: 236.0/255.0, blue: 255.0/255.0, alpha: 1)
        }
    }
    //
    @IBOutlet weak var btn_reminder:UIButton!
    @IBOutlet weak var btn_water_count_edit:UIButton!
    
}

// /* ************** WATER TRACKER ***************************** */
// /* ********************************************************** */
class water_tracker_table_cell : UITableViewCell {
    
    @IBOutlet weak var view_counter:UIView! {
        didSet {
            view_counter.layer.cornerRadius = 8
            view_counter.clipsToBounds = true
            view_counter.backgroundColor = UIColor.init(red: 245.0/255.0, green: 236.0/255.0, blue: 255.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var view_digits_counter:UIView! {
        didSet {
            view_digits_counter.layer.cornerRadius = 12
            view_digits_counter.clipsToBounds = true
            view_digits_counter.backgroundColor = .white
        }
    }
    
}

// /* ************** WATER REMINDER ***************************** */
// /* ********************************************************** */
class water_reminder_table_cell : UITableViewCell {

    @IBOutlet weak var btn_set_reminders:UIButton! {
        didSet {
            btn_set_reminders.layer.cornerRadius = 8
            btn_set_reminders.clipsToBounds = true
            btn_set_reminders.setTitle("Set Reminders", for: .normal)
            btn_set_reminders.setTitleColor(.white, for: .normal)
        }
    }
    
}

    
// /* ************** SEARCH FRIEND ************************* */
// /* ********************************************************** */
class invite_friends_table_cell : UITableViewCell {
    
    @IBOutlet weak var img_profile:UIImageView! {
        didSet {
            img_profile.layer.cornerRadius = 25
            img_profile.clipsToBounds = true
        }
    }
    @IBOutlet weak var lbl_title:UILabel!
    @IBOutlet weak var lbl_sub_title:UILabel!
}

// /* ************************* FRIEND ************************* */
// /* ********************************************************** */
class friends_table_cell : UITableViewCell {
    @IBOutlet weak var img_profile:UIImageView! {
        didSet {
            img_profile.layer.cornerRadius = 25
            img_profile.clipsToBounds = true
        }
    }
    @IBOutlet weak var lbl_title:UILabel!
    @IBOutlet weak var lbl_sub_title:UILabel!
}
// /* ************************* REMINDERS ********************** */
// /* ********************************************************** */
class reminders_table_cell : UITableViewCell {
    @IBOutlet weak var lbl_title:UILabel!
    @IBOutlet weak var lbl_sub_title:UILabel!
    @IBOutlet weak var btn_edit:UIButton!
}
// /* ************************* WORKOUT SETTINGS ************** */
// /* ********************************************************** */
class workout_setting_table_cell : UITableViewCell {
    @IBOutlet weak var lbl_title:UILabel!
}
// /* ******************* DAYS WORKOUT ************************* */
// /* ********************************************************** */
class days_workout_table_cell : UITableViewCell {
    @IBOutlet weak var lbl_title:UILabel!
}
// /* ******************* PERSONALISE WORKOUT ******************* */
// /* ********************************************************** */
class personalized_workout_table_cell : UITableViewCell {
    @IBOutlet weak var lbl_title:UILabel!
}
// /* ******************* PERSONALISE DAY ******************* */
// /* ********************************************************** */
class personalize_day_table_cell : UITableViewCell {
    @IBOutlet weak var lbl_title:UILabel!
    
    @IBOutlet weak var btn_yoga:UIButton! {
        didSet {
            btn_yoga.backgroundColor = light_pink_color
            btn_yoga.setTitle("Yoga", for: .normal)
            btn_yoga.setTitleColor(.black, for: .normal)
            btn_yoga.layer.cornerRadius = 12
            btn_yoga.clipsToBounds = true
        }
    }
    @IBOutlet weak var btn_gym:UIButton! {
        didSet {
            btn_gym.backgroundColor = light_pink_color
            btn_gym.setTitle("Gym", for: .normal)
            btn_gym.setTitleColor(.black, for: .normal)
            btn_gym.layer.cornerRadius = 12
            btn_gym.clipsToBounds = true
        }
    }
    @IBOutlet weak var btn_cardio:UIButton! {
        didSet {
            btn_cardio.backgroundColor = light_pink_color
            btn_cardio.setTitle("Cardio", for: .normal)
            btn_cardio.setTitleColor(.black, for: .normal)
            btn_cardio.layer.cornerRadius = 12
            btn_cardio.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var btn_strength:UIButton!  {
        didSet {
            btn_strength.backgroundColor = light_pink_color
            btn_strength.setTitle("Strength", for: .normal)
            btn_strength.setTitleColor(.black, for: .normal)
            btn_strength.layer.cornerRadius = 12
            btn_strength.clipsToBounds = true
        }
    }
    @IBOutlet weak var btn_sports:UIButton!  {
        didSet {
            btn_sports.backgroundColor = light_pink_color
            btn_sports.setTitle("Sports", for: .normal)
            btn_sports.setTitleColor(.black, for: .normal)
            btn_sports.layer.cornerRadius = 12
            btn_sports.clipsToBounds = true
        }
    }
    @IBOutlet weak var btn_none:UIButton!  {
        didSet {
            btn_none.backgroundColor = light_pink_color
            btn_none.setTitle("None", for: .normal)
            btn_none.setTitleColor(.black, for: .normal)
            btn_none.layer.cornerRadius = 12
            btn_none.clipsToBounds = true
        }
    }
    
    // 2
    @IBOutlet weak var btn_45:UIButton!  {
        didSet {
            btn_45.backgroundColor = light_pink_color
            btn_45.setTitle("45 Min", for: .normal)
            btn_45.setTitleColor(.black, for: .normal)
            btn_45.layer.cornerRadius = 12
            btn_45.clipsToBounds = true
        }
    }
    @IBOutlet weak var btn_60:UIButton!  {
        didSet {
            btn_60.backgroundColor = light_pink_color
            btn_60.setTitle("60 Min", for: .normal)
            btn_60.setTitleColor(.black, for: .normal)
            btn_60.layer.cornerRadius = 12
            btn_60.clipsToBounds = true
        }
    }
    @IBOutlet weak var btn_90:UIButton!  {
        didSet {
            btn_90.backgroundColor = light_pink_color
            btn_90.setTitle("90 Min", for: .normal)
            btn_90.setTitleColor(.black, for: .normal)
            btn_90.layer.cornerRadius = 12
            btn_90.clipsToBounds = true
        }
    }
    
    // 3
    @IBOutlet weak var btn_morning:UIButton!  {
        didSet {
            btn_morning.backgroundColor = light_pink_color
            btn_morning.setTitle("Morning", for: .normal)
            btn_morning.setTitleColor(.black, for: .normal)
            btn_morning.layer.cornerRadius = 12
            btn_morning.clipsToBounds = true
        }
    }
    @IBOutlet weak var btn_evening:UIButton!  {
        didSet {
            btn_evening.backgroundColor = light_pink_color
            btn_evening.setTitle("Evening", for: .normal)
            btn_evening.setTitleColor(.black, for: .normal)
            btn_evening.layer.cornerRadius = 12
            btn_evening.clipsToBounds = true
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
}
// /* ************** SELECT WORKOUT **************************** */
// /* ********************************************************** */
class select_workout_table_cell : UITableViewCell {
    
    @IBOutlet weak var img_profile:UIImageView! {
        didSet {
            img_profile.layer.cornerRadius = 25
            img_profile.clipsToBounds = true
        }
    }
    @IBOutlet weak var lbl_title:UILabel!
    @IBOutlet weak var lbl_sub_title:UILabel!
    
    
}
// /* ************** WORKOUT DETAILS *************************** */
// /* ********************************************************** */
class workout_details_table_cell : UITableViewCell {
    
    @IBOutlet weak var view_view:UIView! {
        didSet {
            view_view.layer.cornerRadius = 16
            view_view.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var view_reps:UIView! {
        didSet {
            view_reps.layer.cornerRadius = 16
            view_reps.clipsToBounds = true
            view_reps.backgroundColor = light_pink_color
        }
    }
    
    @IBOutlet weak var lbl_reps:UILabel! {
        didSet {
            lbl_reps.layer.cornerRadius = 8
            lbl_reps.clipsToBounds = true
        }
    }
    @IBOutlet weak var view_sets:UIView! {
        didSet {
            view_sets.layer.cornerRadius = 16
            view_sets.clipsToBounds = true
            view_sets.backgroundColor = light_pink_color
        }
    }
    
    @IBOutlet weak var lbl_sets:UILabel! {
        didSet {
            lbl_sets.layer.cornerRadius = 8
            lbl_sets.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var lbl_description:UILabel! {
        didSet {
            lbl_description.text = "Lorem Ipsum is simply dummy text of the printing and type setting industry. Lorem Ipsum is simply dummy text of the printing and type setting industry."
        }
    }
    
    @IBOutlet weak var btn_continue:UIButton! {
        didSet {
            btn_continue.layer.cornerRadius = 8
            btn_continue.clipsToBounds = true
            btn_continue.setTitle("save".uppercased(), for: .normal)
            btn_continue.setTitleColor(.white, for: .normal)
        }
    }
}

class disease_list_table_cell : UITableViewCell {
    
    @IBOutlet weak var lbl_disease_name:UILabel!
    
    @IBOutlet weak var btn_checkmark:UIButton!
    
}
