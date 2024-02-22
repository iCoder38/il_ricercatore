//
//  disease_list.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 22/02/24.
//

import UIKit

class disease_list: UIViewController {

    var arr_disease_list:NSMutableArray = []
    
    var arr_selected_disease:NSMutableArray = []
    
    @IBOutlet weak var tble_view:UITableView! {
        didSet {
            
            tble_view.layer.cornerRadius = 22
            tble_view.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var btn_dismiss:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.btn_dismiss.addTarget(self, action: #selector(dismiss_click_method), for: .touchUpInside)
        
        let custom = [
             
            [
                "name":"Diabetes",
                "status":"0",
            ],
            [
                "name":"Pre-diabetes",
                "status":"0",
            ],
            [
                "name":"Hypertension",
                "status":"0",
            ],
            [
                "name":"Obesity",
                "status":"0",
            ],
            [
                "name":"Thyroid",
                "status":"0",
            ],
            [
                "name":"PCOD",
                "status":"0",
            ],
            [
                "name":"Asthma",
                "status":"0",
            ],
            [
                "name":"Heart attack and stroke",
                "status":"0",
            ],
            [
                "name":"Kidney Disease",
                "status":"0",
            ],
            [
                "name":"Lung Diseases",
                "status":"0",
            ],
            [
                "name":"Cholesterol",
                "status":"0",
            ],
            [
                "name":"Physical Injury",
                "status":"0",
            ],
            [
                "name":"Anger issues",
                "status":"0",
            ],
            [
                "name":"Relationship Stress",
                "status":"0",
            ],
            [
                "name":"Depression",
                "status":"0",
            ],
            [
                "name":"Excessive stress/anxiety",
                "status":"0",
            ],
            [
                "name":"None",
                "status":"0",
            ]
         
        ]
         

        
            
        
        self.arr_disease_list.addObjects(from: custom)
        
        print(custom as Any)
        print(arr_disease_list as Any)
        print(arr_disease_list.count as Any)
        // print(arr_disease_list[0] as Any)
        
        self.tble_view.delegate = self
        self.tble_view.dataSource = self
        self.tble_view.reloadData()
        
    }

    @objc func dismiss_click_method() {
        // self.dismiss(animated: true)
        self.navigationController?.popViewController(animated: false)
    }
    
}

//MARK:- TABLE VIEW -
extension disease_list: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arr_disease_list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:disease_list_table_cell = tableView.dequeueReusableCell(withIdentifier: "disease_list_table_cell") as! disease_list_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        let item = self.arr_disease_list[indexPath.row] as? [String:Any]
        // print(item as Any)
        
        cell.lbl_disease_name.text = (item!["name"] as! String)
        
        cell.btn_checkmark.tag = indexPath.row
        
        if (item!["status"] as! String) == "0" {
            
            cell.btn_checkmark.isHidden = true
        } else {
            cell.btn_checkmark.isHidden = false
            cell.btn_checkmark.setImage(UIImage(systemName: "checkmark"), for: .normal)
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         
        let item = self.arr_disease_list[indexPath.row] as? [String:Any]
        print(item as Any)
        
        var str_selected_name:String! = (item!["name"] as! String)
        var str_selected_status:String! = (item!["status"] as! String)
        
        print("Name ====> "+str_selected_name)
        print("Staus ====> "+str_selected_status)
        print("Index Number ====> "+"\(indexPath.row)")
        
        self.arr_disease_list.removeObject(at: indexPath.row)
        
        if (str_selected_status == "0") {
            var custom =
                [
                "name":str_selected_name,
                "status":"1",
            
            ]
            
            self.arr_selected_disease.add(String(str_selected_name))
            self.arr_disease_list.insert(custom, at: indexPath.row)
            
        } else {
            var custom =
                [
                "name":str_selected_name,
                "status":"0",
            
            ]
            
            self.arr_selected_disease.remove(String(str_selected_name))
            self.arr_disease_list.insert(custom, at: indexPath.row)
            
        }
        
        let swiftArray = NSArray(array: self.arr_selected_disease) as? [String]
        let string = swiftArray!.joined(separator: ",")
        print(string as Any)
        
        UserDefaults.standard.set(string, forKey: "key_save_all_selected_disease")
        
        print(self.arr_selected_disease as Any)
        self.tble_view.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}
