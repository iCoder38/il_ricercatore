//
//  workout_gym_exc_details.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 25/06/24.
//

import UIKit
import Alamofire

class workout_gym_exc_details: UIViewController {
    
    var arr_get_details:NSMutableArray! = []
    
    var str_get_date:String!
    
    var exc_id:String!
    var dict_exc_details:NSDictionary!
    
    @IBOutlet weak var btn_add_exercise:UIButton! {
        didSet {
            btn_add_exercise.setTitle("+ Add exercise", for: .normal)
        }
    }
    
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
            // tble_view.delegate = self
            // tble_view.dataSource = self
            // tble_view.layer.cornerRadius = 22
            // tble_view.clipsToBounds = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btn_add_exercise.addTarget(self, action: #selector(add_exercise_click_method), for: .touchUpInside)
        
        self.workout_details()
    }
    
    @objc func add_exercise_click_method() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myAlert = storyboard.instantiateViewController(withIdentifier: "set_gym_exc_sets_id") as? set_gym_exc_sets
        myAlert!.dict_get_gym_exc_details = self.dict_exc_details
        myAlert!.str_date = String(self.str_get_date)
        myAlert!.arr_list_value = self.arr_get_details
        myAlert!.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        myAlert!.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        present(myAlert!, animated: true, completion: nil)
//        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "set_gym_exc_sets_id") as? set_gym_exc_sets
//        self.navigationController?.pushViewController(push!, animated: true)
    }
    
    @objc func workout_details() {
        
        ERProgressHud.sharedInstance.showDarkBackgroundView(withTitle: "Please wait...")
        
        let headers = [
            "x-rapidapi-key": all_exercise_api_key,
            "x-rapidapi-host": all_exercise_host
        ]
        
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://exercise-db-fitness-workout-gym.p.rapidapi.com/exercise/\(self.exc_id!)")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            } else if let httpResponse = response as? HTTPURLResponse, let data = data {
                if httpResponse.statusCode == 200 {
                    do {
                        // Parse the JSON data
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            print(json as Any)
                            print(type(of: json))
                            
                            self.dict_exc_details = json as NSDictionary
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                ERProgressHud.sharedInstance.hide()
                                self.tble_view.delegate = self
                                self.tble_view.dataSource = self
                                self.tble_view.reloadData()
                            }
                            
                            // Extract the secondary muscles
                            if let secondaryMuscles = json["secondaryMuscles"] as? [String] {
                                print("Secondary Muscles: \(secondaryMuscles)")
                            } else {
                                print("Secondary Muscles not found")
                            }
                        } else {
                            print("Failed to parse JSON")
                        }
                    } catch let parseError {
                        print("JSON Error: \(parseError.localizedDescription)")
                    }
                } else {
                    print("HTTP Error: \(httpResponse.statusCode)")
                }
            }
        })
        
        dataTask.resume()
        
    }
    
}


//MARK:- TABLE VIEW -
extension workout_gym_exc_details: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:workout_gym_exc_details_table_cell = tableView.dequeueReusableCell(withIdentifier: "workout_gym_exc_details_table_cell") as! workout_gym_exc_details_table_cell
        
        // let item = self.arr_mut_dashboard_data[indexPath.row] as? [String:Any]
        // print(item as Any)
        
        if let name = self.dict_exc_details["name"] as? String {
            print("Name: \(name)")
            cell.lbl_name.text = "\(name)"
        } else {
            print("Name not found")
        }
        
        
        if let category = self.dict_exc_details["category"] as? String {
            print("category: \(category)")
            cell.lbl_category.text = "\(category)"
        } else {
            print("Name not found")
        }
        
        
        if let force = self.dict_exc_details["force"] as? String {
            print("force: \(force)")
            cell.lbl_force.text = "\(force)"
        } else {
            print("Name not found")
        }
        
        
        if let mechanic = self.dict_exc_details["mechanic"] as? String {
            print("mechanic: \(mechanic)")
            cell.lbl_mechanic.text = "\(mechanic)"
        } else {
            cell.lbl_mechanic.text = "N.A."
        }
        
        
        if let eq = self.dict_exc_details["equipment"] as? String {
            print("eq: \(eq)")
            cell.lbl_equipment.text = "\(eq)"
        } else {
            cell.lbl_equipment.text = "N.A."
        }
        
        
        if let instructions = self.dict_exc_details["instructions"] as? [String] {
                                print("Instructions:")
            
            let combinedInstructions = instructions.joined(separator: "\n\n")
            DispatchQueue.main.async {
                // Assuming `cell` is accessible here, set the text of the label
                cell.lbl_instruction.text = combinedInstructions
            }
            
            for instruction in instructions {
                print(instruction)
                // cell.lbl_instruction.text = "\(instruction)"
            }
        } else {
            print("Instructions not found")
        }
        
        // https://raw.githubusercontent.com/yuhonas/free-exercise-db/main/exercises/90_90_Hamstring/0.jpg
        
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
        return 1200
    }

}
