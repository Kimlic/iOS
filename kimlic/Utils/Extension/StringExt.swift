//
//  StringExt.swift
//  kimlic
//
//  Created by İzzet Öztürk on 14.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
import Foundation


public extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    func safelyLimitedTo(length n: Int)->String {
        let c = self.characters
        if (c.count <= n) { return self }
        return String( Array(c).prefix(upTo: n) )
    }
    
    //Get the application id value from QR Code string
    func getAppIdFromQrCode() -> String? {
        let token = self.components(separatedBy: ":")
        if token.count > 1 {
            return token[0]
        }
        return nil
    }
    
    //Get the token value from QR Code string
    func getToken() -> String?{
        let token = self.components(separatedBy: ":")
        if token.count > 1 {
            return token[1]
        }
        return nil
    }
}
