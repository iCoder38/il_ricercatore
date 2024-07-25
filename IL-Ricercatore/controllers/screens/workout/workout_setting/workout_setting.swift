//
//  workout_setting.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 20/12/23.
//

import UIKit

class workout_setting: UIViewController {

    
    var str_from_where:String!
    
    var arr_days = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday",]
    var arr_show:NSMutableArray! = []
    @IBOutlet weak var btn_menu:UIButton! {
        didSet {
            btn_menu.tintColor = .white
            btn_menu.addTarget(self, action: #selector(menu_click_method), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var lbl_navigation_title:UILabel! {
        didSet {
            lbl_navigation_title.text = navigation_title_workout_setting_en
        }
    }
    
    @IBOutlet weak var tble_view:UITableView! {
        didSet {
            
            tble_view.layer.cornerRadius = 22
            tble_view.clipsToBounds = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tble_view.separatorColor = .gray
        
        for indexx in 0..<arr_days.count {
            let item = self.arr_days[indexx]
            
            var custom = [
                "id":"\(indexx+1)",
                "name":"\(item)",
            ]
            
            self.arr_show.add(custom)
        }
        
        tble_view.delegate = self
        tble_view.dataSource = self
        tble_view.reloadData()
        print(self.self.arr_show as Any)
        
    }
}

//MARK:- TABLE VIEW -
extension workout_setting: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_show.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:workout_setting_table_cell = tableView.dequeueReusableCell(withIdentifier: "workout_setting_table_cell") as! workout_setting_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        let item = self.arr_show[indexPath.row] as? [String:Any]
        
        cell.lbl_title.text = (item!["name"] as! String)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = self.arr_show[indexPath.row] as? [String:Any]
        
        let defaults = UserDefaults.standard
        defaults.set("dashboard_right_arrow", forKey: "key_save_dashboard_right_arrow")
        
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "days_workout_id") as? days_workout
        push!.str_what_day_user_select = (item!["id"] as! String)
        push!.str_profile_select_from_dashboard = "3"
        self.navigationController?.pushViewController(push!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}
