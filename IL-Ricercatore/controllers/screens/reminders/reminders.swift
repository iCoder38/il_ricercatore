//
//  reminders.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 20/12/23.
//

import UIKit
import SDWebImage

class reminders: UIViewController {

    var arr_reminder = ["Drink Water", "Meal reminder","Workout reminder","Walk reminder","Weight reminder","Health reminder"]
    var arr_reminder_image = ["water", "meal","meal","meal","meal","diet"]
    
    @IBOutlet weak var btn_menu:UIButton! {
        didSet {
            btn_menu.tintColor = .white
            btn_menu.addTarget(self, action: #selector(menu_click_method), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var lbl_navigation_title:UILabel! {
        didSet {
            lbl_navigation_title.text = navigation_title_remimders_en
        }
    }
    
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
}

//MARK:- TABLE VIEW -
extension reminders: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_reminder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:reminders_table_cell = tableView.dequeueReusableCell(withIdentifier: "reminders_table_cell") as! reminders_table_cell
        
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        cell.lbl_title.text = (self.arr_reminder[indexPath.row] )
        
        if indexPath.row == 0 {
            cell.img_profile.image = UIImage(named: "water")
        } else if indexPath.row == 1 {
            cell.img_profile.image = UIImage(named: "meal")
        } else if indexPath.row == 2 {
            cell.img_profile.image = UIImage(named: "fitness")
        }  else if indexPath.row == 3 {
            cell.img_profile.image = UIImage(named: "walking")
        } else if indexPath.row == 4 {
            cell.img_profile.image = UIImage(named: "weight")
        } else if indexPath.row == 5 {
            cell.img_profile.image = UIImage(named: "diet")
        }
        
        
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "water_reminders_id")
            self.navigationController?.pushViewController(push, animated: true)
        } else if indexPath.row == 1 {
            let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "track_meal_reminder_id")
            self.navigationController?.pushViewController(push, animated: true)
        } else if indexPath.row == 2 {
            let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "workout_reminder_id")
            self.navigationController?.pushViewController(push, animated: true)
        }  else if indexPath.row == 3 {
            let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "walk_reminder_id")
            self.navigationController?.pushViewController(push, animated: true)
        } else if indexPath.row == 4 {
            let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "weight_reminder_id")
            self.navigationController?.pushViewController(push, animated: true)
        } else if indexPath.row == 5 {
            let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "health_reminder_id")
            self.navigationController?.pushViewController(push, animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

}
