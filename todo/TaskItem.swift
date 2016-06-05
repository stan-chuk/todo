//
//  TaskItem.swift
//  todo
//
//  Created by 祝韶明 on 16/6/1.
//  Copyright © 2016年 祝韶明. All rights reserved.
//

import Foundation

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
    
    func changeFinishState() {
        isFinish = !isFinish
    }
    
}
