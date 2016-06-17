//
//  TaskListViewController.swift
//  todo
//
//  Created by 祝韶明 on 16/5/23.
//  Copyright © 2016年 祝韶明. All rights reserved.
//

import UIKit

class TaskListViewController: UITableViewController, ProtocolTaskDetail {
    
    var taskList: TypeItem?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = taskList?.name
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    func addTask(task: TaskItem) {
        taskList?.items.append(task)
    }
    
    func editTask() {
        self.tableView.reloadData()
    }
    
    //检查是否已完成
    func checkFinishState(task: TaskItem) -> UIImage {
        var image: UIImage
        if task.isFinish {
            image = UIImage(named: "checkbox-checked")!
        } else {
            image = UIImage(named: "checkbox-normal")!
        }
        return image
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (taskList?.items.count)!
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("taskCell", forIndexPath: indexPath)
        let task = taskList!.items[indexPath.row]
        let title = cell.viewWithTag(100) as! UILabel
        title.text = task.title + "(\(LevelItem.getTitle(task.level)))"
        title.sizeToFit()
        let checkBox = cell.viewWithTag(99) as! UIImageView
        checkBox.image = checkFinishState(task)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let task = taskList?.items[indexPath.row]
        task!.changeFinishState()
        print(taskList?.items[indexPath.row].shouldRemind)
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        let checkBox = cell!.viewWithTag(99) as! UIImageView
        checkBox.image = checkFinishState(task!)
        todoModel.saveData()
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            taskList?.items.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            todoModel.saveData()
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    override func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "删除"
    }

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
        let taskDetailVC = segue.destinationViewController as! TaskDetailViewController
        taskDetailVC.delegate = self
        if segue.identifier == "AddTask" {
            taskDetailVC.isAddState = true
        } else if segue.identifier == "EditTask" {
            let indexPath = self.tableView.indexPathForCell(sender as! UITableViewCell)
            taskDetailVC.taskItem = taskList!.items[indexPath!.row]
            taskDetailVC.isAddState = false
        }
    }


}
