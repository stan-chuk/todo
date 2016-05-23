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
        //初始化模拟数据
        creatData()
    }
    
    func creatData() {
        for i in 1...10 {
            let name = "任务：\(i)"
            let type = TypeItem(name: name)
            for j in 1...4 {
                print("j: \(j)")
                print(NSDate())
                let task = TaskItem(title: "任务清单：\(j)", isFinish: false, dueDate: NSDate(), shouldRemind: false, level: 0)
                print("i: \(i)")
                type.items.append(task)
            }
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

struct TaskItem {
    //任务名称
    var title: String
    //完成状态
    var isFinish: Bool
    //提醒时间
    var dueDate: NSDate
    //是否提醒
    var shouldRemind: Bool
    //任务 id
    var itemId: Int = todoModel.nextToDoItemId()
    //重要级别
    var level: Int
    
    init(title: String, isFinish: Bool, dueDate: NSDate, shouldRemind: Bool, level: Int){
        self.title = title
        self.isFinish = isFinish
        self.dueDate = dueDate
        self.shouldRemind = shouldRemind
        self.level = level
    }
    
    mutating func changeFinishState() {
        self.isFinish = !self.isFinish
    }
}

//创建全局变量
var todoModel = TodoModel()
