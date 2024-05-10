//
//  calories_burnout.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 10/05/24.
//

import UIKit
import Foundation

class calories_burnout: UIViewController {

    @IBOutlet weak var btn_back:UIButton! {
        didSet {
            btn_back.tintColor = .white
            btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        }
    }
   
    @IBOutlet weak var view_navigation_title:UILabel! {
        didSet {
            view_navigation_title.text = "CAL BURNT"
            view_navigation_title.textColor = .white
        }
    }
    
    @IBOutlet weak var tbleView: UITableView! {
        didSet {
            tbleView.tableFooterView = UIView.init(frame: CGRect(origin: .zero, size: .zero))
            tbleView.backgroundColor = .white
            tbleView.delegate = self
            tbleView.dataSource = self
            
        }
    }
    
    @IBOutlet weak var view_total_cal:UIView! {
        didSet {
            view_total_cal.layer.cornerRadius = 8
            view_total_cal.clipsToBounds = true
            view_total_cal.backgroundColor = light_pink_color
        }
    }
    @IBOutlet weak var lbl_total_count:UILabel!
    @IBOutlet weak var lbl_text:UILabel!
    
    @IBOutlet weak var btn_add_more:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btn_add_more.addTarget(self, action: #selector(add_more_click_method), for: .touchUpInside)
        
        // self.rapid_api_cal_burnt()
    }
    
    @objc func add_more_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "calories_set_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    
}

//MARK:- TABLE VIEW -
extension calories_burnout: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:calories_burnout_table_cell = tableView.dequeueReusableCell(withIdentifier: "calories_burnout_table_cell") as! calories_burnout_table_cell
        
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

}
