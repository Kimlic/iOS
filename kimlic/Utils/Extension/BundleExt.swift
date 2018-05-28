//
//  BundleExt.swift
//  kimlic
//
//  Created by İzzet Öztürk on 24.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
//

import Foundation

public extension Bundle {

    public var serverURL: String {
        return string(for: "ServerURL")
    }
    
    private var webServiceKey: NSDictionary {
        return dictionary(for: "WebServiceKey")
    }
    
    public var grantType: String {
        guard let value = webServiceKey["GrantType"] as? String else {
            return ""
        }
        return value
    }
    
    public var clientID: String {
        guard let value = webServiceKey["ClientID"] as? String else {
            return ""
        }
        return value
    }
    
    public var clientSecret: String {
        guard let value = webServiceKey["ClientSecret"] as? String else {
            return ""
        }
        return value
    }
    
    
}

fileprivate extension Bundle {
    
    func string(for key: String) -> String {
        guard let infoDictionary = Bundle.main.infoDictionary,
            let value = infoDictionary[key] as? String else {
                return ""
        }
        return value
    }
    
    func dictionary(for key: String) -> NSDictionary {
        guard let infoDictionary = Bundle.main.infoDictionary,
            let value = infoDictionary[key] as? NSDictionary else {
                return [:]
        }
        return value
    }
    
}
