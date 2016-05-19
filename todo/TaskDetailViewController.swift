//
//  TaskDetailViewController.swift
//  todo
//
//  Created by 祝韶明 on 16/5/18.
//  Copyright © 2016年 祝韶明. All rights reserved.
//

import UIKit

class TaskDetailViewController: UITableViewController, ProtocolIconView {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var taskItem: TaskItem = TaskItem.init(name: "")
    
    //设置状态，以便查看当前是 item 1 还是 item 2
    var isAddState: Bool = true
    
    func onAddState() {
        isAddState = true
        //设为新数据
        taskItem = TaskItem(name: "")
        self.title = "添加"
        //清空文本框内的内容
        updateView()
    }
    
    func onEditState(taskItem: TaskItem) {
        
        isAddState = false
        self.title = "编辑任务"
        self.taskItem = taskItem
        
    }
    
    //更新视图的内容
    func updateView() {
        self.textField.text = taskItem.name
    }
    
    //当页面加载完毕之后就可以将数据载入控件中
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        updateView()
        textField.becomeFirstResponder()
        if isAddState {
            doneButton.enabled = false
        } else {
            doneButton.enabled = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        self.tabBarController?.selectedIndex = 0
        onAddState()
    }
    @IBAction func done(sender: UIBarButtonItem) {
        taskItem.name = textField.text!
        
        if isAddState {
            todoModel.addTask(taskItem)
        } else {
            let navigation = self.tabBarController?.viewControllers?[0] as! UINavigationController
            let taskView = navigation.viewControllers.first as! TaskViewController
            taskView.tableView.reloadData()
        }
        
        //跳转页面
        self.tabBarController?.selectedIndex = 0
        //改变状态
        onAddState()
        
    }
    
    //实现协议里的方法
    func iconPick(didPickIcon iconName: String) {
        
        //设置当前页面数据的 icon 属性
        self.taskItem.icon = iconName
        
        //设置列表中的 icon
        iconImageView.image = UIImage(named: iconName)
        
        //跳转页面
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "IconPick" {
            let iconViewController = segue.destinationViewController as? IconViewController
            iconViewController?.delegate = self
        }
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
