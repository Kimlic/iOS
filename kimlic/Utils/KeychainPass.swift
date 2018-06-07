//
//  KeychainPass.swift
//  kimlic
//
//  Created by izzet öztürk on 7.06.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import Foundation
import Security

class KeychainOptions {
    static let kSecClassValue = NSString(format: kSecClass)
    static let kSecAccessValue = NSString(format: kSecAttrAccessible)
    static let kSecAttrAccountValue = NSString(format: kSecAttrAccount)
    static let kSecValueDataValue = NSString(format: kSecValueData)
    static let kSecClassGenericPasswordValue = NSString(format: kSecClassGenericPassword)
    static let kSecAttrServiceValue = NSString(format: kSecAttrService)
    static let kSecMatchLimitValue = NSString(format: kSecMatchLimit)
    static let kSecReturnDataValue = NSString(format: kSecReturnData)
    static let kSecMatchLimitOneValue = NSString(format: kSecMatchLimitOne)
}

class KeychainPass: NSObject {
    
    class func save(service: String, name:String, data: String) {
        if let dataFromString = data.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            
            let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [KeychainOptions.kSecClassGenericPasswordValue, service, name, dataFromString], forKeys: [KeychainOptions.kSecClassValue, KeychainOptions.kSecAttrServiceValue, KeychainOptions.kSecAttrAccountValue, KeychainOptions.kSecValueDataValue])
            
            let status = SecItemAdd(keychainQuery as CFDictionary, nil)
            
            if (status != errSecSuccess) {
                fatalError("Keychain save error")
            }
        }
    }
    
    class func load(service: String, name:String) -> String? {
        
        let keychainQuery: NSMutableDictionary = KeychainPass.getMutableDictionary(service,name)
        
        var dataTypeRef :AnyObject?
        
        let status: OSStatus = SecItemCopyMatching(keychainQuery, &dataTypeRef)
        var contentsOfKeychain: String?
        
        if status == errSecSuccess {
            if let retrievedData = dataTypeRef as? Data {
                contentsOfKeychain = String(data: retrievedData, encoding: String.Encoding.utf8)
            }
        } else {
            print("Error Status code \(status)")
        }
        
        return contentsOfKeychain
    }
    
    class func update(service: String, name:String, data: String) {
        if let dataFromString: Data = data.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            
            let keychainQuery: NSMutableDictionary = KeychainPass.getMutableDictionary(service,name)
            
            let status = SecItemUpdate(keychainQuery as CFDictionary, [KeychainOptions.kSecValueDataValue:dataFromString] as CFDictionary)
            
            if (status != errSecSuccess) {
                fatalError("Keychain update error")
            }
        }
    }
    
    class func remove(service: String, name:String) {
        
        let keychainQuery: NSMutableDictionary = KeychainPass.getMutableDictionary(service,name)
        
        let status = SecItemDelete(keychainQuery as CFDictionary)
        
        if (status != errSecSuccess) {
            fatalError("Keychain remove error")
        }
    }
    
    class func clear() {
        
        let keychainQuery:[String:Any] = [KeychainOptions.kSecClassValue as String: KeychainOptions.kSecClassGenericPasswordValue]
        
        let status = SecItemDelete(keychainQuery as CFDictionary)
        
        if (status != errSecSuccess) {
            fatalError("Keychain clear error")
        }
    }
    
    private class func getMutableDictionary(_ service:String, _ name:String) -> NSMutableDictionary {
        return NSMutableDictionary(objects: [KeychainOptions.kSecClassGenericPasswordValue, service, name, kCFBooleanTrue, KeychainOptions.kSecMatchLimitOneValue], forKeys: [KeychainOptions.kSecClassValue, KeychainOptions.kSecAttrServiceValue, KeychainOptions.kSecAttrAccountValue, KeychainOptions.kSecReturnDataValue, KeychainOptions.kSecMatchLimitValue])
    }
}
