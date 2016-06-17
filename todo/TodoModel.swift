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
//        creatData()
        loadData()
        print("沙盒文件夹路径：\(documentsDirectory())")
        print("数据文件路径：\(dataFilePath())")
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
        let userDefaults = NSUserDefaults.standardUserDefaults()
        //获取 TypelistItemId 的值
        let itemId = userDefaults.integerForKey("ItemId")
        //+1后保存
        userDefaults.setInteger(itemId + 1, forKey: "ItemId")
        //强制要求 userDefaults 保存
        userDefaults.synchronize()
        
        return itemId
    }

    //获取沙盒路径
    func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentationDirectory, .UserDomainMask, true)
        let documentsDirectory: String = paths.first! as String
        return documentsDirectory
    }
    //添加
    func dataFilePath() -> String {
        return self.documentsDirectory().stringByAppendingString("todo.plist")
    }
    
    func saveData() {
        let data = NSMutableData()
        //申明一个归档处理对象
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        //将 lists 以对应的 Typelist 关键字进行编码
        archiver.encodeObject(typeList, forKey: "todolist")
        //编码结束
        archiver.finishEncoding()
        //数据写入
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    func loadData() {
        //获取本地数据文件地址
        let path = self.dataFilePath()
        //声明一个文件管理器
        let defaultManager = NSFileManager()
        //通过文件地址判断数据文件是否存在
        if defaultManager.fileExistsAtPath(path) {
            let data = NSData(contentsOfFile: path)
            //解码器
            let unarchiver = NSKeyedUnarchiver(forReadingWithData: data!)
            //通过归档时设置的关键字 Typelist 还原 lists
            typeList = unarchiver.decodeObjectForKey("todolist") as! Array
            unarchiver.finishDecoding()
        } else {
            //如果文件不存在，则是第一次安装该应用，创建一个 Typelist
            let type = TypeItem(name: "购物")
            let task1 = TaskItem(title: "酱油", isFinish: false, dueDate: NSDate(), shouldRemind: false, level: 1)
            let task2 = TaskItem(title: "大米", isFinish: false, dueDate: NSDate(), shouldRemind: false, level: 2)
            type.items.append(task1)
            type.items.append(task2)
            typeList.append(type)
            saveData()
        }
    }
    
}


//创建全局变量
var todoModel = TodoModel()
