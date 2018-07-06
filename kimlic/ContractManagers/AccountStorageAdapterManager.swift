//
//  AccountStorageAdapterService.swift
//  kimlic
//
//  Created by ibrahim özdemir on 5.07.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import Foundation
import SwiftyUserDefaults
import CryptoSwift

class AccountStorageAdapterManager: BaseContractManager {
    private lazy var accountStorageAdapter = AccountStorageAdapter(address: cons.AccountStorageAdapterAddress)

    func setAccountFieldMainData() throws -> [String: Any] {
        if(Defaults[.deviceId] == nil){
            let uuid = UUID().uuidString
            Defaults[.deviceId] = uuid.sha256()
        }

        let myParams = [Defaults[.deviceId], quorumManager.accountAddress()!]
        let receiptSet = try quorumManager.send(contract: accountStorageAdapter, method: accountStorageAdapter.transactions.setAccountFieldMainData, params: myParams)
        print("RECEIPT SET: ", receiptSet, "\n")
        return receiptSet
    }
}
