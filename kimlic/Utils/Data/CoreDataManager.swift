//
//  CoreDataManager.swift
//  kimlic
//
//  Created by paltimoz on 11.06.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager: NSObject, CoreDataProtocol {
    
    var entityName: String!
    var fetchCount: Int?
    var appDelegate: AppDelegate! = UIApplication.shared.delegate as! AppDelegate
    var context: NSManagedObjectContext!
    
    required init(entityName: String, fetchCount: Int? = nil) {
        self.entityName = entityName
        self.fetchCount = fetchCount
//        self.context = appDelegate.persistentContainer.viewContext
    }
    
    func insert(data: [String : AnyObject], completion: ((Bool) -> ())? = nil) {
        let newData = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context)
        for (key,value) in data {
            newData.setValue(value, forKey: key)
        }
        do {
            try context.save()
            completion?(true)
        } catch {
            completion?(false)
            print(error)
        }
    }
    
    func fetch() -> [NSManagedObject] {
        var data = [NSManagedObject]()
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetch.returnsObjectsAsFaults = false
        if fetchCount != nil {fetch.fetchLimit = fetchCount!}
        do {
            let results = try context.fetch(fetch)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    data.append(result)
                }
            }
        } catch {
            print(error)
        }
        return data
    }
    
    func fetchValues(key: String) -> [AnyObject] {
        var item:[AnyObject] = []
        for items in fetch() {
            item.append(items.value(forKey: key) as AnyObject!)
        }
        return item
    }
    
    func sortFetch(predicate: String?, ascending: Bool?, key: String?) -> [NSManagedObject] {
        
        var data = [NSManagedObject]()
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetch.returnsObjectsAsFaults = false
        if fetchCount != nil {fetch.fetchLimit = fetchCount!}
        if predicate != nil {
            let predicate = NSPredicate(format: predicate!)
            fetch.predicate = predicate
        }
        if key != nil && ascending != nil {
            let desc = NSSortDescriptor(key: key!, ascending: ascending!)
            fetch.sortDescriptors = [desc]
        }
        do {
            let results = try context.fetch(fetch)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    data.append(result)
                }
            }
        } catch {
            print(error)
        }
        return data
    }
    
    func update(data: NSManagedObject, value: AnyObject, key: String, completion: ((Bool) -> ())? = nil) {
        data.setValue(value, forKey: key)
        do {
            try context.save()
            completion?(true)
        } catch {
            print(error)
            completion?(false)
        }
    }
    
    func update(predicate: String, value: AnyObject, key: String, completion: ((Bool) -> ())? = nil) {
        let datas:[NSManagedObject] = sortFetch(predicate: predicate, ascending: nil, key: nil)
        if !datas.isEmpty {
            for i in 0..<datas.count {
                datas[i].setValue(value, forKey: key)
            }
        }
        do {
            try context.save()
            completion?(true)
        } catch {
            print(error)
            completion?(false)
        }
    }
    
    func delete(data: NSManagedObject, completion: ((Bool) -> ())? = nil) {
        context.delete(data)
        do {
            try context.save()
            completion?(true)
        } catch {
            print(error)
            if completion != nil {completion!(false)}
        }
    }
    
    func delete(datas: [NSManagedObject], completion: ((Bool) -> ())? = nil) {
        if !datas.isEmpty {
            for i in 0..<datas.count {
                context.delete(datas[i])
            }
        }        
        do {
            try context.save()
            completion?(true)
        } catch {
            completion?(false)
        }
    }
    
    func delete(predicate: String, completion: ((Bool) -> ())? = nil) {
        let datas:[NSManagedObject] = sortFetch(predicate: predicate, ascending: nil, key: nil)
        if !datas.isEmpty {
            for i in 0..<datas.count {
                context.delete(datas[i])
            }
        }
        do {
            try context.save()
            completion?(true)
        } catch {
            completion?(false)
        }
    }
    
}
