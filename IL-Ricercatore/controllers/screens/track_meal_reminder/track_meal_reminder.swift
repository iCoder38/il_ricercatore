//
//  track_meal_reminder.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 19/12/23.
//

import UIKit

class track_meal_reminder: UIViewController {

    @IBOutlet weak var btn_reset:UIButton! {
        didSet {
            btn_reset.layer.cornerRadius = 8
            btn_reset.clipsToBounds = true
            // btn_reset.setTitle("reset", for: .normal)
            btn_reset.setTitleColor(.white, for: .normal)
        }
    }
    @IBOutlet weak var lbl_navigation_title:UILabel! {
        didSet {
            lbl_navigation_title.text = navigation_title_edit_meals_and_time_en
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
        
        btn_reset.addTarget(self, action: #selector(edit_calorie_budget_click_method), for: .touchUpInside)
        
    }
    @objc func edit_calorie_budget_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "water_intake_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
}


//MARK:- TABLE VIEW -
extension track_meal_reminder: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:track_meal_reminder_table_cell = tableView.dequeueReusableCell(withIdentifier: "track_meal_reminder_table_cell") as! track_meal_reminder_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        // cell.btn_continue.addTarget(self, action: #selector(complete_profile_click_method), for: .touchUpInside)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 466
    }

}
