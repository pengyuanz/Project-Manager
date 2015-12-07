//
//  ProgressTableViewController.swift
//  Sudu
//
//  Created by xiwei feng on 12/5/15.
//  Copyright © 2015 xiwei feng. All rights reserved.
//

import UIKit

class ProgressTableViewController: UITableViewController {
    
    // Properties
    var projects = [String]()
    var progress = [Int]()
    var projectId: String?
    var email:String?
    
    @IBAction func addNewProject(sender: UIBarButtonItem) {
        projects += ["Section4"]
        progress += [66]
    }
    
    func loadSampleData() {
        projects += ["Section1", "Section2", "Section3"]
        progress += [50, 70, 90]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSampleData()
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

        cell.projectLabel.text = projects[indexPath.row]
        cell.progressLabel.text = String(progress[indexPath.row]) + "%"
        cell.progressBar.setProgress(Float(progress[indexPath.row])/Float(100), animated: true)
        // Configure the cell...

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
