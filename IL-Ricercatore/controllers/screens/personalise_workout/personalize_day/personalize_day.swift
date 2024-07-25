//
//  personalize_day.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 21/12/23.
//

import UIKit

class personalize_day: UIViewController {

    @IBOutlet weak var btn_back:UIButton! {
        didSet {
            btn_back.tintColor = .white
            btn_back.setImage(UIImage(systemName: "arrow.left"), for: .normal)
            btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var lbl_navigation_title:UILabel! {
        didSet {
            lbl_navigation_title.text = "DAY"
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
        self.tble_view.separatorColor = .gray
    }
    
    @objc func yoga_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! personalize_day_table_cell
        
        cell.btn_yoga.setBackgroundImage(UIImage(named: "blue"), for: .normal)
        cell.btn_gym.setBackgroundImage(UIImage(named: ""), for: .normal)
        cell.btn_cardio.setBackgroundImage(UIImage(named: ""), for: .normal)
        cell.btn_strength.setBackgroundImage(UIImage(named: ""), for: .normal)
        cell.btn_sports.setBackgroundImage(UIImage(named: ""), for: .normal)
        cell.btn_none.setBackgroundImage(UIImage(named: ""), for: .normal)
        
        cell.btn_yoga.setTitleColor(.white, for: .normal)
        cell.btn_gym.setTitleColor(.black, for: .normal)
        cell.btn_cardio.setTitleColor(.black, for: .normal)
        cell.btn_strength.setTitleColor(.black, for: .normal)
        cell.btn_sports.setTitleColor(.black, for: .normal)
        cell.btn_none.setTitleColor(.black, for: .normal)
    }
    
    @objc func gym_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! personalize_day_table_cell
        
        cell.btn_yoga.setBackgroundImage(UIImage(named: ""), for: .normal)
        cell.btn_gym.setBackgroundImage(UIImage(named: "blue"), for: .normal)
        cell.btn_cardio.setBackgroundImage(UIImage(named: ""), for: .normal)
        cell.btn_strength.setBackgroundImage(UIImage(named: ""), for: .normal)
        cell.btn_sports.setBackgroundImage(UIImage(named: ""), for: .normal)
        cell.btn_none.setBackgroundImage(UIImage(named: ""), for: .normal)
     
        cell.btn_yoga.setTitleColor(.black, for: .normal)
        cell.btn_gym.setTitleColor(.white, for: .normal)
        cell.btn_cardio.setTitleColor(.black, for: .normal)
        cell.btn_strength.setTitleColor(.black, for: .normal)
        cell.btn_sports.setTitleColor(.black, for: .normal)
        cell.btn_none.setTitleColor(.black, for: .normal)
        
    }
    
    @objc func cardio_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! personalize_day_table_cell
        
        cell.btn_yoga.setBackgroundImage(UIImage(named: ""), for: .normal)
        cell.btn_gym.setBackgroundImage(UIImage(named: ""), for: .normal)
        cell.btn_cardio.setBackgroundImage(UIImage(named: "blue"), for: .normal)
        cell.btn_strength.setBackgroundImage(UIImage(named: ""), for: .normal)
        cell.btn_sports.setBackgroundImage(UIImage(named: ""), for: .normal)
        cell.btn_none.setBackgroundImage(UIImage(named: ""), for: .normal)
        
        cell.btn_yoga.setTitleColor(.black, for: .normal)
        cell.btn_gym.setTitleColor(.black, for: .normal)
        cell.btn_cardio.setTitleColor(.white, for: .normal)
        cell.btn_strength.setTitleColor(.black, for: .normal)
        cell.btn_sports.setTitleColor(.black, for: .normal)
        cell.btn_none.setTitleColor(.black, for: .normal)
        
    }
    
    @objc func strength_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! personalize_day_table_cell
        
        cell.btn_yoga.setBackgroundImage(UIImage(named: ""), for: .normal)
        cell.btn_gym.setBackgroundImage(UIImage(named: ""), for: .normal)
        cell.btn_cardio.setBackgroundImage(UIImage(named: ""), for: .normal)
        cell.btn_strength.setBackgroundImage(UIImage(named: "blue"), for: .normal)
        cell.btn_sports.setBackgroundImage(UIImage(named: ""), for: .normal)
        cell.btn_none.setBackgroundImage(UIImage(named: ""), for: .normal)
        
