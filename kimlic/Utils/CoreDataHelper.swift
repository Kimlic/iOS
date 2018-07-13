//
//  CoreDataHelper.swift
//  kimlic
//
//  Created by ibrahim özdemir on 12.07.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import UIKit
import CoreData

struct CoreDataHelper {
    static let kimlicUserEntity = "KimlicUser"
    
    static let context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        
        let persistentContainer = appDelegate.persistentContainer
        let context = persistentContainer.viewContext
        
        return context
    }()
    
    static func initUser(phone:String) {
        let currentUser = getUser()
        if currentUser != nil {
            destroy()
        }
        let kimlicUser = NSEntityDescription.insertNewObject(forEntityName: kimlicUserEntity, into: context) as! KimlicUser
        kimlicUser.phone = phone
        saveUser()
    }
    
    static func saveUser() {
        do {
            try context.save()
        } catch let error {
            print("Could not save \(error.localizedDescription)")
        }
    }
    
    static func delete(kimlicUser: KimlicUser) {
        context.delete(kimlicUser)
        saveUser()
    }
    
    static func destroy() {
        // Create Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: kimlicUserEntity)
        
        // Create Batch Delete Request
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(batchDeleteRequest)
        } catch let error {
            print("Could not fetch \(error.localizedDescription)")
        }
    }
    
    static func getUser() -> KimlicUser? {
        do {
            let fetchRequest = NSFetchRequest<KimlicUser>(entityName: kimlicUserEntity)
            let results = try context.fetch(fetchRequest)
            return results.first
        } catch let error {
            print("Could not fetch \(error.localizedDescription)")
            return nil
        }
    }
}
