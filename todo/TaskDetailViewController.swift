//
//  TaskDetailViewController.swift
//  todo
//
//  Created by 祝韶明 on 16/5/31.
//  Copyright © 2016年 祝韶明. All rights reserved.
//

import UIKit

protocol ProtocolTaskDetail {
    func addTask(task: TaskItem)
    func editTask()
}

class TaskDetailViewController: UITableViewController, ProtocolLevel {

    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var switchControl: UISwitch!
    @IBOutlet weak var timeLabel: UILabel!
    
    var taskItem = TaskItem(title: "", isFinish: false, dueDate: NSDate(), shouldRemind: true, level: 0)
    var isAddState: Bool = true
    var delegate: ProtocolTaskDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !isAddState {
            self.title = "编辑任务"
        } else {
            self.title = "添加任务"
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        //显示默认数据
        updateUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateUI() {
        taskNameTextField.text = taskItem.title
        let level = taskItem.level
        switchControl.on = taskItem.shouldRemind
        levelLabel.text = LevelItem.getTitle(level)
        updateTimeLabel()
    }
    
    func updateTimeLabel() {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy年MM月dd日 hh:mm"
        self.timeLabel.text = formatter.stringFromDate(taskItem.dueDate)
    }
    
    @IBAction func cancelButton(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }

    @IBAction func doneButton(sender: UIBarButtonItem) {
        taskItem.title = taskNameTextField.text!
        taskItem.shouldRemind = switchControl.on
        if isAddState {
            delegate?.addTask(taskItem)
        } else {
            delegate?.editTask()
        }
        self.navigationController?.popViewControllerAnimated(true)
        todoModel.saveData()
        taskItem.scheduledNotification()
    }
    
    @IBAction func dateChange(sender: UIDatePicker) {
        taskItem.dueDate = sender.date
        updateTimeLabel()
    }
    
    func getLevel(levelItem: LevelItem) {
        levelLabel.text = levelItem.title
        taskItem.level = levelItem.level
        self.navigationController?.popViewControllerAnimated(true)
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        taskNameTextField.resignFirstResponder()
    }
    
    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
        let levelVC = segue.destinationViewController as! LevelTableViewController
        levelVC.delegate = self
        levelVC.setCheckMark(taskItem.level)
    }
    

}
