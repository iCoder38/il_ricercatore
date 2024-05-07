//
//  reminders.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 20/12/23.
//

import UIKit
import SDWebImage

class reminders: UIViewController {

    var arr_reminder:NSMutableArray! = []
    var arr_reminder_image:NSMutableArray! = []
    
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
        
        self.arr_reminder = ["Drink Water", "Meal reminder"]
        self.arr_reminder_image = ["water", "meal"]
        
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
        
        cell.lbl_title.text = (self.arr_reminder[indexPath.row] as! String)
        cell.img_profile.sd_imageIndicator = SDWebImageActivityIndicator.whiteLarge
        cell.img_profile.sd_setImage(with: URL(string: (self.arr_reminder_image[indexPath.row] as! String)), placeholderImage: UIImage(named: "logo"))
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "water_reminders_id")
            self.navigationController?.pushViewController(push, animated: true)
        } else {
            let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "track_meal_reminder_id")
            self.navigationController?.pushViewController(push, animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

}
