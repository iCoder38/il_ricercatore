//
//  calorie_information.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 19/12/23.
//

import UIKit

class calorie_information: UIViewController {

    @IBOutlet weak var btn_menu:UIButton! {
        didSet {
            btn_menu.tintColor = .white
            btn_menu.addTarget(self, action: #selector(menu_click_method), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var lbl_navigation_title:UILabel! {
        didSet {
            lbl_navigation_title.text = navigation_title_calorie_counter_en
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
    
    @objc func edit_calorie_budget_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "eat_meal_time_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
}


//MARK:- TABLE VIEW -
extension calorie_information: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:calorie_information_table_cell = tableView.dequeueReusableCell(withIdentifier: "calorie_information_table_cell") as! calorie_information_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        cell.btn_calories_budget.addTarget(self, action: #selector(edit_calorie_budget_click_method), for: .touchUpInside)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 326
    }

}
