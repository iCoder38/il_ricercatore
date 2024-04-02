//
//  post_details.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 02/04/24.
//

import UIKit
import SDWebImage

class post_details: UIViewController {

    var dictDetails:NSDictionary!
    
    @IBOutlet weak var btn_back:UIButton! {
        didSet {
            btn_back.tintColor = .white
            btn_back.setImage(UIImage(systemName: "arrow.left"), for: .normal)
            btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        }
    }
    
    @IBOutlet weak var lbl_navigation_title:UILabel! {
        didSet {
            lbl_navigation_title.text = navigation_title_post_details
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
        print(self.dictDetails as Any)
        
        self.tble_view.delegate = self
        self.tble_view.dataSource = self
        self.tble_view.reloadData()
    }
    
}


//MARK:- TABLE VIEW -
extension post_details: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:post_details_table_cell = tableView.dequeueReusableCell(withIdentifier: "post_details_table_cell") as! post_details_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        if (self.dictDetails["imageType"] as! String) == "Video" {
            cell.btn_play.isHidden = false
            cell.img_profile.isHidden = true
        } else {
            cell.btn_play.isHidden = true
            cell.img_profile.isHidden = false
            cell.img_profile.sd_imageIndicator = SDWebImageActivityIndicator.whiteLarge
            cell.img_profile.sd_setImage(with: URL(string: (self.dictDetails["image"] as! String)), placeholderImage: UIImage(named: "logo"))
        }
        
        cell.lbl_title.text = (self.dictDetails["name"] as! String)
        cell.lbl_comments_likes.text = "Comments  (\(self.dictDetails["total_comment"]!))     Like  (\(self.dictDetails["total_Like"]!))"
        cell.lbl_description.text = (self.dictDetails["description"] as! String)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}
