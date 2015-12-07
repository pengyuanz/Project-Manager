//
//  ProjectTableViewController.swift
//  Sudu
//
//  Created by xiwei feng on 12/5/15.
//  Copyright © 2015 xiwei feng. All rights reserved.
//

import UIKit

class ProjectTableViewController: UITableViewController {
    
    // Mark: Properties
    var email: String?
    var projects = [String]()
    var progress = [Int]()
    
    func loadSampleProjects() {
        //projects += ["project1", "project2", "project3"]
        //progress += [50, 70, 90]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let retriveProjectURL = NSURL(string: "https://superuserdue.herokuapp.com/sudu6770/personal/")
        let request = NSMutableURLRequest(URL: retriveProjectURL!)
        request.HTTPMethod = "POST"
        
        let postString = "email_addr=" + email!
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    let personalProjects = NSString(data: data!, encoding:NSUTF8StringEncoding)
                    self.projects = personalProjects!.componentsSeparatedByString(",")
                    for _ in 0..<self.projects.count {
                        self.progress += [Int(arc4random_uniform(100))]
                    }
                    self.tableView.reloadData()
                }
                else {
                    print("Something failed!")
                }
            }
        }
        
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return projects.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ProjectTableViewCell", forIndexPath: indexPath) as! ProjectTableViewCell
        
        // Configure the cell...
        cell.projectLabel.text = projects[indexPath.row]
        cell.progressLabel.text = String(progress[indexPath.row]) + "%"
        cell.progressBar.setProgress(Float(progress[indexPath.row])/Float(100), animated: true)

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        // Get the cell that generated this segue.
        
        let projectId:String?
        if let selectedCell = sender as? ProjectTableViewCell {
            projectId = selectedCell.projectLabel.text
        }
        else {
            projectId = nil
        }
        
        let tabBarViewController = segue.destinationViewController as! UITabBarController
        for index in 0..<tabBarViewController.viewControllers!.count {
            let navigationViewController = tabBarViewController.viewControllers![index] as! UINavigationController
            // Project tab
            if let viewController = navigationViewController.topViewController as? ProgressTableViewController {
                viewController.email = self.email
                viewController.projectId = projectId
            }
            // Member tab
            else if let viewController = navigationViewController.topViewController as? MemberTableViewController {
                viewController.email = self.email
                viewController.projectId = projectId
            }
            // Chat tab
            else if let viewController = navigationViewController.topViewController as? MemberViewController {
                viewController.email = self.email
                viewController.projectId = projectId
            }
        }
    }


}
