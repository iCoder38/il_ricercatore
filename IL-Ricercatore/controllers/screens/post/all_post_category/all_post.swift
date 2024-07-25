//
//  all_post.swift
//  IL-Ricercatore
//
//  Created by Dishant Rajput on 22/03/24.
//

import UIKit

class all_post: UIViewController {

    @IBOutlet weak var btn_back:UIButton! {
        didSet {
            btn_back.tintColor = .white
            btn_back.setImage(UIImage(systemName: "arrow.left"), for: .normal)
            btn_back.addTarget(self, action: #selector(back_click_method), for: .touchUpInside)
        }
    }
     
    @IBOutlet weak var lbl_navigation_title:UILabel! {
        didSet {
            lbl_navigation_title.text = navigation_title_daily_q
        }
    }
    @IBOutlet weak var tble_view:UITableView! {
        didSet {
            tble_view.delegate = self
            tble_view.dataSource = self
            // tble_view.layer.cornerRadius = 22
            tble_view.clipsToBounds = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tble_view.separatorColor = .clear
    }
    
    @objc func daily_q_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "daily_q_id") as? daily_q
        push!.str_post_type = String("DailyQ")
        self.navigationController?.pushViewController(push!, animated: true)
    }
    
    @objc func article_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "daily_q_id") as? daily_q
        push!.str_post_type = String("Article")
        self.navigationController?.pushViewController(push!, animated: true)
    }
    @objc func stories_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "daily_q_id") as? daily_q
        push!.str_post_type = String("Story")
        self.navigationController?.pushViewController(push!, animated: true)
    }
    @objc func forum_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "daily_q_id") as? daily_q
        push!.str_post_type = String("Forum")
        self.navigationController?.pushViewController(push!, animated: true)
    }
    @objc func milestones_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "daily_q_id") as? daily_q
        push!.str_post_type = String("Milestone")
        self.navigationController?.pushViewController(push!, animated: true)
    }
    @objc func faq_click_method() {
        let push = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "faq_id") as? faq
        // push!.str_post_type = String("Faq")
        self.navigationController?.pushViewController(push!, animated: true)
    }
}

//MARK:- TABLE VIEW -
extension all_post: UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:all_post_table_cell = tableView.dequeueReusableCell(withIdentifier: "all_post_table_cell") as! all_post_table_cell
        
        cell.backgroundColor = .clear
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = backgroundView
        
        cell.btn_daily_q.addTarget(self, action: #selector(daily_q_click_method), for: .touchUpInside)
        cell.btn_article.addTarget(self, action: #selector(article_click_method), for: .touchUpInside)
        cell.btn_stories.addTarget(self, action: #selector(stories_click_method), for: .touchUpInside)
        cell.btn_forum.addTarget(self, action: #selector(forum_click_method), for: .touchUpInside)
        cell.btn_milestones.addTarget(self, action: #selector(milestones_click_method), for: .touchUpInside)
        cell.btn_faq.addTarget(self, action: #selector(faq_click_method), for: .touchUpInside)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 538
    }

}
