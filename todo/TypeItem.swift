//
//  TypeItem.swift
//  todo
//
//  Created by 祝韶明 on 16/6/1.
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
    
    func countUnChecked() -> Int {
        var count = 0
        for item in items {
            if !item.isFinish {
                count += 1
            }
        }
        return count
    }
    
}