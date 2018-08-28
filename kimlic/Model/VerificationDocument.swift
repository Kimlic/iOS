//
//  VerificationDocument.swift
//  kimlic
//
//  Created by İzzet Öztürk on 28.08.2018.
//  Copyright © 2018 Kimlic. All rights reserved.
//

import Foundation

struct VerificationDocument: Decodable {
    let contexts: [String]
    let countries: [String]
    let description: String
    let type: String
}
