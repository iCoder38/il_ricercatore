//
//  table_cells.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 13/12/23.
//

import UIKit
import DGCharts

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
class all_post_table_cell : UITableViewCell {
    
    
    
    @IBOutlet weak var btn_daily_q:UIButton! {
        didSet {
            btn_daily_q.layer.cornerRadius = 12
            btn_daily_q.clipsToBounds = true
            btn_daily_q.backgroundColor = light_purple_color
            btn_daily_q.setTitleColor(.black, for: .normal)
            btn_daily_q.setTitle("Daily Q", for: .normal)
        }
    }
    
    @IBOutlet weak var btn_article:UIButton! {
        didSet {
            btn_article.layer.cornerRadius = 12
            btn_article.clipsToBounds = true
            btn_article.backgroundColor = light_purple_color
            btn_article.setTitleColor(.black, for: .normal)
            btn_article.setTitle("Articles", for: .normal)
        }
    }
    
    @IBOutlet weak var btn_stories:UIButton! {
        didSet {
            btn_stories.layer.cornerRadius = 12
            btn_stories.clipsToBounds = true
            btn_stories.backgroundColor = light_purple_color
            btn_stories.setTitleColor(.black, for: .normal)
            btn_stories.setTitle("Stories", for: .normal)
        }
    }
    
    @IBOutlet weak var btn_forum:UIButton! {
        didSet {
            btn_forum.layer.cornerRadius = 12
            btn_forum.clipsToBounds = true
            btn_forum.backgroundColor = light_purple_color
            btn_forum.setTitleColor(.black, for: .normal)
            // btn_forum.setTitle("Forum", for: .normal)
        }
    }
    
    @IBOutlet weak var btn_milestones:UIButton! {
        didSet {
            btn_milestones.layer.cornerRadius = 12
            btn_milestones.clipsToBounds = true
            btn_milestones.backgroundColor = light_purple_color
            btn_milestones.setTitleColor(.black, for: .normal)
            btn_milestones.setTitle("Forum", for: .normal)
        }
    }
    @IBOutlet weak var btn_faq:UIButton! {
        didSet {
            btn_faq.layer.cornerRadius = 12
            btn_faq.clipsToBounds = true
            btn_faq.backgroundColor = light_purple_color
            btn_faq.setTitleColor(.black, for: .normal)
            btn_faq.setTitle("FAQ", for: .normal)
        }
    }
    
}

// /* ************** COMPLETE PROFILE ************************* */
// /* ********************************************************** */
class post_details_table_cell : UITableViewCell {
    @IBOutlet weak var img_profile:UIImageView! {
        didSet {
            img_profile.layer.cornerRadius = 12
            img_profile.clipsToBounds = true
        }
    }
    @IBOutlet weak var btn_play:UIButton!
    @IBOutlet weak var lbl_title:UILabel!
    @IBOutlet weak var lbl_comments_likes:UILabel!
    @IBOutlet weak var lbl_description:UILabel!
    
    @IBOutlet weak var btn_like:UIButton!
    @IBOutlet weak var btn_comment:UIButton!
    @IBOutlet weak var btn_share:UIButton!
}
// /* ************** COMPLETE PROFILE ************************* */
// /* ********************************************************** */
class comments_table_cell : UITableViewCell {
    @IBOutlet weak var img_profile:UIImageView! {
        didSet {
            img_profile.layer.cornerRadius = 12
            img_profile.clipsToBounds = true
        }
    }
    @IBOutlet weak var lbl_name:UILabel!
    @IBOutlet weak var lbl_time:UILabel!
    @IBOutlet weak var lbl_message:UILabel!
}

// /* ************** DAILY Q ************************* */
// /* ********************************************************** */
class daily_q_table_cell : UITableViewCell {
    
    @IBOutlet weak var view_cell_BG:UIView! {
        didSet {
            view_cell_BG.layer.masksToBounds = false
            view_cell_BG.layer.shadowColor =  UIColor.white.cgColor
            view_cell_BG.layer.shadowOffset = CGSize(width: 0, height: 1)
            view_cell_BG.layer.shadowRadius = 5.0
            view_cell_BG.layer.shadowOpacity = 15.0
            view_cell_BG.layer.cornerRadius = 5.0
        }
    }
    
