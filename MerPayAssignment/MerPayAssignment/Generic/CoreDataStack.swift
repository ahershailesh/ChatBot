//
//  CoreDataStack.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/11/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import CoreData

class CoreDataStack {
    
    private static var isCoreDataInitializationDone = false
    
    static let shared = CoreDataStack {
        isCoreDataInitializationDone = true
        print("CoreData Initialization done.")
    }
    
    private let container = NSPersistentContainer(name: "LocalStorage")
    private init(completionBlock: @escaping () -> ()) {
        container.loadPersistentStores { (description, error) in
            print(description)
            completionBlock()
        }
    }
    private let queue = DispatchQueue(label: "LocalStorage", qos: .background, attributes: .concurrent, autoreleaseFrequency: .workItem, target: nil)
    
    var context : NSManagedObjectContext {
        return container.viewContext
    }
    
    func save() {
        mainThread {
            if context.hasChanges, CoreDataStack.isCoreDataInitializationDone {
                do {
                    try context.save()
                } catch {
                    print("unable to save context \(error.localizedDescription)")
                }
            }
        }
    }
}
