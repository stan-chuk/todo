//
//  TodoModel.swift
//  todo
//
//  Created by 祝韶明 on 16/5/18.
//  Copyright © 2016年 祝韶明. All rights reserved.
//

import Foundation

class TaskItem: NSObject {
    var name: String = ""
    var icon: String = "心情"
    
    init(name: String) {
        self.name = name
    }
}

class TodoModel: NSObject {
    var taskList = [TaskItem]()
    
    override init() {
        super.init()
        creatData()
    }
    
    func creatData() {
        for i in 1...10 {
            let name = "任务：\(i)"
            let type = TaskItem(name: name)
            taskList.append(type)
        }
    }
    
    func addTask(type: TaskItem) {
        taskList.append(type)
    }
    
}

//创建全局变量
var todoModel = TodoModel()