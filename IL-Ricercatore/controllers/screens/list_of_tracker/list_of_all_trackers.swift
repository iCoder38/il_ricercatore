//
//  list_of_all_trackers.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 18/07/24.
//

import UIKit

class list_of_all_trackers: UIViewController {

    @IBOutlet weak var btn_back:UIButton! {
        didSet {
            btn_back.tintColor = .white
            btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        }
    }
   
    @IBOutlet weak var view_navigation_title:UILabel! {
        didSet {
            view_navigation_title.text = "TRACKERS"
            view_navigation_title.textColor = .white
        }
    }
    
    @IBOutlet weak var tbleView: UITableView! {
        didSet {
            tbleView.tableFooterView = UIView.init(frame: CGRect(origin: .zero, size: .zero))
            tbleView.backgroundColor = .white
             
            
        }
    }
    
    var arr_trackers = [
        "Water tracker",
        "Sleep tracker",
        "Step tracker",
        "Weight tracker",
        "Blood glucose",
        "Blood pressure",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbleView.delegate = self
        tbleView.dataSource = self
    }
    
    @objc func water_track_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "water_intake_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    @objc func sleep_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "sleep_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    @objc func steps_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "steps_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    @objc func heart_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "heart_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    @objc func weight_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "weight_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    @objc func blood_pressure_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "blood_pressure_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    @objc func add_glucose_click_methd() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "blood_glucose_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
}

//MARK:- TABLE VIEW -
extension list_of_all_trackers: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_trackers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:trackers_table_cell = tableView.dequeueReusableCell(withIdentifier: "trackers_table_cell") as! trackers_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        cell.lbl_title.text = self.arr_trackers[indexPath.row]
        
        cell.accessoryType = .disclosureIndicator
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         
        if (indexPath.row == 0) {
            sleep_click_method()
        } else if (indexPath.row == 1) {
            steps_click_method()
        } else if (indexPath.row == 2) {
            heart_click_method()
        } else if (indexPath.row == 3) {
            weight_click_method()
        } else if (indexPath.row == 4) {
            blood_pressure_click_method()
        } else if (indexPath.row == 5) {
            add_glucose_click_methd()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}
