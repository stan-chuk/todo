//
//  LevelItem.swift
//  todo
//
//  Created by 祝韶明 on 16/6/1.
//  Copyright © 2016年 祝韶明. All rights reserved.
//

import Foundation

class LevelItem {
    //重视程度
    var level: Int
    var title: String = ""
    var checkMark: Bool = false
    init(level: Int) {
        self.level = level
        self.title = LevelItem.getTitle(level)
    }
    static func getTitle(level: Int) -> String {
        var title: String = ""
        switch level {
        case 1:
            title = "一般"
        case 2:
            title = "重要"
        case 3:
            title = "很重要"
        case 4:
            title = "非常重要"
        default:
            title = "当看不到，哈哈"
        }
        return title
    }
}