//
//  CoreDataHelper.swift
//  kimlic
//
//  Created by ibrahim özdemir on 12.07.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import UIKit
import CoreData
import CloudCore

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
        saveUser(user!)
    }
    
    static func saveEmail(email: String) {
        var user = getUser()
        if user == nil {
            user = NSEntityDescription.insertNewObject(forEntityName: kimlicUserEntity, into: context) as? KimlicUser
        }
        user?.email = email
        saveUser(user!)
    }
    
    static func saveName(firstName: String, lastName: String) {
        var user = getUser()
        if user == nil {
            user = NSEntityDescription.insertNewObject(forEntityName: kimlicUserEntity, into: context) as? KimlicUser
        }
        user?.firstName = firstName
        user?.lastName = lastName
        saveUser(user!)
    }
    
    static func savePasscode(passcode: String?) {
        var user = getUser()
        if user == nil {
            user = NSEntityDescription.insertNewObject(forEntityName: kimlicUserEntity, into: context) as? KimlicUser
        }
        user?.passcode = passcode
        saveUser(user!)
    }
    static func saveRecovery(isAccountRecovery: Bool) {
        var user = getUser()
        if user == nil {
            user = NSEntityDescription.insertNewObject(forEntityName: kimlicUserEntity, into: context) as? KimlicUser
        }
        user?.accountRecovery = isAccountRecovery
        saveUser(user!)
    }
    
    static func saveTouchID(isTouchID: Bool) {
        var user = getUser()
        if user == nil {
            user = NSEntityDescription.insertNewObject(forEntityName: kimlicUserEntity, into: context) as? KimlicUser
        }
        user?.touchID = isTouchID
        saveUser(user!)
    }
    
    static func saveProfilePhoto(photo: Data?) {
        var user = getUser()
        if user == nil {
            user = NSEntityDescription.insertNewObject(forEntityName: kimlicUserEntity, into: context) as? KimlicUser
        }
        user?.profilePhoto = photo
        saveUser(user!)
    }
    
    static func saveMnemonicAndAddress(mnemonic: String?, accountAddress: String?) {
        var user = getUser()
        if user == nil {
            user = NSEntityDescription.insertNewObject(forEntityName: kimlicUserEntity, into: context) as? KimlicUser
        }
        user?.mnemonic = mnemonic
        user?.accountAddress = accountAddress
        saveUser(user!)
    }
    
    static func saveAddress(address: String?, addressFile: Data?) {
        var user = getUser()
        if user == nil {
            user = NSEntityDescription.insertNewObject(forEntityName: kimlicUserEntity, into: context) as? KimlicUser
        }
        user?.address = address
        user?.addressFile = addressFile
        saveUser(user!)
    }
    
    static func saveDeviceToken(deviceToken: String) {
        var user = getUser()
        if user == nil {
            user = NSEntityDescription.insertNewObject(forEntityName: kimlicUserEntity, into: context) as? KimlicUser
        }
        user?.deviceToken = deviceToken
        saveUser(user!)
    }
    
    static func saveToRecord(record: CKRecord) {
        var user = getUser()
        if user == nil {
            user = NSEntityDescription.insertNewObject(forEntityName: kimlicUserEntity, into: context) as? KimlicUser
        }
        for key in record.allKeys() {
            let recordValue = record.value(forKey: key)
            user?.setValue(recordValue, forKey: key)
        }
        saveUser(user!)
        CloudKitHelper.deleteToCloud(record: record)
    }
    
    private static func saveUser(_ user: NSManagedObject) {
        do {
            context.refresh(user, mergeChanges: true)
            try context.save()
        } catch let error {
            print("Could not save \(error.localizedDescription)")
        }
    }
    static func delete(kimlicUser: KimlicUser) {
        context.delete(kimlicUser)
        saveUser(kimlicUser)
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

import CloudKit

struct CloudKitHelper {
    
    private static let database = CKContainer.default().privateCloudDatabase
    
    static func getDatabaseWithAccountAddress(accountAddress: String, callback: @escaping (CKRecord?) -> ()){
        let predicate = NSPredicate(format: "accountAddress = '\(accountAddress)'")
        let query = CKQuery(recordType: CoreDataHelper.kimlicUserEntity, predicate: predicate)
        database.perform(query, inZoneWith: CloudCore.config.zoneID) { (records, _) in
            guard let records = records else { callback(nil); return }
            callback(records.first)
        }
    }

    static func getDatabaseWithRecordId(callback: @escaping (CKRecord?) -> ()){
        let user = CoreDataHelper.getUser()
        let predicate = NSPredicate(format: "recordID = '\(user?.recordID ?? "")'")
        let query = CKQuery(recordType: CoreDataHelper.kimlicUserEntity, predicate: predicate)
        database.perform(query, inZoneWith: nil) { (records, _) in
            guard let records = records else { callback(nil); return }
            callback(records.first)
        }
    }

    static func saveToCloud(record: CKRecord, completionHandler: ((CKRecord?, Error?) -> Void)? = nil) {
        database.save(record, completionHandler: completionHandler ?? {_,_ in})
    }
    
    static func deleteToCloud(record: CKRecord, completionHandler: ((CKRecordID?, Error?) -> Void)? = nil) {
        database.delete(withRecordID: record.recordID, completionHandler: completionHandler ?? {_,_ in})
    }
    
    
}
