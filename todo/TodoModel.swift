//
//  TodoModel.swift
//  todo
//
//  Created by 祝韶明 on 16/5/18.
//  Copyright © 2016年 祝韶明. All rights reserved.
//

import Foundation

class TypeItem: NSObject {
    var name: String = ""
    var icon: String = "心情"
    var items = [TaskItem]()
    
    init(name: String) {
        super.init()
        self.name = name
    }
}

class TodoModel: NSObject {
    var typeList = [TypeItem]()
    
    override init() {
        super.init()
        creatData()
    }
    
    func creatData() {
        for i in 1...10 {
            let name = "任务：\(i)"
            let type = TypeItem(name: name)
//            for j in 1...4 {
//                let task = TaskItem(title: "任务清单: \(j)", finish: false, dueDate: NSDate(), shouldRemind: true, level: 0)
//                type.items.append(task)
//            }
            typeList.append(type)
        }
    }
    
    func addTaskType(type: TypeItem) {
        typeList.append(type)
    }
    
    func nextToDoItemId() -> Int {
        return 0
    }
}

class TaskItem: NSObject {
    //任务名称
    var title: String
    //完成状态
    var finish: Bool
    //提醒时间
    var dueDate: NSDate
    //是否提醒
    var shouldRemind: Bool
    //任务 id
    var itemId: Int
    //重要级别
    var level: Int = 0
    
    init(title: String, finish: Bool, dueDate: NSDate, shouldRemind: Bool, level: Int) {
        self.title = title
        self.finish = finish
        self.dueDate = dueDate
        self.shouldRemind = shouldRemind
        self.itemId = todoModel.nextToDoItemId()
        self.level = level
        super.init()
    }
    
    func changeFinishState() {
        self.finish = !self.finish
    }
}

//创建全局变量
var todoModel = TodoModel()
