//
//  TaskItem.swift
//  todo
//
//  Created by 祝韶明 on 16/6/1.
//  Copyright © 2016年 祝韶明. All rights reserved.
//

import Foundation

class TaskItem {
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
    
    func changeFinishState() {
        isFinish = !isFinish
    }
}
