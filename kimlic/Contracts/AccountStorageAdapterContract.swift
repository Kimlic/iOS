//
//  AccountStorageAdapterService.swift
//  kimlic
//
//  Created by ibrahim özdemir on 5.07.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import Foundation

class AccountStorageAdapterContract: BaseContract {
    private lazy var accountStorageAdapter = AccountStorageAdapter(address: "0xd63a61238cfc86db6dbb4ab4484f33b3d56b249c")

    func setAccountFieldMainData() throws -> [String: Any] {
        let myParams = ["8C16561DFE998D2811A4BC8A2E97693526847D522E14FB5D20A5BA09F10F1902",quorumManager.accountAddress()!]
        let receiptSet = try quorumManager.send(contract: accountStorageAdapter, method: accountStorageAdapter.transactions.setAccountFieldMainData, params: myParams)
        print("RECEIPT SET: ", receiptSet, "\n")
        return receiptSet
    }
}
