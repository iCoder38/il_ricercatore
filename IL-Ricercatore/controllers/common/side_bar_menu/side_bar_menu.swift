//
//  side_bar_menu.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 20/12/23.
//

import UIKit

class side_bar_menu: UIViewController {

    @IBOutlet weak var tble_view:UITableView! {
        didSet {
            tble_view.delegate = self
            tble_view.dataSource = self
            tble_view.layer.cornerRadius = 0
            tble_view.clipsToBounds = true
            tble_view.backgroundColor = .clear
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tble_view.separatorColor = .clear
    } 
    
    @objc func search_friend_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "invite_friends_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    @objc func friend_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "friends_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    @objc func tracker_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "list_of_all_trackers_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    @objc func reminder_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "reminders_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    @objc func chat_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ChatViewController_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    @objc func workout_setting_click_method() {
        
        let defaults = UserDefaults.standard
        
        defaults.set(nil, forKey: "key_save_dashboard_right_arrow")
        defaults.set(nil, forKey: "key_save_aerobics")
        defaults.set(nil, forKey: "key_save_gym")
        
         
//        defaults.set("dashboard_right_arrow", forKey: "key_save_dashboard_right_arrow")
        
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "workout_setting_id") as? workout_setting
        push!.str_from_where = "side_bar_menu_option"
        self.navigationController?.pushViewController(push!, animated: true)
    }
    
    @objc func personalized_workout_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "health_logs_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    @objc func dashboard_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "dashboard_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    @objc func goal_setting_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "goal_settings_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    @objc func logout_click_method() {
        
        let defaults = UserDefaults.standard
        defaults.setValue("", forKey: str_save_login_user_data)
        defaults.setValue(nil, forKey: str_save_login_user_data)
        
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "login_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
}

//MARK:- TABLE VIEW -
extension side_bar_menu: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:side_bar_menu_table_cell = tableView.dequeueReusableCell(withIdentifier: "side_bar_menu_table_cell") as! side_bar_menu_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        if let person = UserDefaults.standard.value(forKey: str_save_login_user_data) as? [String:Any] {
            print(person)
            cell.lbl_name.text = (person["fullName"] as! String)
            cell.lbl_email.text = (person["email"] as! String)
        }
        
        cell.btn_dashboard.addTarget(self, action: #selector(dashboard_click_method), for: .touchUpInside)
        cell.btn_health_logs.addTarget(self, action: #selector(personalized_workout_click_method), for: .touchUpInside)
        cell.btn_workout_setting.addTarget(self, action: #selector(workout_setting_click_method), for: .touchUpInside)
        cell.btn_reminders.addTarget(self, action: #selector(reminder_click_method), for: .touchUpInside)
        cell.btn_trackers.addTarget(self, action: #selector(tracker_click_method), for: .touchUpInside)
        cell.btn_friends.addTarget(self, action: #selector(friend_click_method), for: .touchUpInside)
        cell.btn_search_friends.addTarget(self, action: #selector(search_friend_click_method), for: .touchUpInside)
        cell.btn_goal_setting.addTarget(self, action: #selector(goal_setting_click_method), for: .touchUpInside)
        cell.btn_logout.addTarget(self, action: #selector(logout_click_method), for: .touchUpInside)
        cell.btn_chat.addTarget(self, action: #selector(chat_click_method), for: .touchUpInside)
        cell.btn_edit_profile.addTarget(self, action: #selector(edit_click_method), for: .touchUpInside)
        
        return cell
        
    }
    
    @objc func edit_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "edit_profile_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 770
    }

}
