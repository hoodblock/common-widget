//
//  Persistence.swift
//  SmallWidget
//
//  Created by Thomas on 2023/6/1.
//

import CoreData

struct PersistenceController {
    
    static let shared = PersistenceController()
    
    let container: NSPersistentCloudKitContainer = NSPersistentCloudKitContainer(name: "SmallWidget")
    
    init() {
        let groupIdentifier = "group.com.subfg"
        if let storeURL = URL.storeURL(for: groupIdentifier, databaseName: "SmallWidget") {
            let storeDescription = NSPersistentStoreDescription(url: storeURL)
            storeDescription.cloudKitContainerOptions = NSPersistentCloudKitContainerOptions(containerIdentifier: groupIdentifier)
            container.persistentStoreDescriptions = [storeDescription]
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                    /*
                     Typical reasons for an error here include:
                     典型的原因
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     路径不存在，不能被创建或者不允许写
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     持续存储不可访问，因为设备锁后，数据保护和限制
                     * The device is out of space.
                     没有内存空间
                     * The store could not be migrated to the current model version.
                     存储不能兼容当前的模型版本
                     Check the error message to determine what the actual problem was.
                     检查错误信息
                     */
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            container.viewContext.automaticallyMergesChangesFromParent = true
            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
            do {
                  try container.viewContext.setQueryGenerationFrom(.current)
            } catch {
                 fatalError("Failed to pin viewContext to the current generation:\(error)")
            }
        }
    }
}

extension URL {
    /// Returns a URL for the given app group and database pointing to the sqlite database.
    static func storeURL(for appGroup: String, databaseName: String) -> URL? {
        let fileContainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup)
        if (fileContainer != nil) {
            return fileContainer!.appendingPathComponent("\(databaseName).sqlite")
        } else {
            print("Shared file container could not be created.")
        }
        return nil
    }
}
