//
//  MemberTableViewController.swift
//  Sudu
//
//  Created by xiwei feng on 12/5/15.
//  Copyright © 2015 xiwei feng. All rights reserved.
//

import UIKit

class MemberTableViewController: UITableViewController {
    
    var photos = [UIImage]()
    var members = [String]()
    var projectId:String?
    var email:String?
    
    func loadSampleData() {
        //members += ["Xiwei Feng", "Guihao Liang", "Pengyuan Zhao"]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let retriveMemberURL = NSURL(string: "https://superuserdue.herokuapp.com/sudu6770/projects/")
        let request = NSMutableURLRequest(URL: retriveMemberURL!)
        request.HTTPMethod = "POST"
        let postString = "email_addr=" + email! + "&project_name=" + projectId!
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            if error != nil {
                print("error=\(error)")
                return
            }
            
            if let httpResponse = response as? NSHTTPURLResponse {
                print("\(httpResponse)")
                if httpResponse.statusCode == 200 {
                    let personalProjects = NSString(data: data!, encoding:NSUTF8StringEncoding)
                    let arr = personalProjects!.componentsSeparatedByString(",")
                    for index in 0..<arr.count/4 {
                        self.members += [arr[index * 4 + 1]]
                    }
                    dispatch_async(dispatch_get_main_queue(), {
                        //Code that presents or dismisses a view controller here
                        self.tableView.reloadData()
                    })
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
        return members.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MemberTableViewCell", forIndexPath: indexPath) as! MemberTableViewCell

        // Configure the cell...
        cell.memberName.text = members[indexPath.row]

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
