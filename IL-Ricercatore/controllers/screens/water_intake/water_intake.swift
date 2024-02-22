//
//  water_intake.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 19/12/23.
//

import UIKit

class water_intake: UIViewController {

    @IBOutlet weak var btn_menu:UIButton! {
        didSet {
            btn_menu.tintColor = .white
            btn_menu.addTarget(self, action: #selector(menu_click_method), for: .touchUpInside)
        }
    }
    
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
            lbl_navigation_title.text = navigation_title_water_intake_en
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
    
    @objc func reminder_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "water_reminder_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    @objc func water_count_edit_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "set_up_water_tracker_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
}

//MARK:- TABLE VIEW -
extension water_intake: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:water_intake_table_cell = tableView.dequeueReusableCell(withIdentifier: "water_intake_table_cell") as! water_intake_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        cell.btn_reminder.addTarget(self, action: #selector(reminder_click_method), for: .touchUpInside)
        cell.btn_water_count_edit.addTarget(self, action: #selector(water_count_edit_click_method), for: .touchUpInside)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 314
    }

}
