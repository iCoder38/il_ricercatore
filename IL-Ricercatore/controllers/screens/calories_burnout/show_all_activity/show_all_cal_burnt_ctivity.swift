//
//  show_all_cal_burnt_ctivity.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 10/05/24.
//

import UIKit

class show_all_cal_burnt_ctivity: UIViewController {

    var get_array:Array<Any>!
    
    @IBOutlet weak var btn_back:UIButton! {
        didSet {
            btn_back.tintColor = .white
            btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        }
    }
   
    @IBOutlet weak var view_navigation_title:UILabel! {
        didSet {
            view_navigation_title.text = "SELECT"
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tbleView.reloadData()
    }
}


//MARK:- TABLE VIEW -
extension show_all_cal_burnt_ctivity: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.get_array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:show_all_cal_burnt_ctivity_table_cell = tableView.dequeueReusableCell(withIdentifier: "show_all_cal_burnt_ctivity_table_cell") as! show_all_cal_burnt_ctivity_table_cell
        
        let item = self.get_array[indexPath.row] as? [String:Any]
        // print(item as Any)
        
        cell.lbl_title.text = (item!["name"] as! String)
        
        cell.lbl_calories_per_hr.text = "Calories per hour: \(item!["calories_per_hour"]!)"
        cell.lbl_duration.text = "Duration: \(item!["duration_minutes"]!)"
        cell.lbl_total_calories.text = "Total calories: \(item!["total_calories"]!)"
        
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
        return 166
    }

}
