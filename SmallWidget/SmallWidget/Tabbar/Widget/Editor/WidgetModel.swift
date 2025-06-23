//
//  WidgetModel.swift
//  SmallWidget
//
//  Created by Thomas on 2023/6/14.
//

import Foundation

struct WidgetModel {
    
    var name: String
    var id: Int
    var type: Int
    var listType: WidgetType
    
    init(name: String, id: Int, type: Int, listType: WidgetType) {
        self.name = name
        self.id = id
        self.type = type
        self.listType = listType
    }
}
