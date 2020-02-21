//
//  TimeLineViewController.swift
//  SwiftPetSNS
//
//  Created by Yamada, Masaya on 2/21/20.
//  Copyright © 2020 Yamada, Masaya. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
import SVProgressHUD


class TimeLineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    var fullName_Array = [String]()
    var postImage_Array = [String]()
    var comment_Array = [String]()
    
    var posts = [Post]()
    var posst = Post()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        refreshControl.attributedTitle = NSAttributedString(string: "引っ張って更新")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchPost()
        tableView.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super .viewDidAppear(animated)
        
        SVProgressHUD.dismiss()
        
    }
    
    @objc func refresh(){
        
    }
    
    func fetchPost(){
        
        // 初期化
        self.posts = [Post]()
        self.fullName_Array = [String]()
        self.postImage_Array = [String]()
        self.comment_Array = [String]()
        self.posst = Post()
        
        
        let ref = Database.database().reference()
        //最新の情報の１０件を取ってくる
        ref.child("post").queryLimited(toFirst: 10).observeSingleEvent(of: .value) {
            (snap, error) in
            
            let postSnap = snap.value as? [String:NSDictionary]
            if postSnap == nil {
                return
            }
            
            self.posts = [Post]()
            
            for(_, post) in postSnap! {
                self.posts = [Post]()
                self.fullName_Array = [String]()
                self.postImage_Array = [String]()
                self.comment_Array = [String]()
                self.posst = Post()
                
                if let comment = post["comment"] as? String,
                    let userName = post["fullName"] as? String,
                    let postImage = post["postImage"] as? String{
                    
                    self.posst.comment = comment
                    self.posst.fullName = userName
                    self.posst.postImage = postImage
                    
                    self.comment_Array.append(self.posst.comment)
                    self.fullName_Array.append(self.posst.fullName)
                    self.postImage_Array.append(self.posst.postImage)
                }
                    self.posts.append(self.posst)
            
            }
            
                self.tableView.reloadData()
            
        }
        
        
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let positionImageView = cell.viewWithTag(1) as? UIImageView
        let profileImageURL = URL(string: self.posts[indexPath.row].postImage as String)!
        
        
        
        
        return nil
    }

}
