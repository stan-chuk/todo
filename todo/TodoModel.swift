//
//  TodoModel.swift
//  todo
//
//  Created by 祝韶明 on 16/5/18.
//  Copyright © 2016年 祝韶明. All rights reserved.
//

import Foundation

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
                let task = TaskItem(title: "任务清单：\(j)", isFinish: false, dueDate: NSDate(), shouldRemind: false, level: 0)
                type.items.append(task)
            }
            typeList.append(type)
        }
    }
    
    func addTaskType(type: TypeItem) {
        typeList.append(type)
    }
    
    static func nextToDoItemId() -> Int {
        return 0
    }

}


//创建全局变量
var todoModel = TodoModel()
