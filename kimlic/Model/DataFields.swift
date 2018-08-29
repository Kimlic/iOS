//
//  DataFields.swift
//  kimlic
//
//  Created by İzzet Öztürk on 29.08.2018.
//  Copyright © 2018 Kimlic. All rights reserved.
//

import Foundation

struct DataFields: Decodable {
    let name: String
    let status: String
    let value: String
    let verification_contract: String
    let verified_on: String
}
