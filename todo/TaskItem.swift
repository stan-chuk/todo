//
//  TaskItem.swift
//  todo
//
//  Created by 祝韶明 on 16/6/1.
//  Copyright © 2016年 祝韶明. All rights reserved.
//
import Foundation
import UIKit.UILocalNotification

class TaskItem: NSObject {
    //任务名称
    var title: String
    //完成状态
    var isFinish: Bool
    //提醒时间
    var dueDate: NSDate
    //是否提醒
    var shouldRemind: Bool
    //任务 id
    var itemId: Int = TodoModel.nextToDoItemId()
    //重要级别
    var level: Int
    
    init(title: String, isFinish: Bool, dueDate: NSDate, shouldRemind: Bool, level: Int){
        self.title = title
        self.isFinish = isFinish
        self.dueDate = dueDate
        self.shouldRemind = shouldRemind
        self.level = level
    }
    
    init(coder aDecoder: NSCoder!) {
        self.title = aDecoder.decodeObjectForKey("Title") as! String
        self.isFinish = aDecoder.decodeObjectForKey("IsFinish") as! Bool
        self.dueDate = aDecoder.decodeObjectForKey("DueDate") as! NSDate
        self.shouldRemind = aDecoder.decodeObjectForKey("ShouldRemind") as! Bool
        self.itemId = aDecoder.decodeObjectForKey("ItemId") as! Int
        self.level = aDecoder.decodeObjectForKey("Level") as! Int
    }
    
    func encodeWithCoder(aCoder: NSCoder!) {
        aCoder.encodeObject(title, forKey: "Title")
        aCoder.encodeObject(isFinish, forKey: "IsFinish")
        aCoder.encodeObject(dueDate, forKey: "DueDate")
        aCoder.encodeObject(shouldRemind, forKey: "ShouldRemind")
        aCoder.encodeObject(itemId, forKey: "ItemId")
        aCoder.encodeObject(level, forKey: "Level")
    }
    
    //改变是否完成的状态
    func changeFinishState() {
        isFinish = !isFinish
        if isFinish == true {
            shouldRemind = false
        }
    }
    
    //通过任务ID获取目标任务的通知
    func notificationForThisItem() -> UILocalNotification? {
        let allNotifications = UIApplication.sharedApplication().scheduledLocalNotifications
        for notification in allNotifications! {
            let info: Dictionary<String, Int> = notification.userInfo as! Dictionary<String, Int>
            let number: Int = info["ItemId"]!
            if number == self.itemId {
                return notification
            }
        }
        return nil
    }
    
    //生成通知
    func scheduledNotification() {
        //检查是否已存在通知，若已存在通知，则在修改通知时取消掉上一次的通知
        let existingNotification = notificationForThisItem()
        if existingNotification != nil {
            UIApplication.sharedApplication().cancelLocalNotification(existingNotification!)
        }
        //创建新的通知
        if self.shouldRemind == true && (self.dueDate.compare(NSDate()) != NSComparisonResult.OrderedAscending) {
            let notification = UILocalNotification()
            notification.alertBody = self.title
            notification.fireDate = self.dueDate
            notification.timeZone = NSTimeZone.defaultTimeZone()
            notification.soundName = UILocalNotificationDefaultSoundName
            notification.applicationIconBadgeNumber = UIApplication.sharedApplication().scheduledLocalNotifications!.count + 1
            notification.userInfo = ["ItemId": itemId]
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        }
    }
    
    //当任务被删除的时候，同时取消该任务的提醒通知
    deinit {
        let existingNotification = notificationForThisItem()
        if existingNotification != nil {
            UIApplication.sharedApplication().cancelLocalNotification(existingNotification!)
        }
    }
    
}
