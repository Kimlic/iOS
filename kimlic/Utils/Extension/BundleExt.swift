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
}

fileprivate extension Bundle {
    
    func string(for key: String) -> String {
        guard let infoDictionary = Bundle.main.infoDictionary,
            let value = infoDictionary[key] as? String else {
                return ""
        }
        return value
    }
    
}
