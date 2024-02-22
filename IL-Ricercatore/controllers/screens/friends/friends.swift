//
//  friends.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 20/12/23.
//

import UIKit

class friends: UIViewController {

    @IBOutlet weak var btn_menu:UIButton! {
        didSet {
            btn_menu.tintColor = .black
            btn_menu.addTarget(self, action: #selector(menu_click_method), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var lbl_navigation_title:UILabel! {
        didSet {
            lbl_navigation_title.text = navigation_title_friends_en
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tble_view.separatorColor = .white
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
}


//MARK:- TABLE VIEW -
extension friends: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:friends_table_cell = tableView.dequeueReusableCell(withIdentifier: "friends_table_cell") as! friends_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        /*let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "calorie_information_id")
        self.navigationController?.pushViewController(push, animated: true)*/
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

}