    @IBOutlet weak var view_video:UIView!  {
        didSet {
            view_video.backgroundColor = .systemGray5
            view_video.layer.cornerRadius = 12
            // view_video.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var lbl_title:UILabel!
    @IBOutlet weak var lbl_sub_title:UILabel!
    
    @IBOutlet weak var lbl_comments_like:UILabel!
    
    @IBOutlet weak var btn_play:UIButton!
    @IBOutlet weak var btn_read_more:UIButton!
    @IBOutlet weak var img_profile:UIImageView! {
        didSet {
            img_profile.layer.cornerRadius = 12
            img_profile.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var btn_like:UIButton!
    @IBOutlet weak var btn_comment:UIButton!
    @IBOutlet weak var btn_share:UIButton!
    
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
            txt_height.keyboardType = .numberPad
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
    @IBOutlet weak var btn_height:UIButton! {
        didSet {
            btn_height.isHidden = true
        }
    }
    
    @IBOutlet weak var lbl_height_select_popup:UILabel! {
        didSet {
            lbl_height_select_popup.text = "cm"
        }
    }
    
    @IBOutlet weak var lbl_height_message:UILabel! {
        didSet {
            lbl_height_message.isHidden = true
        }
    }
    
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





class meal_track_table_cell : UITableViewCell {
    
    
    
    
    @IBOutlet weak var lbl_time:UILabel! {
        didSet {
            lbl_time.text = Date.getCurrentDateCustom()
        }
    }
    @IBOutlet weak var view_milk:UIView!
    @IBOutlet weak var btn_date:UIButton!
    
    @IBOutlet weak var btn_breakfast:UIButton!
    @IBOutlet weak var btn_morning_snack:UIButton!
    @IBOutlet weak var btn_lunch:UIButton!
    @IBOutlet weak var btn_evening_snack:UIButton!
    @IBOutlet weak var btn_dinner:UIButton!
    
    @IBOutlet weak var lbl_title:UILabel!
    @IBOutlet weak var lbl_sub_title:UILabel!
    @IBOutlet weak var lbl_cal:UILabel!
}


// /* ************** DASHBOARD ********************************* */
// /* ********************************************************** */
class dashboard_table_cell : UITableViewCell {
    
    
    
    
    
    
    
    
    
    @IBOutlet weak var lbl_cal_eaten:UILabel!
    
    @IBOutlet weak var lbl_exc_count:UILabel!
    
    @IBOutlet weak var btn_edit:UIButton!
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
    
    @IBOutlet weak var image_view:UIView! {
        didSet {
            image_view.layer.cornerRadius = 12
            image_view.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var scrollView:UIScrollView!
    
    @IBOutlet weak var btn_exc_right_arrow:UIButton!
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    @IBOutlet weak var btn_cal_burn:UIButton! {
        didSet {
            btn_cal_burn.layer.cornerRadius = 12
            btn_cal_burn.clipsToBounds = true
            btn_cal_burn.backgroundColor = light_purple_color
            btn_cal_burn.setTitleColor(.black, for: .normal)
            btn_cal_burn.setTitle("Cal Burn", for: .normal)
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
    
    @IBOutlet weak var lbl_protein:UILabel!
    @IBOutlet weak var lbl_fat:UILabel!
    @IBOutlet weak var lbl_curbs:UILabel!
    @IBOutlet weak var lbl_fiber:UILabel!
    
    @IBOutlet weak var progress_view_protein:UIProgressView!
    @IBOutlet weak var progress_view_fats:UIProgressView!
    @IBOutlet weak var progress_view_curbs:UIProgressView!
    @IBOutlet weak var progress_view_fiber:UIProgressView!
    
    @IBOutlet weak var btn_sleep:UIButton! {
        didSet {
            btn_sleep.layer.cornerRadius = 12
            btn_sleep.clipsToBounds = true
            btn_sleep.backgroundColor = light_purple_color
            btn_sleep.setTitleColor(.black, for: .normal)
            // btn_sleep.setTitle("Cal Burnt", for: .normal)
        }
    }
    
    @IBOutlet weak var btn_steps:UIButton! {
        didSet {
            btn_steps.layer.cornerRadius = 12
            btn_steps.clipsToBounds = true
            btn_steps.backgroundColor = light_purple_color
            btn_steps.setTitleColor(.black, for: .normal)
            // btn_sleep.setTitle("Cal Burnt", for: .normal)
        }
    }
    @IBOutlet weak var btn_heart:UIButton! {
        didSet {
            btn_heart.layer.cornerRadius = 12
            btn_heart.clipsToBounds = true
            btn_heart.backgroundColor = light_purple_color
            btn_heart.setTitleColor(.black, for: .normal)
            // btn_sleep.setTitle("Cal Burnt", for: .normal)
        }
    } 
    @IBOutlet weak var btn_weight:UIButton! {
        didSet {
            btn_weight.layer.cornerRadius = 12
            btn_weight.clipsToBounds = true
            btn_weight.backgroundColor = light_purple_color
            btn_weight.setTitleColor(.black, for: .normal)
            // btn_sleep.setTitle("Cal Burnt", for: .normal)
        }
    }
    @IBOutlet weak var btn_blood_pressure:UIButton! {
        didSet {
            btn_blood_pressure.layer.cornerRadius = 12
            btn_blood_pressure.clipsToBounds = true
            btn_blood_pressure.backgroundColor = light_purple_color
            btn_blood_pressure.setTitleColor(.black, for: .normal)
            // btn_sleep.setTitle("Cal Burnt", for: .normal)
        }
    }
    @IBOutlet weak var btn_blood_glucose:UIButton! {
        didSet {
            btn_blood_glucose.layer.cornerRadius = 12
            btn_blood_glucose.clipsToBounds = true
            btn_blood_glucose.backgroundColor = light_purple_color
            btn_blood_glucose.setTitleColor(.black, for: .normal)
            // btn_sleep.setTitle("Cal Burnt", for: .normal)
        }
    }
    @IBOutlet weak var view_more_post:UIButton!
    
    @IBOutlet weak var btn_nut_plus:UIButton!
    
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
    
    @IBOutlet weak var txt_protien:UITextField! {
        didSet {
            txt_protien.textAlignment = .center
        }
    }
    @IBOutlet weak var txt_carbs:UITextField! {
        didSet {
            txt_carbs.textAlignment = .center
        }
    }
    @IBOutlet weak var txt_fat:UITextField! {
        didSet {
            txt_fat.textAlignment = .center
        }
    }
    
    @IBOutlet weak var lbl_protien_cal:UILabel!
    @IBOutlet weak var lbl_carbs_cal:UILabel!
    @IBOutlet weak var lbl_fats_cal:UILabel!
    
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
    
    @IBOutlet weak var txt_breakfast:UITextField! {
        didSet {
            txt_breakfast.textAlignment = .center
        }
    }
    @IBOutlet weak var txt_morning_snack:UITextField! {
        didSet {
            txt_morning_snack.textAlignment = .center
        }
    }
    @IBOutlet weak var txt_lunch:UITextField! {
        didSet {
            txt_lunch.textAlignment = .center
        }
    }
    @IBOutlet weak var txt_eve_snack:UITextField! {
        didSet {
            txt_eve_snack.textAlignment = .center
        }
    }
    @IBOutlet weak var txt_dinner:UITextField! {
        didSet {
            txt_dinner.textAlignment = .center
        }
    }
    
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
            // lbl_break_fast_one.text = "25.0"
        }
    }
    
    @IBOutlet weak var lbl_morning_snack_one:UILabel! {
        didSet {
            lbl_morning_snack_one.backgroundColor = .white
            lbl_morning_snack_one.layer.cornerRadius = 12
            lbl_morning_snack_one.clipsToBounds = true
            // lbl_morning_snack_one.text = "25.0"
        }
    }
    
    @IBOutlet weak var lbl_lunch_one:UILabel! {
        didSet {
            lbl_lunch_one.backgroundColor = .white
            lbl_lunch_one.layer.cornerRadius = 12
            lbl_lunch_one.clipsToBounds = true
            // lbl_lunch_one.text = "25.0"
        }
    }
    
    @IBOutlet weak var lbl_evening_snack_one:UILabel! {
        didSet {
            lbl_evening_snack_one.backgroundColor = .white
            lbl_evening_snack_one.layer.cornerRadius = 12
            lbl_evening_snack_one.clipsToBounds = true
            // lbl_evening_snack_one.text = "25.0"
        }
    }
    
    @IBOutlet weak var lbl_dinner_one:UILabel! {
        didSet {
            lbl_dinner_one.backgroundColor = .white
            lbl_dinner_one.layer.cornerRadius = 12
            lbl_dinner_one.clipsToBounds = true
            // lbl_dinner_one.text = "25.0"
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
    
    @IBOutlet weak var lbl_total_cal:UILabel!
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
    @IBOutlet weak var lbl_remind_every_day:UILabel! {
        didSet {
            lbl_remind_every_day.backgroundColor = .clear
        }
    }
    
    
    
    
    
    
    @IBOutlet weak var btn_checkmark_breakfast:UIButton! {
        didSet {
            btn_checkmark_breakfast.setImage(UIImage(named: "uncheck"), for: .normal)
        }
    }
    @IBOutlet weak var btn_checkmark_morning_snack:UIButton! {
        didSet {
            btn_checkmark_morning_snack.setImage(UIImage(named: "uncheck"), for: .normal)
        }
    }
    @IBOutlet weak var btn_checkmark_lunch:UIButton! {
        didSet {
            btn_checkmark_lunch.setImage(UIImage(named: "uncheck"), for: .normal)
        }
    }
    @IBOutlet weak var btn_checkmark_evening_snack:UIButton! {
        didSet {
            btn_checkmark_evening_snack.setImage(UIImage(named: "uncheck"), for: .normal)
        }
    }
    @IBOutlet weak var btn_checkmark_dinner:UIButton! {
        didSet {
            btn_checkmark_dinner.setImage(UIImage(named: "uncheck"), for: .normal)
        }
    }
    
    
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
    
    @IBOutlet weak var lbl_checkmark_remind_day:UILabel!  {
        didSet {
            lbl_checkmark_remind_day.textColor = UIColor.gray
            lbl_checkmark_remind_day.text = "disabled"
        }
    }
    
    @IBOutlet weak var btn_checkmark_remind_me_every_day:UIButton! {
        didSet {
            btn_checkmark_remind_me_every_day.setImage(UIImage(named: "uncheck_one"), for: .normal)
        }
    }
    
    
    @IBOutlet weak var btn_continue:UIButton! {
        didSet {
            btn_continue.layer.cornerRadius = 8
            btn_continue.clipsToBounds = true
            btn_continue.setTitle("Set".uppercased(), for: .normal)
            btn_continue.setTitleColor(.white, for: .normal)
        }
    }
    
    @IBOutlet weak var lbl_breakfast_day_status:UILabel!
    @IBOutlet weak var lbl_morning_snack_status:UILabel!
    @IBOutlet weak var lbl_lunch_status:UILabel!
    @IBOutlet weak var lbl_evening_snack_status:UILabel!
    @IBOutlet weak var lbl_dinner_status:UILabel!
}

// /* ************** WATER INTAKE ****************************** */
// /* ********************************************************** */
class water_intake_table_cell : UITableViewCell {
    
    @IBOutlet weak var view_BG:UIView! {
        didSet {
            view_BG.backgroundColor = .white
        }
    }
    
    @IBOutlet weak var view_glass:UIView! {
        didSet {
            view_glass.layer.cornerRadius = 8
            view_glass.clipsToBounds = true
            view_glass.backgroundColor = UIColor.init(red: 245.0/255.0, green: 236.0/255.0, blue: 255.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var lbl_water_glass_count:UILabel!
    @IBOutlet weak var lbl_water_glass_out_of:UILabel!
    
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
    
    @IBOutlet weak var btn_add:UIButton!
    @IBOutlet weak var btn_minus:UIButton!
    
    @IBOutlet weak var view_date:UIView! {
        didSet {
            view_date.layer.cornerRadius = 8
            view_date.clipsToBounds = true
            view_date.backgroundColor = UIColor.init(red: 245.0/255.0, green: 236.0/255.0, blue: 255.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet var chartView: BarChartView!
    
    @IBOutlet weak var btn_date:UIButton!
    
    @IBOutlet weak var lbl_date:UILabel!
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
    
    @IBOutlet weak var lbl_water_count:UILabel!
    
    @IBOutlet weak var btn_add:UIButton!
    @IBOutlet weak var btn_minus:UIButton!
    
    @IBOutlet weak var btn_save:UIButton! {
        didSet {
            btn_save.layer.cornerRadius = 8
            btn_save.clipsToBounds = true
            btn_save.setTitle("Save", for: .normal)
            btn_save.setTitleColor(.white, for: .normal)
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
    
    @IBOutlet weak var btn_add_friend:UIButton!
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

// /* ******************* SEARCH FRIEND ************************* */
// /* ********************************************************** */
class search_friends_table_cell : UITableViewCell {
    @IBOutlet weak var img_profile:UIImageView! {
        didSet {
            img_profile.layer.cornerRadius = 25
            img_profile.clipsToBounds = true
        }
    }
    @IBOutlet weak var lbl_title:UILabel!
    @IBOutlet weak var lbl_sub_title:UILabel!
    
    @IBOutlet weak var btn_add:UIButton!
}

// /* ******************* USER FRIENDS ************************* */
// /* ********************************************************** */
class user_friends_table_cell : UITableViewCell {
    @IBOutlet weak var img_profile:UIImageView! {
        didSet {
            img_profile.layer.cornerRadius = 60
            img_profile.clipsToBounds = true
        }
    }
    @IBOutlet weak var lbl_name:UILabel!
    @IBOutlet weak var lbl_email:UILabel!
    
    @IBOutlet weak var lbl_sex:UILabel!
    @IBOutlet weak var lbl_dob:UILabel!
    @IBOutlet weak var lbl_alcohol:UILabel!
    @IBOutlet weak var lbl_smoke:UILabel!
    @IBOutlet weak var lbl_taking_med:UILabel!
    
}

// /* ************************* REMINDERS ********************** */
// /* ********************************************************** */
class reminders_table_cell : UITableViewCell {
    @IBOutlet weak var img_profile:UIImageView! {
        didSet {
            img_profile.layer.cornerRadius = 20
            img_profile.clipsToBounds = true
        }
    }
    @IBOutlet weak var lbl_title:UILabel!
    @IBOutlet weak var lbl_sub_title:UILabel!
    @IBOutlet weak var btn_edit:UIButton!
}

// /* ************************* CALORIES BURNOUT ********************** */
// /* ********************************************************** */
class calories_burnout_table_cell : UITableViewCell {
    
    @IBOutlet weak var lbl_title:UILabel!
    @IBOutlet weak var lbl_calories_per_hr:UILabel!
    @IBOutlet weak var lbl_duration:UILabel!
    @IBOutlet weak var lbl_total_calories:UILabel!
    
    
    
}

// /* ************************* CALORIES BURNOUT ********************** */
// /* ********************************************************** */
class health_logs_table_cell : UITableViewCell {
    
    @IBOutlet weak var lbl_title:UILabel!
    @IBOutlet weak var lbl_sub_title:UILabel!
}

// /* ************************* TRACKERS ********************** */
// /* ********************************************************** */
class trackers_table_cell : UITableViewCell {
    
    @IBOutlet weak var lbl_title:UILabel!
}

// /* ************************* CALORIES BURNOUT ********************** */
// /* ********************************************************** */
class edit_logs_table_cell : UITableViewCell {
    
    @IBOutlet weak var txt_edit:UITextField!
    
    @IBOutlet weak var lbl_title:UILabel!
    
    @IBOutlet weak var btn_add:UIButton!
    @IBOutlet weak var btn_minus:UIButton!
    
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
    
    @IBOutlet weak var lbl_counter:UILabel! {
        didSet {
            lbl_counter.isHidden = true
        }
    }
    @IBOutlet weak var btn_save:UIButton!
    
    @IBOutlet weak var lbl_subtitle:UILabel!
    
    @IBOutlet weak var txt_text:UITextField! {
        didSet {
            txt_text.textAlignment = .center
        }
    }
}

// /* ************************* CALORIES BURNOUT ********************** */
// /* ********************************************************** */
class show_all_cal_burnt_ctivity_table_cell : UITableViewCell {
    
    @IBOutlet weak var lbl_title:UILabel!
    @IBOutlet weak var lbl_calories_per_hr:UILabel!
    @IBOutlet weak var lbl_duration:UILabel!
    @IBOutlet weak var lbl_total_calories:UILabel!
}

// /* ************************* WORKOUT REMINDERS ************** */
// /* ********************************************************** */
class workout_reminders_table_cell : UITableViewCell {
    @IBOutlet weak var btn_reminde_me_every_at_checkmark:UIButton!  {
        didSet {
            btn_reminde_me_every_at_checkmark.backgroundColor = .clear
            btn_reminde_me_every_at_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
        }
    }
    @IBOutlet weak var btn_reminde_me_every_at_time:UIButton! {
        didSet {
            btn_reminde_me_every_at_time.backgroundColor = .systemGray5
            btn_reminde_me_every_at_time.tag = 0
            btn_reminde_me_every_at_time.setTitle("disable", for: .normal)
            btn_reminde_me_every_at_time.layer.cornerRadius = 8
            btn_reminde_me_every_at_time.clipsToBounds = true
        }
    }
    
    //sunday
    @IBOutlet weak var btn_sunday_checkmark:UIButton!  {
        didSet {
            btn_sunday_checkmark.backgroundColor = .clear
            btn_sunday_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
        }
    }
    @IBOutlet weak var btn_sunday_time:UIButton! {
        didSet {
            btn_sunday_time.backgroundColor = .systemGray5
            btn_sunday_time.tag = 0
            btn_sunday_time.setTitle("disable", for: .normal)
            btn_sunday_time.layer.cornerRadius = 8
            btn_sunday_time.clipsToBounds = true
        }
    }
    
    //monday
    @IBOutlet weak var btn_monday_checkmark:UIButton!  {
        didSet {
            btn_monday_checkmark.backgroundColor = .clear
            btn_monday_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
        }
    }
    @IBOutlet weak var btn_monday_time:UIButton! {
        didSet {
            btn_monday_time.backgroundColor = .systemGray5
            btn_monday_time.tag = 0
            btn_monday_time.setTitle("disable", for: .normal)
            btn_monday_time.layer.cornerRadius = 8
            btn_monday_time.clipsToBounds = true
        }
    }
    
    //tuesday
    @IBOutlet weak var btn_tuesday_checkmark:UIButton!  {
        didSet {
            btn_tuesday_checkmark.backgroundColor = .clear
            btn_tuesday_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
        }
    }
    @IBOutlet weak var btn_tuesday_time:UIButton! {
        didSet {
            btn_tuesday_time.backgroundColor = .systemGray5
            btn_tuesday_time.tag = 0
            btn_tuesday_time.setTitle("disable", for: .normal)
            btn_tuesday_time.layer.cornerRadius = 8
            btn_tuesday_time.clipsToBounds = true
        }
    }
    
    
    //wednesday
    @IBOutlet weak var btn_wednesday_checkmark:UIButton!  {
        didSet {
            btn_wednesday_checkmark.backgroundColor = .clear
            btn_wednesday_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
        }
    }
    @IBOutlet weak var btn_wednesday_time:UIButton! {
        didSet {
            btn_wednesday_time.backgroundColor = .systemGray5
            btn_wednesday_time.tag = 0
            btn_wednesday_time.setTitle("disable", for: .normal)
            btn_wednesday_time.layer.cornerRadius = 8
            btn_wednesday_time.clipsToBounds = true
        }
    }
    
    
    //thursday
    @IBOutlet weak var btn_thursday_checkmark:UIButton!  {
        didSet {
            btn_thursday_checkmark.backgroundColor = .clear
            btn_thursday_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
        }
    }
    @IBOutlet weak var btn_thursday_time:UIButton! {
        didSet {
            btn_thursday_time.backgroundColor = .systemGray5
            btn_thursday_time.tag = 0
            btn_thursday_time.setTitle("disable", for: .normal)
            btn_thursday_time.layer.cornerRadius = 8
            btn_thursday_time.clipsToBounds = true
        }
    }
    
    
    //friday
    @IBOutlet weak var btn_friday_checkmark:UIButton!  {
        didSet {
            btn_friday_checkmark.backgroundColor = .clear
            btn_friday_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
        }
    }
    @IBOutlet weak var btn_friday_time:UIButton! {
        didSet {
            btn_friday_time.backgroundColor = .systemGray5
            btn_friday_time.tag = 0
            btn_friday_time.setTitle("disable", for: .normal)
            btn_friday_time.layer.cornerRadius = 8
            btn_friday_time.clipsToBounds = true
        }
    }
    
    
    //saturday
    @IBOutlet weak var btn_saturday_checkmark:UIButton!  {
        didSet {
            btn_saturday_checkmark.backgroundColor = .clear
            btn_saturday_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
        }
    }
    @IBOutlet weak var btn_saturday_time:UIButton! {
        didSet {
            btn_saturday_time.backgroundColor = .systemGray5
            btn_saturday_time.tag = 0
            btn_saturday_time.setTitle("disable", for: .normal)
            btn_saturday_time.layer.cornerRadius = 8
            btn_saturday_time.clipsToBounds = true
        }
    }
    
    
    
}

// /* ************************* WALK REMINDERS ************** */
// /* ********************************************************** */
class walk_reminders_table_cell : UITableViewCell {
    @IBOutlet weak var btn_reminde_me_every_at_checkmark:UIButton!  {
        didSet {
            btn_reminde_me_every_at_checkmark.backgroundColor = .clear
            btn_reminde_me_every_at_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
        }
    }
    @IBOutlet weak var btn_reminde_me_every_at_time:UIButton! {
        didSet {
            btn_reminde_me_every_at_time.backgroundColor = .systemGray5
            btn_reminde_me_every_at_time.tag = 0
            btn_reminde_me_every_at_time.setTitle("disable", for: .normal)
            btn_reminde_me_every_at_time.layer.cornerRadius = 8
            btn_reminde_me_every_at_time.clipsToBounds = true
        }
    }
    
    //sunday
    @IBOutlet weak var btn_sunday_checkmark:UIButton!  {
        didSet {
            btn_sunday_checkmark.backgroundColor = .clear
            btn_sunday_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
        }
    }
    @IBOutlet weak var btn_sunday_time:UIButton! {
        didSet {
            btn_sunday_time.backgroundColor = .systemGray5
            btn_sunday_time.tag = 0
            btn_sunday_time.setTitle("disable", for: .normal)
            btn_sunday_time.layer.cornerRadius = 8
            btn_sunday_time.clipsToBounds = true
        }
    }
    
    //monday
    @IBOutlet weak var btn_monday_checkmark:UIButton!  {
        didSet {
            btn_monday_checkmark.backgroundColor = .clear
            btn_monday_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
        }
    }
    @IBOutlet weak var btn_monday_time:UIButton! {
        didSet {
            btn_monday_time.backgroundColor = .systemGray5
            btn_monday_time.tag = 0
            btn_monday_time.setTitle("disable", for: .normal)
            btn_monday_time.layer.cornerRadius = 8
            btn_monday_time.clipsToBounds = true
        }
    }
    
    //tuesday
    @IBOutlet weak var btn_tuesday_checkmark:UIButton!  {
        didSet {
            btn_tuesday_checkmark.backgroundColor = .clear
            btn_tuesday_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
        }
    }
    @IBOutlet weak var btn_tuesday_time:UIButton! {
        didSet {
            btn_tuesday_time.backgroundColor = .systemGray5
            btn_tuesday_time.tag = 0
            btn_tuesday_time.setTitle("disable", for: .normal)
            btn_tuesday_time.layer.cornerRadius = 8
            btn_tuesday_time.clipsToBounds = true
        }
    }
    
    
    //wednesday
    @IBOutlet weak var btn_wednesday_checkmark:UIButton!  {
        didSet {
            btn_wednesday_checkmark.backgroundColor = .clear
            btn_wednesday_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
        }
    }
    @IBOutlet weak var btn_wednesday_time:UIButton! {
        didSet {
            btn_wednesday_time.backgroundColor = .systemGray5
            btn_wednesday_time.tag = 0
            btn_wednesday_time.setTitle("disable", for: .normal)
            btn_wednesday_time.layer.cornerRadius = 8
            btn_wednesday_time.clipsToBounds = true
        }
    }
    
    
    //thursday
    @IBOutlet weak var btn_thursday_checkmark:UIButton!  {
        didSet {
            btn_thursday_checkmark.backgroundColor = .clear
            btn_thursday_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
        }
    }
    @IBOutlet weak var btn_thursday_time:UIButton! {
        didSet {
            btn_thursday_time.backgroundColor = .systemGray5
            btn_thursday_time.tag = 0
            btn_thursday_time.setTitle("disable", for: .normal)
            btn_thursday_time.layer.cornerRadius = 8
            btn_thursday_time.clipsToBounds = true
        }
    }
    
    
    //friday
    @IBOutlet weak var btn_friday_checkmark:UIButton!  {
        didSet {
            btn_friday_checkmark.backgroundColor = .clear
            btn_friday_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
        }
    }
    @IBOutlet weak var btn_friday_time:UIButton! {
        didSet {
            btn_friday_time.backgroundColor = .systemGray5
            btn_friday_time.tag = 0
            btn_friday_time.setTitle("disable", for: .normal)
            btn_friday_time.layer.cornerRadius = 8
            btn_friday_time.clipsToBounds = true
        }
    }
    
    
    //saturday
    @IBOutlet weak var btn_saturday_checkmark:UIButton!  {
        didSet {
            btn_saturday_checkmark.backgroundColor = .clear
            btn_saturday_checkmark.setImage(UIImage(named: "uncheck"), for: .normal)
        }
    }
    @IBOutlet weak var btn_saturday_time:UIButton! {
        didSet {
            btn_saturday_time.backgroundColor = .systemGray5
            btn_saturday_time.tag = 0
            btn_saturday_time.setTitle("disable", for: .normal)
            btn_saturday_time.layer.cornerRadius = 8
            btn_saturday_time.clipsToBounds = true
        }
    }
    
    
    
}

// /* ************************* WORKOUT SETTINGS ************** */
// /* ********************************************************** */
class workout_setting_table_cell : UITableViewCell {
    @IBOutlet weak var lbl_title:UILabel!
}

// /* ************************* EDIT PROFILE ************** */
// /* ********************************************************** */
class edit_profile_table_cell : UITableViewCell {
    
    @IBOutlet weak var img_profile:UIImageView! {
        didSet {
            img_profile.layer.cornerRadius = 45
            img_profile.clipsToBounds = true
        }
    }
    @IBOutlet weak var txt_name:UITextField! {
        didSet {
            txt_name.layer.cornerRadius = 8
            txt_name.clipsToBounds = true
            txt_name.backgroundColor = .clear
            txt_name.placeholder = "Name"
            txt_name.setLeftPaddingPoints(20)
            txt_name.backgroundColor = UIColor.init(red: 243.0/255.0, green: 243.0/255.0, blue: 243.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var txt_email:UITextField! {
        didSet {
            txt_email.layer.cornerRadius = 8
            txt_email.clipsToBounds = true
            txt_email.backgroundColor = .clear
            txt_email.placeholder = "Email"
            txt_email.setLeftPaddingPoints(20)
            txt_email.isUserInteractionEnabled = false
            txt_email.backgroundColor = UIColor.init(red: 243.0/255.0, green: 243.0/255.0, blue: 243.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var txt_phone:UITextField! {
        didSet {
            txt_phone.layer.cornerRadius = 8
            txt_phone.clipsToBounds = true
            txt_phone.backgroundColor = .clear
            txt_phone.placeholder = "Phone"
            txt_phone.setLeftPaddingPoints(20)
            txt_phone.backgroundColor = UIColor.init(red: 243.0/255.0, green: 243.0/255.0, blue: 243.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var txt_address:UITextField! {
        didSet {
            txt_address.layer.cornerRadius = 8
            txt_address.clipsToBounds = true
            txt_address.backgroundColor = .clear
            txt_address.placeholder = "Address"
            txt_address.setLeftPaddingPoints(20)
            txt_address.backgroundColor = UIColor.init(red: 243.0/255.0, green: 243.0/255.0, blue: 243.0/255.0, alpha: 1)
        }
    }
    @IBOutlet weak var btn_update:UIButton!
    @IBOutlet weak var btn_profile:UIButton! {
        didSet {
            btn_profile.layer.cornerRadius = 8
            btn_profile.clipsToBounds = true
            btn_profile.setTitle("Update profile", for: .normal)
        }
    }
}

// /* ************************* SELECT MEAL ************** */
// /* ********************************************************** */
class select_meal_table_cell : UITableViewCell {
    @IBOutlet weak var lbl_title:UILabel!
    @IBOutlet weak var lbl_sub_title:UILabel!
    @IBOutlet weak var lbl_calories:UILabel!
}

// /* ******************* TYPE OF EXCERSICE ******************** */
// /* ********************************************************** */
class type_of_excercise_table_cell : UITableViewCell {
    @IBOutlet weak var imagee:UIImageView! {
        didSet {
            imagee.layer.cornerRadius = 8
            imagee.clipsToBounds = true
        }
    }
    @IBOutlet weak var btn_excercise:UIButton! {
        didSet {
            btn_excercise.layer.cornerRadius = 8
            btn_excercise.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var imagee2:UIImageView! {
        didSet {
            imagee2.layer.cornerRadius = 8
            imagee2.clipsToBounds = true
        }
    }
    @IBOutlet weak var btn_excercise2:UIButton! {
        didSet {
            btn_excercise2.layer.cornerRadius = 8
            btn_excercise2.clipsToBounds = true
        }
    }
}

// /* ******************* DAYS WORKOUT ************************* */
// /* ********************************************************** */
class days_workout_table_cell : UITableViewCell {
    @IBOutlet weak var lbl_title:UILabel!
    @IBOutlet weak var lbl_sub_title:UILabel!
    @IBOutlet weak var lbl_cal:UILabel!
    @IBOutlet weak var btn_delete:UIButton! {
        didSet {
            btn_delete.tintColor = .systemRed
        }
    }
}

// /* ******************* GYM EXC DETAILS ********************** */
// /* ********************************************************** */
class workout_gym_exc_details_table_cell : UITableViewCell {
    @IBOutlet weak var lbl_name:UILabel!
    @IBOutlet weak var lbl_category:UILabel!
    @IBOutlet weak var lbl_force:UILabel!
    @IBOutlet weak var lbl_mechanic:UILabel!
    @IBOutlet weak var lbl_equipment:UILabel!
    @IBOutlet weak var lbl_instruction:UITextView! {
        didSet {
            lbl_instruction.isEditable = false
        }
    }
}


// /* ******************* SELECT WORKOUT ************************* */
// /* ********************************************************** */
class select_workout_table_cell2 : UITableViewCell {
    @IBOutlet weak var lbl_title:UILabel!
    @IBOutlet weak var lbl_sub_title:UILabel!
    @IBOutlet weak var lbl_total_cal:UILabel!
    @IBOutlet weak var btn_add:UIButton!
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
    @IBOutlet weak var lbl_cal:UILabel!
    @IBOutlet weak var btn_add:UIButton!
}

// /* ************** MONITOR - SLEEP **************************** */
// /* ********************************************************** */
class sleep_table_cell : UITableViewCell {
    
    // chart
    @IBOutlet var chartView: BarChartView!
    @IBOutlet var chartView_two: BarChartView!
    
    
//    @IBOutlet var sliderX: UISlider!
//    @IBOutlet var sliderY: UISlider!
//    @IBOutlet var sliderTextX: UITextField!
//    @IBOutlet var sliderTextY: UITextField!
//    
//    @IBOutlet weak var lbl_date:UILabel!
//    @IBOutlet weak var lbl_total_sleep_time:UILabel!
    
    @IBOutlet weak var btn_date_one:UIButton! {
        didSet {
            btn_date_one.layer.cornerRadius = 8
            btn_date_one.clipsToBounds = true
        }
    }
    @IBOutlet weak var btn_date_two:UIButton! {
        didSet {
            btn_date_two.layer.cornerRadius = 8
            btn_date_two.clipsToBounds = true
        }
    }
    @IBOutlet weak var btn_submit:UIButton! {
        didSet {
            btn_submit.layer.cornerRadius = 8
            btn_submit.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var lbl_on_avg:UILabel!
    @IBOutlet weak var lbl_on_avg_two:UILabel!
    
    @IBOutlet weak var lbl_dates:UILabel!
    @IBOutlet weak var lbl_dates_two:UILabel!
    
    @IBOutlet weak var lbl_header_date:UILabel!
    
    @IBOutlet weak var lbl_day_time:UILabel!
    @IBOutlet weak var lbl_value:UILabel!
    
    @IBOutlet weak var btn_delete:UIButton!
}


// /* ************** MONITOR - BLOOD GLUCOSE **************************** */
// /* ********************************************************** */
class add_blood_glucose_table_cell : UITableViewCell {
    
   //  @IBOutlet weak var
    
}

// /* ************** MONITOR - BLOOD GLUCOSE **************************** */
// /* ********************************************************** */
class blood_glucose_table_cell : UITableViewCell {
    
    // chart
    @IBOutlet var chartView: BarChartView!
    @IBOutlet var chartView_two: BarChartView!
    
    
//    @IBOutlet var sliderX: UISlider!
//    @IBOutlet var sliderY: UISlider!
//    @IBOutlet var sliderTextX: UITextField!
//    @IBOutlet var sliderTextY: UITextField!
//
//    @IBOutlet weak var lbl_date:UILabel!
//    @IBOutlet weak var lbl_total_sleep_time:UILabel!
    
    @IBOutlet weak var btn_date_one:UIButton! {
        didSet {
            btn_date_one.layer.cornerRadius = 8
            btn_date_one.clipsToBounds = true
        }
    }
    @IBOutlet weak var btn_date_two:UIButton! {
        didSet {
            btn_date_two.layer.cornerRadius = 8
            btn_date_two.clipsToBounds = true
        }
    }
    @IBOutlet weak var btn_submit:UIButton! {
        didSet {
            btn_submit.layer.cornerRadius = 8
            btn_submit.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var lbl_on_avg:UILabel!
    @IBOutlet weak var lbl_on_avg_two:UILabel!
    
    @IBOutlet weak var lbl_dates:UILabel!
    @IBOutlet weak var lbl_dates_two:UILabel!
    
    @IBOutlet weak var lbl_header_date:UILabel!
    
    @IBOutlet weak var lbl_day_time:UILabel!
    @IBOutlet weak var lbl_value:UILabel!
    
    @IBOutlet weak var btn_delete:UIButton!
}

// /* ************** MONITOR - HEART **************************** */
// /* ********************************************************** */
class heart_table_cell : UITableViewCell {
    
    // chart
    @IBOutlet var chartView: BarChartView!
    @IBOutlet var chartView_two: BarChartView!
    
    @IBOutlet weak var lbl_date:UILabel!
    @IBOutlet weak var lbl_total_sleep_time:UILabel!
    
    @IBOutlet weak var btn_date_one:UIButton! {
        didSet {
            btn_date_one.layer.cornerRadius = 8
            btn_date_one.clipsToBounds = true
        }
    }
    @IBOutlet weak var btn_date_two:UIButton! {
        didSet {
            btn_date_two.layer.cornerRadius = 8
            btn_date_two.clipsToBounds = true
        }
    }
    @IBOutlet weak var btn_submit:UIButton! {
        didSet {
            btn_submit.layer.cornerRadius = 8
            btn_submit.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var lbl_on_avg:UILabel!
    @IBOutlet weak var lbl_on_avg_two:UILabel!
    
    @IBOutlet weak var lbl_dates_two:UILabel!
    
    @IBOutlet weak var lbl_header_date:UILabel!
    
    
    @IBOutlet weak var lbl_day_time:UILabel!
    @IBOutlet weak var lbl_value:UILabel!
    
    @IBOutlet weak var btn_delete:UIButton!
    
}
// /* ************** MONITOR - WEIGHT **************************** */
// /* ********************************************************** */
class weight_table_cell : UITableViewCell {
    
    
    // chart
    @IBOutlet var chartView: BarChartView!
    @IBOutlet var chartView_two: BarChartView!
    
    
    @IBOutlet weak var lbl_date:UILabel!
    @IBOutlet weak var lbl_total_sleep_time:UILabel!
    
    @IBOutlet weak var btn_date_one:UIButton! {
        didSet {
            btn_date_one.layer.cornerRadius = 8
            btn_date_one.clipsToBounds = true
        }
    }
    @IBOutlet weak var btn_date_two:UIButton! {
        didSet {
            btn_date_two.layer.cornerRadius = 8
            btn_date_two.clipsToBounds = true
        }
    }
    @IBOutlet weak var btn_submit:UIButton! {
        didSet {
            btn_submit.layer.cornerRadius = 8
            btn_submit.clipsToBounds = true
        }
    }
    @IBOutlet weak var lbl_on_avg:UILabel!
    @IBOutlet weak var lbl_on_avg_two:UILabel!
    
    @IBOutlet weak var lbl_dates_two:UILabel!
    
    @IBOutlet weak var lbl_header_date:UILabel!
    
    @IBOutlet weak var lbl_day_time:UILabel!
    @IBOutlet weak var lbl_value:UILabel!
    
    @IBOutlet weak var btn_delete:UIButton!
}
// /* ************** MONITOR - BLOOD PRESSURE **************************** */
// /* ********************************************************** */
class blood_pressure_table_cell : UITableViewCell {
    
    @IBOutlet weak var chartView:BarChartView!
    
    @IBOutlet weak var lbl_date:UILabel!
    @IBOutlet weak var lbl_total_sleep_time:UILabel!
    
    @IBOutlet weak var btn_date_one:UIButton! {
        didSet {
            btn_date_one.layer.cornerRadius = 8
            btn_date_one.clipsToBounds = true
        }
    }
    @IBOutlet weak var btn_date_two:UIButton! {
        didSet {
            btn_date_two.layer.cornerRadius = 8
            btn_date_two.clipsToBounds = true
        }
    }
    @IBOutlet weak var btn_submit:UIButton! {
        didSet {
            btn_submit.layer.cornerRadius = 8
            btn_submit.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var lbl_header_date:UILabel!
    
    @IBOutlet weak var lbl_day_time:UILabel!
    @IBOutlet weak var lbl_value:UILabel!
    
    @IBOutlet weak var btn_delete:UIButton!
}
// /* ************** MONITOR - SLEEP **************************** */
// /* ********************************************************** */
class add_step_time_table_cell : UITableViewCell {
    
    @IBOutlet weak var txt_title:UITextField! {
        didSet {
            txt_title.layer.cornerRadius = 8
            txt_title.clipsToBounds = true
            txt_title.backgroundColor = .clear
            txt_title.placeholder = "Title"
            txt_title.setLeftPaddingPoints(20)
            txt_title.backgroundColor = UIColor.init(red: 243.0/255.0, green: 243.0/255.0, blue: 243.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var txt_select_date:UITextField! {
        didSet {
            txt_select_date.layer.cornerRadius = 8
            txt_select_date.clipsToBounds = true
            txt_select_date.backgroundColor = .clear
            txt_select_date.placeholder = "Select date"
            txt_select_date.setLeftPaddingPoints(20)
            txt_select_date.backgroundColor = UIColor.init(red: 243.0/255.0, green: 243.0/255.0, blue: 243.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var txt_duration:UITextField! {
        didSet {
            txt_duration.layer.cornerRadius = 8
            txt_duration.clipsToBounds = true
            txt_duration.backgroundColor = .clear
            txt_duration.placeholder = "Duration"
            txt_duration.setLeftPaddingPoints(20)
            txt_duration.backgroundColor = UIColor.init(red: 243.0/255.0, green: 243.0/255.0, blue: 243.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var txt_distance:UITextField! {
        didSet {
            txt_distance.layer.cornerRadius = 8
            txt_distance.clipsToBounds = true
            txt_distance.backgroundColor = .clear
            txt_distance.placeholder = "Distance"
            txt_distance.setLeftPaddingPoints(20)
            txt_distance.backgroundColor = UIColor.init(red: 243.0/255.0, green: 243.0/255.0, blue: 243.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var txt_steps:UITextField! {
        didSet {
            txt_steps.layer.cornerRadius = 8
            txt_steps.clipsToBounds = true
            txt_steps.backgroundColor = .clear
            txt_steps.placeholder = "Steps"
            txt_steps.setLeftPaddingPoints(20)
            txt_steps.keyboardType = .phonePad
            txt_steps.backgroundColor = UIColor.init(red: 243.0/255.0, green: 243.0/255.0, blue: 243.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var txt_note:UITextField! {
        didSet {
            txt_note.layer.cornerRadius = 8
            txt_note.clipsToBounds = true
            txt_note.backgroundColor = .clear
            txt_note.placeholder = "Note"
            txt_note.setLeftPaddingPoints(20)
            txt_note.backgroundColor = UIColor.init(red: 243.0/255.0, green: 243.0/255.0, blue: 243.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var btn_calendar_click:UIButton!
    
    @IBOutlet weak var btn_submit:UIButton! {
        didSet {
            btn_submit.layer.cornerRadius = 12
            btn_submit.clipsToBounds = true
        }
    }
    
}
// /* ************** MONITOR - STEPS *************************** */
// /* ********************************************************** */
class steps_table_cell : UITableViewCell {
    
    // chart
    @IBOutlet var chartView: BarChartView!
    @IBOutlet var chartView_two: BarChartView!
    
    @IBOutlet weak var lbl_date:UILabel!
    @IBOutlet weak var lbl_total_sleep_time:UILabel!
    
    @IBOutlet weak var btn_date_one:UIButton! {
        didSet {
            btn_date_one.layer.cornerRadius = 8
            btn_date_one.clipsToBounds = true
        }
    }
    @IBOutlet weak var btn_date_two:UIButton! {
        didSet {
            btn_date_two.layer.cornerRadius = 8
            btn_date_two.clipsToBounds = true
        }
    }
    @IBOutlet weak var btn_submit:UIButton! {
        didSet {
            btn_submit.layer.cornerRadius = 8
            btn_submit.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var lbl_on_avg:UILabel!
    @IBOutlet weak var lbl_on_avg_two:UILabel!
    
    @IBOutlet weak var lbl_dates:UILabel!
    @IBOutlet weak var lbl_dates_two:UILabel!
    
    @IBOutlet weak var lbl_header_date:UILabel!
    
    @IBOutlet weak var lbl_day_time:UILabel!
    @IBOutlet weak var lbl_value:UILabel!
    
    @IBOutlet weak var btn_delete:UIButton!
    
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

class goal_settings_table_cell : UITableViewCell {
    @IBOutlet weak var view_weight:UIView! {
        didSet {
            view_weight.backgroundColor = light_purple_color
            view_weight.layer.cornerRadius = 12
            view_weight.clipsToBounds = true
        }
    }
    @IBOutlet weak var lbl_current_weight:UILabel!
    @IBOutlet weak var lbl_goal_weight:UILabel!
    @IBOutlet weak var lbl_activity_weight:UILabel!
    @IBOutlet weak var btn_edit_weight:UIButton!
    
    @IBOutlet weak var view_water_goal:UIView! {
        didSet {
            view_water_goal.backgroundColor = light_purple_color
            view_water_goal.layer.cornerRadius = 12
            view_water_goal.clipsToBounds = true
        }
    }
    @IBOutlet weak var lbl_daily_water_goal:UILabel!
    @IBOutlet weak var btn_water_goal:UIButton!
    @IBOutlet weak var btn_edit_water:UIButton!
    
    @IBOutlet weak var view_step_goal:UIView! {
        didSet {
            view_step_goal.backgroundColor = light_purple_color
            view_step_goal.layer.cornerRadius = 12
            view_step_goal.clipsToBounds = true
        }
    }
    @IBOutlet weak var lbl_daily_step_goal:UILabel!
    @IBOutlet weak var btn_steps_goal:UIButton!
    @IBOutlet weak var btn_edit_steps:UIButton!
    
    @IBOutlet weak var view_meal_cal:UIView! {
        didSet {
            view_meal_cal.backgroundColor = light_purple_color
            view_meal_cal.layer.cornerRadius = 12
            view_meal_cal.clipsToBounds = true
        }
    }
    @IBOutlet weak var lbl_meal_calories_info:UILabel!
    
    @IBOutlet weak var view_nut_goal:UIView! {
        didSet {
            view_nut_goal.backgroundColor = light_purple_color
            view_nut_goal.layer.cornerRadius = 12
            view_nut_goal.clipsToBounds = true
        }
    }
    @IBOutlet weak var lbl_calorie_budget:UILabel!
    @IBOutlet weak var btn_nutrition_goal:UIButton!
    @IBOutlet weak var btn_edit_nut:UIButton!
    @IBOutlet weak var btn_edit_meal_cal:UIButton!
}


class goal_settings_water_table_cell : UITableViewCell {
    
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
    
    @IBOutlet weak var lbl_water_count:UILabel!
    
    @IBOutlet weak var btn_add:UIButton!
    @IBOutlet weak var btn_minus:UIButton!
    
    @IBOutlet weak var btn_save:UIButton! {
        didSet {
            btn_save.layer.cornerRadius = 8
            btn_save.clipsToBounds = true
            btn_save.setTitle("Save", for: .normal)
            btn_save.setTitleColor(.white, for: .normal)
        }
    }
    // steps
    @IBOutlet weak var view_counter_steps:UIView! {
        didSet {
            view_counter_steps.layer.cornerRadius = 8
            view_counter_steps.clipsToBounds = true
            view_counter_steps.backgroundColor = UIColor.init(red: 245.0/255.0, green: 236.0/255.0, blue: 255.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var view_digits_counter_steps:UIView! {
        didSet {
            view_digits_counter_steps.layer.cornerRadius = 12
            view_digits_counter_steps.clipsToBounds = true
            view_digits_counter_steps.backgroundColor = .white
        }
    }
    
    @IBOutlet weak var txt_field_data:UITextField! {
        didSet {
            txt_field_data.textAlignment = .center
        }
    }
    @IBOutlet weak var lbl_water_count_steps:UILabel! {
        didSet {
            lbl_water_count_steps.isHidden = true
        }
    }
    
    @IBOutlet weak var btn_add_steps:UIButton!
    @IBOutlet weak var btn_minus_steps:UIButton!
    
    @IBOutlet weak var btn_save_steps:UIButton! {
        didSet {
            btn_save_steps.layer.cornerRadius = 8
            btn_save_steps.clipsToBounds = true
            btn_save_steps.setTitle("Save", for: .normal)
            btn_save_steps.setTitleColor(.white, for: .normal)
        }
    }
    // nut
    @IBOutlet weak var view_counter_nut:UIView! {
        didSet {
            view_counter_nut.layer.cornerRadius = 8
            view_counter_nut.clipsToBounds = true
            view_counter_nut.backgroundColor = UIColor.init(red: 245.0/255.0, green: 236.0/255.0, blue: 255.0/255.0, alpha: 1)
        }
    }
    
    @IBOutlet weak var view_digits_counter_nut:UIView! {
        didSet {
            view_digits_counter_nut.layer.cornerRadius = 12
            view_digits_counter_nut.clipsToBounds = true
            view_digits_counter_nut.backgroundColor = .white
        }
    }
    
    @IBOutlet weak var lbl_water_count_nut:UILabel!
    
    @IBOutlet weak var btn_add_nut:UIButton!
    @IBOutlet weak var btn_minus_nut:UIButton!
    
    @IBOutlet weak var btn_save_nut:UIButton! {
        didSet {
            btn_save_nut.layer.cornerRadius = 8
            btn_save_nut.clipsToBounds = true
            btn_save_nut.setTitle("Save", for: .normal)
            btn_save_nut.setTitleColor(.white, for: .normal)
        }
    }
    
}
