//
//  DateExt.swift
//  kimlic
//
//  Created by izzet öztürk on 14.08.2018.
//  Copyright © 2018 Kimlic. All rights reserved.
//

import Foundation

extension Date {
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
