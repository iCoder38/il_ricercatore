//
//  select_workout.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 21/12/23.
//

import UIKit

class select_workout: UIViewController {

    let arr_dummy = ["Bench Press","Squats","Push-up","Bicep curl","Burpee","Overhead pass","Pull-up"]
    @IBOutlet weak var btn_back:UIButton! {
        didSet {
            btn_back.tintColor = .black
            btn_back.setImage(UIImage(systemName: "arrow.left"), for: .normal)
            btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var lbl_navigation_title:UILabel! {
        didSet {
            lbl_navigation_title.text = navigation_title_select_workout_en
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
    
    @IBOutlet weak var view_search:UIView! {
        didSet {
            view_search.layer.cornerRadius = 8
            view_search.clipsToBounds = true
            view_search.backgroundColor = .white
        }
    }
    
    @IBOutlet weak var txt_search:UITextField! {
        didSet {
            txt_search.layer.cornerRadius = 8
            txt_search.clipsToBounds = true
            txt_search.backgroundColor = .clear
            txt_search.placeholder = "Search..."
            // txt_search.setLeftPaddingPoints(20)
        }
    }
    
    @IBOutlet weak var btn_continue:UIButton! {
        didSet {
            btn_continue.layer.cornerRadius = 8
            btn_continue.clipsToBounds = true
            btn_continue.setTitle("Continue".uppercased(), for: .normal)
            btn_continue.setTitleColor(.white, for: .normal)
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
    
    @objc func continue_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "workout_details_id")
        self.navigationController?.pushViewController(push, animated: true)
    }
    
}

//MARK:- TABLE VIEW -
extension select_workout: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_dummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:select_workout_table_cell = tableView.dequeueReusableCell(withIdentifier: "select_workout_table_cell") as! select_workout_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        cell.lbl_title.text = self.arr_dummy[indexPath.row]
        
        self.btn_continue.addTarget(self, action: #selector(continue_click_method), for: .touchUpInside)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        /*let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "calorie_information_id")
        self.navigationController?.pushViewController(push, animated: true)*/
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}
