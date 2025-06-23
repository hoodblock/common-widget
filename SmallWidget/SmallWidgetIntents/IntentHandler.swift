//
//  IntentHandler.swift
//  SmallWidgetIntents
//
//  Created by Thomas on 2023/6/1.
//

import Intents
import CoreData
import SwiftUI


let dynamic_follow_app = "dynamic_transparentType_follow_app"
let dynamic_top = "dynamic_transparentType_top"
let dynamic_left_top = "dynamic_transparentType_left_top"
let dynamic_right_top = "dynamic_transparentType_right_top"
let dynamic_medium = "dynamic_transparentType_medium"
let dynamic_left_medium = "dynamic_transparentType_left_medium"
let dynamic_right_medium = "dynamic_transparentType_right_medium"
let dynamic_bottom = "dynamic_transparentType_bottom"
let dynamic_left_bottom = "dynamic_transparentType_left_bottom"
let dynamic_right_bottom = "dynamic_transparentType_right_bottom"

// 根据Target 引入的 DynamicConfigurationIntent 自动生成 DynamicConfigurationIntentHandling
class IntentHandler: INExtension {
    override func handler(for intent: INIntent) -> Any {
        if intent is SmallWidgetConfigurationIntent {
            return SmallWidgetConfigurationIntentHandler()
        } else if intent is MediumWidgetConfigurationIntent {
            return MediumWidgetConfigurationIntentHandler()
        } else if intent is LargeWidgetConfigurationIntent {
            return LargeWidgetConfigurationIntentHandler()
        } else if intent is DynamicConfigurationIntent {
            return DynamicConfigurationIntentHandler()
        }
        return self
    }
}

func dynamicType(name: String, showName: String) -> DynamicType {
    let type = DynamicType(identifier: name, display: showName)
    type.dynamicName = name
    return type
}

class DynamicConfigurationIntentHandler: INExtension, DynamicConfigurationIntentHandling {
    let context = PersistenceController.shared.container.viewContext
    func provideDynamicTypeOptionsCollection(for intent: DynamicConfigurationIntent) async throws -> INObjectCollection<NSString> {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "WidgetConfigure")
        var allItems: [NSString] = []
        do {
            let result = try context.fetch(fetchRequest) as? [WidgetConfigure] ?? []
            for data in result {
                if let typeString = data.type {
                    allItems.append(NSString(string: typeString))
                }
            }
        } catch let error as NSError {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return INObjectCollection(items: allItems)
    }
}


func widgetEConfi(data: WidgetConfigure) -> WidgetEConfi? {
    if let showName = data.showName {
        let config = WidgetEConfi(identifier: showName, display: showName, subtitle: "", image: INImage.init(imageData: data.imageData ?? Data()))
        config.viewName = data.name
        config.type = data.type
        let ui = WidgetEUi(identifier: showName, display: showName)
        if let colorInt = data.widgetUi?.color {
            ui.backgroundColor = String(colorInt)
        }
        ui.configui = data.widgetUi?.configString
        config.ui = ui
        return config
    }
    return nil
}


class SmallWidgetConfigurationIntentHandler: INExtension, SmallWidgetConfigurationIntentHandling {
    
    let context = PersistenceController.shared.container.viewContext

    // (type) DynamicTransparentType (TransparentType) 动态透明位置选择
    func provideDynamicTransparentTypeOptionsCollection(for intent: SmallWidgetConfigurationIntent, with completion: @escaping (INObjectCollection<DynamicTransparentType>?, Error?) -> Void) {
        // 跟随app
        let followApp = DynamicTransparentType(identifier: dynamic_follow_app, display: "Follow APP")
        followApp.dynamicTransparent = dynamic_follow_app
        // 左上
        let letTop = DynamicTransparentType(identifier: dynamic_left_top, display: "Left Top")
        letTop.dynamicTransparent = dynamic_left_top
        // 右上
        let rightTop = DynamicTransparentType(identifier: dynamic_right_top, display: "Right Top")
        rightTop.dynamicTransparent = dynamic_right_top
        // 左中
        let leftMiddle = DynamicTransparentType(identifier: dynamic_left_medium, display: "Left Middle")
        leftMiddle.dynamicTransparent = dynamic_left_medium
        // 右中
        let rightMiddle = DynamicTransparentType(identifier: dynamic_right_medium, display: "Right Middle")
        rightMiddle.dynamicTransparent = dynamic_right_medium
        // 左下
        let letfBottom = DynamicTransparentType(identifier: dynamic_left_bottom, display: "Left Bottom")
        letfBottom.dynamicTransparent = dynamic_left_bottom
        // 右下
        let rightBottom = DynamicTransparentType(identifier: dynamic_right_bottom, display: "Right Bottom")
        rightBottom.dynamicTransparent = dynamic_right_bottom
        
        // 全部
        let allTimeType = [followApp, letTop, rightTop, leftMiddle, rightMiddle, letfBottom, rightBottom]
        // 生成一个数组，把数据通过回调方法传出去
        completion(INObjectCollection(items: allTimeType), nil)
    }

