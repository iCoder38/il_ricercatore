//
//  type_of_excercise.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 18/06/24.
//

import UIKit

class type_of_excercise: UIViewController {

    var str_exc_profile:String!
    
    @IBOutlet weak var lbl_navigation_title:UILabel! {
        didSet {
            lbl_navigation_title.text = "TYPE OF EXCERCISE"
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
    @IBOutlet weak var btn_menu:UIButton! {
        didSet {
            btn_menu.tintColor = .white
            btn_menu.setImage(UIImage(systemName: "arrow.left"), for: .normal)
            btn_menu.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tble_view.reloadData()
    }
    
    @objc func exc_1_click_method() {
        
        if (self.str_exc_profile == "1") { // from dashboard
            let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "days_workout_id") as? days_workout
            push!.str_profile_select_from_dashboard = "1"
            self.navigationController?.pushViewController(push!, animated: true)
        } else {
            
            let defaults = UserDefaults.standard
            defaults.set("aerobics_select", forKey: "key_save_aerobics")
            
            let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "select_workout_id") as? select_workout
            push!.exc_type = "1"
            push!.str_get_date = ""
            self.navigationController?.pushViewController(push!, animated: true)
        }
        
    }
    
    @objc func exc_2_click_method() {
        
        if (self.str_exc_profile == "1") { // from dashboard
            
            let defaults = UserDefaults.standard
            defaults.set(Date.getCurrentDateCustom(), forKey: "key_gym_select_from_dashboard_push")
            
            let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "days_workout_id") as? days_workout
            push!.str_profile_select_from_dashboard = "2"
            self.navigationController?.pushViewController(push!, animated: true)
        } else {
            
            let defaults = UserDefaults.standard
            defaults.set("gym_select", forKey: "key_save_gym")
            
            let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "select_workout_id") as? select_workout
            push!.exc_type = "2"
            push!.str_get_date = ""
            self.navigationController?.pushViewController(push!, animated: true)
        }
    }
    
}

//MARK:- TABLE VIEW -
extension type_of_excercise: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0) {
            
            let cell:type_of_excercise_table_cell = tableView.dequeueReusableCell(withIdentifier: "type_one") as! type_of_excercise_table_cell
            
            cell.backgroundColor = .clear
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            
            cell.imagee.image = UIImage(named: "exc_2")
            cell.btn_excercise.setTitle("Aerobic Excercise", for: .normal)
            cell.btn_excercise.addTarget(self, action: #selector(exc_1_click_method), for: .touchUpInside)
            
            return cell
            
        } else {
            
            let cell:type_of_excercise_table_cell = tableView.dequeueReusableCell(withIdentifier: "type_two") as! type_of_excercise_table_cell
            
            cell.backgroundColor = .clear
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = backgroundView
            
            cell.imagee2.image = UIImage(named: "exc_1")
            cell.btn_excercise2.setTitle("GYM Excercise", for: .normal)
            cell.btn_excercise2.addTarget(self, action: #selector(exc_2_click_method), for: .touchUpInside)
            
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 374
    }

}
