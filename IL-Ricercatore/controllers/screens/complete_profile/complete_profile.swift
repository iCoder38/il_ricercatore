//
//  complete_profile.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 16/12/23.
//

import UIKit

class complete_profile: UIViewController, UITextFieldDelegate {
    
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    @objc func male_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_table_cell
        
        cell.btn_male.setBackgroundImage(UIImage(named: "blue"), for: .normal)
        cell.btn_female.setBackgroundImage(UIImage(named: ""), for: .normal)
        cell.btn_other.setBackgroundImage(UIImage(named: ""), for: .normal)
        
        cell.btn_male.setTitleColor(.white, for: .normal)
        cell.btn_female.setTitleColor(.black, for: .normal)
        cell.btn_other.setTitleColor(.black, for: .normal)
    }
    
    @objc func female_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_table_cell
        
        cell.btn_male.setBackgroundImage(UIImage(named: ""), for: .normal)
        cell.btn_female.setBackgroundImage(UIImage(named: "blue"), for: .normal)
        cell.btn_other.setBackgroundImage(UIImage(named: ""), for: .normal)
     
        cell.btn_male.setTitleColor(.black, for: .normal)
        cell.btn_female.setTitleColor(.white, for: .normal)
        cell.btn_other.setTitleColor(.black, for: .normal)
        
    }
    
    @objc func other_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! complete_profile_table_cell
        
        cell.btn_male.setBackgroundImage(UIImage(named: ""), for: .normal)
        cell.btn_female.setBackgroundImage(UIImage(named: ""), for: .normal)
        cell.btn_other.setBackgroundImage(UIImage(named: "blue"), for: .normal)
        
        cell.btn_male.setTitleColor(.black, for: .normal)
        cell.btn_female.setTitleColor(.black, for: .normal)
        cell.btn_other.setTitleColor(.white, for: .normal)
        
    }
    
    @objc func complete_profile_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "complete_profile_two_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
}

//MARK:- TABLE VIEW -
extension complete_profile: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:complete_profile_table_cell = tableView.dequeueReusableCell(withIdentifier: "complete_profile_table_cell") as! complete_profile_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        cell.btn_male.addTarget(self, action: #selector(male_click_method), for: .touchUpInside)
        cell.btn_female.addTarget(self, action: #selector(female_click_method), for: .touchUpInside)
        cell.btn_other.addTarget(self, action: #selector(other_click_method), for: .touchUpInside)
        
        cell.btn_continue.addTarget(self, action: #selector(complete_profile_click_method), for: .touchUpInside)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
    }

}