    // (enum) WidgetEConfi（Widget Name）选择
    func provideConfigureOptionsCollection(for intent: SmallWidgetConfigurationIntent) async throws -> INObjectCollection<WidgetEConfi> {
        var allTypes: [WidgetEConfi] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "WidgetConfigure")
        fetchRequest.predicate = NSPredicate(format: "%K == 0", #keyPath(WidgetConfigure.size))
        do {
            let result = try context.fetch(fetchRequest) as? [WidgetConfigure] ?? []
            for data in result {
                if let widgetType =  widgetEConfi(data: data) {
                    allTypes.append(widgetType)
                }
            }
        } catch let error as NSError {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return INObjectCollection(items: allTypes)
    }
    
    func provideTypeOptionsCollection(for intent: SmallWidgetConfigurationIntent) async throws -> INObjectCollection<NSString> {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "WidgetConfigure")
        fetchRequest.predicate = NSPredicate(format: "%K == 0", #keyPath(WidgetConfigure.size))
        var allItems: [NSString] = []
        do {
            let result = try context.fetch(fetchRequest) as? [WidgetConfigure] ?? []
            for data in result {
                if let typeString = data.type {
                    allItems.append(NSString(string: typeString))
                }
            }
        } catch let error as NSError {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return INObjectCollection(items: allItems)
    }
}




class MediumWidgetConfigurationIntentHandler: INExtension, MediumWidgetConfigurationIntentHandling {
    
    let context = PersistenceController.shared.container.viewContext
    
    // (type) DynamicTransparentType (TransparentType) 动态透明位置选择
    func provideDynamicTransparentTypeOptionsCollection(for intent: MediumWidgetConfigurationIntent, with completion: @escaping (INObjectCollection<DynamicTransparentType>?, Error?) -> Void) {
        // 跟随app
        let followApp = DynamicTransparentType(identifier: dynamic_follow_app, display: "Follow APP")
        followApp.dynamicTransparent = dynamic_follow_app
        // 上
        let top = DynamicTransparentType(identifier: dynamic_top, display: "Top")
        top.dynamicTransparent = dynamic_top
        // 中
        let middle = DynamicTransparentType(identifier: dynamic_medium, display: "Middle")
        middle.dynamicTransparent = dynamic_medium
        // 下
        let bottom = DynamicTransparentType(identifier: dynamic_bottom, display: "Bottom")
        bottom.dynamicTransparent = dynamic_bottom
        // 全部
        let allTimeType = [followApp, top, middle, bottom]
        // 生成一个数组，把数据通过回调方法传出去
        completion(INObjectCollection(items: allTimeType), nil)
    }
    
    
    func provideConfigureOptionsCollection(for intent: MediumWidgetConfigurationIntent) async throws -> INObjectCollection<WidgetEConfi> {
        var allTypes: [WidgetEConfi] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "WidgetConfigure")
        fetchRequest.predicate = NSPredicate(format: "%K == 1", #keyPath(WidgetConfigure.size))
        do {
            let result = try context.fetch(fetchRequest) as? [WidgetConfigure] ?? []
            for data in result {
                if let widgetType =  widgetEConfi(data: data){
                    allTypes.append(widgetType)
                }
            }
        } catch let error as NSError {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return INObjectCollection(items: allTypes)
    }
    
    func provideTypeOptionsCollection(for intent: MediumWidgetConfigurationIntent) async throws -> INObjectCollection<NSString>{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "WidgetConfigure")
        fetchRequest.predicate = NSPredicate(format: "%K == 1", #keyPath(WidgetConfigure.size))
        var allItems: [NSString] = []
        do {
            let result = try context.fetch(fetchRequest) as? [WidgetConfigure] ?? []
            for data in result {
                if let typeString = data.type {
                    allItems.append(NSString(string: typeString))
                }
            }
        } catch let error as NSError {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return INObjectCollection(items: allItems)
    }
}



class LargeWidgetConfigurationIntentHandler: INExtension, LargeWidgetConfigurationIntentHandling {
    
    let context = PersistenceController.shared.container.viewContext
    
    // (type) DynamicTransparentType (TransparentType) 动态透明位置选择
    func provideDynamicTransparentTypeOptionsCollection(for intent: LargeWidgetConfigurationIntent, with completion: @escaping (INObjectCollection<DynamicTransparentType>?, Error?) -> Void) {
        // 跟随app
        let followApp = DynamicTransparentType(identifier: dynamic_follow_app, display: "Follow APP")
        followApp.dynamicTransparent = dynamic_follow_app
        // 上
        let top = DynamicTransparentType(identifier: dynamic_top, display: "Top")
        top.dynamicTransparent = dynamic_top
        // 下
        let bottom = DynamicTransparentType(identifier: dynamic_bottom, display: "Bottom")
        bottom.dynamicTransparent = dynamic_bottom
        // 全部
        let allTimeType = [followApp, top, bottom]
        // 生成一个数组，把数据通过回调方法传出去
        completion(INObjectCollection(items: allTimeType), nil)
    }
    
    func provideConfigureOptionsCollection(for intent: LargeWidgetConfigurationIntent) async throws -> INObjectCollection<WidgetEConfi> {
        var allTypes: [WidgetEConfi] = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "WidgetConfigure")
        fetchRequest.predicate = NSPredicate(format: "%K == 2", #keyPath(WidgetConfigure.size))
        do {
            let result = try context.fetch(fetchRequest) as? [WidgetConfigure] ?? []
            for data in result {
                if let widgetType =  widgetEConfi(data: data){
                    allTypes.append(widgetType)
                }
            }
        } catch let error as NSError {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return INObjectCollection(items: allTypes)
    }
    
    func provideTypeOptionsCollection(for intent: LargeWidgetConfigurationIntent) async throws -> INObjectCollection<NSString>{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "WidgetConfigure")
        fetchRequest.predicate = NSPredicate(format: "%K == 2", #keyPath(WidgetConfigure.size))
        var allItems: [NSString] = []
        do {
            let result = try context.fetch(fetchRequest) as? [WidgetConfigure] ?? []
            for data in result {
                if let typeString = data.type {
                    allItems.append(NSString(string: typeString))
                }
            }
        } catch let error as NSError {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return INObjectCollection(items: allItems)
    }
}
