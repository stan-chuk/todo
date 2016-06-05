//
//  TaskTypeViewController.swift
//  todo
//
//  Created by 祝韶明 on 16/5/18.
//  Copyright © 2016年 祝韶明. All rights reserved.
//

import UIKit

class TaskTypeViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    //每当重新加载页面时就刷新数据
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
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
        return todoModel.typeList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TypeCell", forIndexPath: indexPath)
        let taskTypeItem = todoModel.typeList[indexPath.row]
        cell.imageView?.image = UIImage(named: taskTypeItem.icon)
        cell.textLabel?.text = taskTypeItem.name
        
        let count = taskTypeItem.countUnChecked()
        if taskTypeItem.items.count == 0 {
            cell.detailTextLabel?.text = "没有添加任务"
        } else {
            if count == 0 {
                cell.detailTextLabel?.text = "全部搞定"
            } else {
                cell.detailTextLabel?.text = "有\(count)个任务没完成"
            }
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let taskTypeItem = todoModel.typeList[indexPath.row]
        self.performSegueWithIdentifier("showTask", sender: taskTypeItem)
    }
    
    //实现左滑进一步的操作
        override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
            let editAction = UITableViewRowAction(style: .Normal, title: "编辑") { (action, indexPath) in
                let taskItem = todoModel.typeList[indexPath.row]
                let navigation = self.tabBarController?.viewControllers![1] as? UINavigationController
                let taskDetail = navigation?.viewControllers.first as! TypeDetailViewController
                taskDetail.onEditState(taskItem)
                self.tabBarController?.selectedIndex = 1
            }
            
            let deleteAction = UITableViewRowAction(style: .Default, title: "删除") { (action, indexPath) in
                todoModel.typeList.removeAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
            todoModel.saveData()
            return [deleteAction,editAction]
        }
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showTask" {
            let taskListViewController = segue.destinationViewController as! TaskListViewController
            taskListViewController.taskList = sender as? TypeItem
        }
     }
    
}
