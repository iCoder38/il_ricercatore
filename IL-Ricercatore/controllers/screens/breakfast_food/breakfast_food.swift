//
//  breakfast_food.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 16/12/23.
//

import UIKit

class breakfast_food: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tble_view:UITableView! {
        didSet {
            tble_view.delegate = self
            tble_view.dataSource = self
            tble_view.layer.cornerRadius = 22
            tble_view.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var txt_search:UITextField! {
        didSet {
            txt_search.layer.cornerRadius = 8
            txt_search.clipsToBounds = true
            txt_search.backgroundColor = .clear
            txt_search.placeholder = "Search..."
            txt_search.setLeftPaddingPoints(20)
        }
    }
    @IBOutlet weak var view_search:UIView! {
        didSet {
            view_search.layer.cornerRadius = 8
            view_search.clipsToBounds = true
            view_search.backgroundColor = .white
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tble_view.separatorColor = .gray
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    @objc func calorie_counter_click_method() {
        
    }
}

//MARK:- TABLE VIEW -
extension breakfast_food: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:breakfast_food_table_cell = tableView.dequeueReusableCell(withIdentifier: "breakfast_food_table_cell") as! breakfast_food_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
         
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "calorie_information_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

}

