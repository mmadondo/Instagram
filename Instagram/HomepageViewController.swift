//
//  HomepageViewController.swift
//  Instagram
//
//  Created by Malvern Madondo on 6/27/17.
//  Copyright © 2017 Malvern Madondo. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class HomepageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    var instaPosts: [PFObject] = []
    var refreshCtrl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialize refresh control
        refreshCtrl = UIRefreshControl()
        refreshCtrl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        
        //add refresh control to table view
        tableView.insertSubview(refreshCtrl, at: 0)
        
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        
        refresh()
        self.tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }
    
    func refreshControlAction(_ refreshCtrl: UIRefreshControl){
        refresh()
        
    }
    
    func refresh() {

        // construct PFQuery
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.limit = 20

        // fetch data asynchronously
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let error = error {
                
                print(error.localizedDescription) //handle error
                
            } else if let posts = posts {
                
                self.instaPosts = posts
                
                for post in self.instaPosts {
                    let caption = post["caption"] as! String
                    print(caption)
                }
                
                self.tableView.reloadData()
            }
            
            self.refreshCtrl.endRefreshing()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return instaPosts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        
        let post = instaPosts[indexPath.section]
        
        let caption = post["caption"] as! String
        let imageToPost = post["media"] as! PFFile
        
        cell.captionLabel.text = caption
        cell.photoView.file = imageToPost
        //cell.userLabel.text = author.username
        
        cell.photoView.loadInBackground()
        
        cell.selectionStyle = .none

        return cell
    }
    
    
    func alertUser() {
        
        let alertController = UIAlertController(title: "Cannot retrieve data", message: "Check your connection", preferredStyle: .alert)
        
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
            
        }
        
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        
        present(alertController, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     let cell = sender as! UITableViewCell
     if let indexPath = tableView.indexPath(for: cell){
     let post = instaPosts[indexPath.row]
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     let cameraViewCtrllr = segue.destination as! CameraViewController
     //cameraViewCtrllr. = post
     }
     
     }
     
     */
    
    
    
}
