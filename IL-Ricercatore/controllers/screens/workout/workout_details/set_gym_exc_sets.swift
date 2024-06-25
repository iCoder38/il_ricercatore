//
//  set_gym_exc_sets.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 25/06/24.
//

import UIKit

class set_gym_exc_sets: UIViewController {
    
    var str_value:String! = "0"
    
    @IBOutlet weak var btn_add:UIButton!
    @IBOutlet weak var btn_minus:UIButton!
    
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
    
    @IBOutlet weak var lbl_text: UILabel!
    var count: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        self.btn_add.addTarget(self, action: #selector(add_click_method), for: .touchUpInside)
        self.btn_minus.addTarget(self, action: #selector(minus_click_method), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissView() {
            dismiss(animated: true, completion: nil)
        }
    
    @objc func add_click_method() {
        count += 1
        lbl_text.text = "\(count)"
    }
    
    @objc func minus_click_method() {
        if count > 0 {
            count -= 1
            lbl_text.text = "\(count)"
        } 
    }
    
}
