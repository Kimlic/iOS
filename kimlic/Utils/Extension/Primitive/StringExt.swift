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
    
    public var isEmail: Bool {
        guard !self.isEmpty, !self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return false
        }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    
    func safelyLimitedTo(length n: Int)->String {
        let c = self.characters
        if (c.count <= n) { return self }
        return String( Array(c).prefix(upTo: n) )
    }
}
