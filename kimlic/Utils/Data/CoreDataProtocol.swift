//
//  CoreDataProtocol.swift
//  kimlic
//
//  Created by paltimoz on 11.06.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataProtocol {
    
    var entityName: String! {get}
    var fetchCount: Int? {get}
    
    var appDelegate: AppDelegate! {get}
    var context: NSManagedObjectContext! {get}
    
    init(entityName: String, fetchCount: Int?)
    
    // INSERT
    func insert(data: [String:AnyObject], completion:((_ state:Bool) -> ())?)
    
    // FETCH
    func fetch() -> [NSManagedObject]
    
    // FETCH VALUES TO NAME
    func fetchValues(key: String) -> [AnyObject]
    
    // FETCH WİDTH PREDİCATE
    func sortFetch(predicate:String?,ascending:Bool?,key:String?) -> [NSManagedObject]
    
    // UPDATE
    func update(data: NSManagedObject, value: AnyObject, key: String, completion: ((_ state:Bool) -> ())?)
    
    // UPDATE WİTH PREDİCATE
    func update(predicate: String, value: AnyObject, key:String, completion: ((_ state:Bool) -> ())?)
    
    // DELETE
    func delete(data: NSManagedObject, completion: ((_ state:Bool) -> ())?)
    
    // DELETE MORE İTEMS
    
    func delete(datas: [NSManagedObject], completion: ((_ state:Bool) -> ())?)
    
    // DELETE WİTH PREDİCATE    
    func delete(predicate: String, completion: ((_ state:Bool) -> ())?)
    
}
