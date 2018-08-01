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
    
    static func savePhone(phone: String) {
        var user = getUser()
        if user == nil {
            user = NSEntityDescription.insertNewObject(forEntityName: kimlicUserEntity, into: context) as? KimlicUser
        }
        user?.phone = phone
        saveUser()
    }
    
    static func saveEmail(email: String) {
        var user = getUser()
        if user == nil {
            user = NSEntityDescription.insertNewObject(forEntityName: kimlicUserEntity, into: context) as? KimlicUser
        }
        user?.email = email
        saveUser()
    }
    
    static func saveName(firstName: String, lastName: String) {
        var user = getUser()
        if user == nil {
            user = NSEntityDescription.insertNewObject(forEntityName: kimlicUserEntity, into: context) as? KimlicUser
        }
        user?.firstName = firstName
        user?.lastName = lastName
        saveUser()
    }
    
    static func savePasscode(passcode: String?) {
        var user = getUser()
        if user == nil {
            user = NSEntityDescription.insertNewObject(forEntityName: kimlicUserEntity, into: context) as? KimlicUser
        }
        user?.passcode = passcode
        saveUser()
    }
    static func saveRecovery(isAccountRecovery: Bool) {
        var user = getUser()
        if user == nil {
            user = NSEntityDescription.insertNewObject(forEntityName: kimlicUserEntity, into: context) as? KimlicUser
        }
        user?.accountRecovery = isAccountRecovery
        saveUser()
    }
    
    static func saveTouchID(isTouchID: Bool) {
        var user = getUser()
        if user == nil {
            user = NSEntityDescription.insertNewObject(forEntityName: kimlicUserEntity, into: context) as? KimlicUser
        }
        user?.touchID = isTouchID
        saveUser()
    }
    
    static func saveProfilePhoto(photo: Data?) {
        var user = getUser()
        if user == nil {
            user = NSEntityDescription.insertNewObject(forEntityName: kimlicUserEntity, into: context) as? KimlicUser
        }
        user?.profilePhoto = photo
        saveUser()
    }
    
    static func saveVerifyCardPhoto(frontPhoto: Data?, backPhoto: Data?) {
        var user = getUser()
        if user == nil {
            user = NSEntityDescription.insertNewObject(forEntityName: kimlicUserEntity, into: context) as? KimlicUser
        }
        user?.cardFrontPhoto = frontPhoto
        user?.cardBackPhoto = backPhoto
        saveUser()
    }
    
    static func saveMnemonicAndAddress(mnemonic: String?, accountAddress: String?) {
        var user = getUser()
        if user == nil {
            user = NSEntityDescription.insertNewObject(forEntityName: kimlicUserEntity, into: context) as? KimlicUser
        }
        user?.mnemonic = mnemonic
        user?.accountAddress = accountAddress
        saveUser()
    }
    
    private static func saveUser() {
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