        cell.btn_yoga.setTitleColor(.black, for: .normal)
        cell.btn_gym.setTitleColor(.black, for: .normal)
        cell.btn_cardio.setTitleColor(.black, for: .normal)
        cell.btn_strength.setTitleColor(.white, for: .normal)
        cell.btn_sports.setTitleColor(.black, for: .normal)
        cell.btn_none.setTitleColor(.black, for: .normal)
    }
    
    @objc func sports_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! personalize_day_table_cell
        
        cell.btn_yoga.setBackgroundImage(UIImage(named: ""), for: .normal)
        cell.btn_gym.setBackgroundImage(UIImage(named: ""), for: .normal)
        cell.btn_cardio.setBackgroundImage(UIImage(named: ""), for: .normal)
        cell.btn_strength.setBackgroundImage(UIImage(named: ""), for: .normal)
        cell.btn_sports.setBackgroundImage(UIImage(named: "blue"), for: .normal)
        cell.btn_none.setBackgroundImage(UIImage(named: ""), for: .normal)
     
        cell.btn_yoga.setTitleColor(.black, for: .normal)
        cell.btn_gym.setTitleColor(.black, for: .normal)
        cell.btn_cardio.setTitleColor(.black, for: .normal)
        cell.btn_strength.setTitleColor(.black, for: .normal)
        cell.btn_sports.setTitleColor(.white, for: .normal)
        cell.btn_none.setTitleColor(.black, for: .normal)
        
    }
    
    @objc func none_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! personalize_day_table_cell
        
        cell.btn_yoga.setBackgroundImage(UIImage(named: ""), for: .normal)
        cell.btn_gym.setBackgroundImage(UIImage(named: ""), for: .normal)
        cell.btn_cardio.setBackgroundImage(UIImage(named: ""), for: .normal)
        cell.btn_strength.setBackgroundImage(UIImage(named: ""), for: .normal)
        cell.btn_sports.setBackgroundImage(UIImage(named: ""), for: .normal)
        cell.btn_none.setBackgroundImage(UIImage(named: "blue"), for: .normal)
        
        cell.btn_yoga.setTitleColor(.black, for: .normal)
        cell.btn_gym.setTitleColor(.black, for: .normal)
        cell.btn_cardio.setTitleColor(.black, for: .normal)
        cell.btn_strength.setTitleColor(.black, for: .normal)
        cell.btn_sports.setTitleColor(.black, for: .normal)
        cell.btn_none.setTitleColor(.white, for: .normal)
        
    }
    
    // 2
    @objc func four_five_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! personalize_day_table_cell
        
        
        cell.btn_45.setBackgroundImage(UIImage(named: "blue"), for: .normal)
        cell.btn_60.setBackgroundImage(UIImage(named: ""), for: .normal)
        cell.btn_90.setBackgroundImage(UIImage(named: ""), for: .normal)
        
        
        cell.btn_45.setTitleColor(.white, for: .normal)
        cell.btn_60.setTitleColor(.black, for: .normal)
        cell.btn_90.setTitleColor(.black, for: .normal)
    }
    
    @objc func siz_zero_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! personalize_day_table_cell
        
        
        cell.btn_45.setBackgroundImage(UIImage(named: ""), for: .normal)
        cell.btn_60.setBackgroundImage(UIImage(named: "blue"), for: .normal)
        cell.btn_90.setBackgroundImage(UIImage(named: ""), for: .normal)
     
        
        cell.btn_45.setTitleColor(.black, for: .normal)
        cell.btn_60.setTitleColor(.white, for: .normal)
        cell.btn_90.setTitleColor(.black, for: .normal)
        
    }
    
    @objc func nine_zero_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! personalize_day_table_cell
        
        
        cell.btn_45.setBackgroundImage(UIImage(named: ""), for: .normal)
        cell.btn_60.setBackgroundImage(UIImage(named: ""), for: .normal)
        cell.btn_90.setBackgroundImage(UIImage(named: "blue"), for: .normal)
        
        
        cell.btn_45.setTitleColor(.black, for: .normal)
        cell.btn_60.setTitleColor(.black, for: .normal)
        cell.btn_90.setTitleColor(.white, for: .normal)
        
    }
    
    // 3
    @objc func morning_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! personalize_day_table_cell
        
        
        cell.btn_morning.setBackgroundImage(UIImage(named: "blue"), for: .normal)
        cell.btn_evening.setBackgroundImage(UIImage(named: ""), for: .normal)
        
        cell.btn_morning.setTitleColor(.white, for: .normal)
        cell.btn_evening.setTitleColor(.black, for: .normal)
        
    }
    
    @objc func evening_click_method() {
        let indexPath = IndexPath.init(row: 0, section: 0)
        let cell = self.tble_view.cellForRow(at: indexPath) as! personalize_day_table_cell
        
        
        cell.btn_morning.setBackgroundImage(UIImage(named: ""), for: .normal)
        cell.btn_evening.setBackgroundImage(UIImage(named: "blue"), for: .normal)
        
        cell.btn_morning.setTitleColor(.black, for: .normal)
        cell.btn_evening.setTitleColor(.white, for: .normal)
        
    }
    
    @objc func continue_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "select_workout_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
}


//MARK:- TABLE VIEW -
extension personalize_day: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:personalize_day_table_cell = tableView.dequeueReusableCell(withIdentifier: "personalize_day_table_cell") as! personalize_day_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
         
        cell.btn_yoga.addTarget(self, action: #selector(yoga_click_method), for: .touchUpInside)
        cell.btn_gym.addTarget(self, action: #selector(gym_click_method), for: .touchUpInside)
        cell.btn_cardio.addTarget(self, action: #selector(cardio_click_method), for: .touchUpInside)
        
        cell.btn_strength.addTarget(self, action: #selector(strength_click_method), for: .touchUpInside)
        cell.btn_sports.addTarget(self, action: #selector(sports_click_method), for: .touchUpInside)
        cell.btn_none.addTarget(self, action: #selector(none_click_method), for: .touchUpInside)
        
        // 2
        cell.btn_45.addTarget(self, action: #selector(four_five_click_method), for: .touchUpInside)
        cell.btn_60.addTarget(self, action: #selector(siz_zero_click_method), for: .touchUpInside)
        cell.btn_90.addTarget(self, action: #selector(nine_zero_click_method), for: .touchUpInside)
        
        // 3
        cell.btn_morning.addTarget(self, action: #selector(morning_click_method), for: .touchUpInside)
        cell.btn_evening.addTarget(self, action: #selector(evening_click_method), for: .touchUpInside)
        
        cell.btn_continue.addTarget(self, action: #selector(continue_click_method), for: .touchUpInside)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }

}
