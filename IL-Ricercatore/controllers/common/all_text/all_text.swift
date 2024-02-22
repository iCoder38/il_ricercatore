//
//  all_text.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 19/12/23.
//

import UIKit

var welcome_text = "welcome"
var navigation_title_en = welcome_text.uppercased()

// calorie counter
var navigation_title_calorie_counter_en = "calorie information".uppercased()

// edit meals
var navigation_title_edit_meals_and_time_en = "edit meals & time".uppercased()

// edit meals calories
var navigation_title_edit_meals_calories_en = "edit meals calories".uppercased()

// water intake
var navigation_title_water_intake_en = "water intake".uppercased()

// water tracker
var navigation_title_set_up_water_tracker_en = "set up water tracker".uppercased()

// water reminder
var navigation_title_set_up_water_reminder_en = "water reminder".uppercased()

// invite friends
var navigation_title_invite_friends_en = "friends".uppercased()

//  friends
var navigation_title_friends_en = "friends".uppercased()


// reminders
var navigation_title_remimders_en = "reminders".uppercased()

// workout setting
var navigation_title_workout_setting_en = "workout setting".uppercased()

// workout setting
var navigation_title_workout_day_en = " workout".uppercased()

// personalized
var navigation_title_personalize_workout_en = "personalize workout".uppercased()

// select workout
var navigation_title_select_workout_en = "select workout".uppercased()

// workout details
var navigation_title_workout_details_en = "name".uppercased()


//////////////////////////////////////////////////////////////////////////////////////
///////////////////////// ALERT MESSAGE //////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
var str_select_one_category_en = "Please select atleast one category"

//////////////////////////////////////////////////////////////////////////////////////
///////////////////////// COMPLETE PROFILE  //////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
var str_height_placeholder = "Height"
var placeholder_current_weight = "Current Weight ( KG )"
var placeholder_target_weight = "Target Weight ( KG )"
///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
///
///
///
///
///
///
///
///
class SharedDataSingleton  {

    init(){

        //println("Hellow World")
    }


    var sample = "Hellow word"

    func showAlertView(title alerTitle:String ,message alertMessage:String, preferredStyle style:UIAlertController.Style, okLabel: String, cancelLabel: String, targetViewController: UIViewController,okHandler: ((UIAlertAction?) -> Void)!, cancelHandler: ((UIAlertAction?) -> Void)!){

            let alertController = UIAlertController(title: alerTitle, message: alertMessage, preferredStyle: style)
        let okAction = UIAlertAction(title: okLabel, style: .default, handler: okHandler)
        let cancelAction = UIAlertAction(title: cancelLabel, style: .default,handler: cancelHandler)

            // Add Actions
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)

            // Present Alert Controller
        targetViewController.present(alertController, animated: true, completion: nil)

    }





}

class all_text: UIViewController {

    var str_select_one_category_en2 = "Please select atleast one category"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
