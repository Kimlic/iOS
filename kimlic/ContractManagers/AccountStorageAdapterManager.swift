//
//  AccountStorageAdapterService.swift
//  kimlic
//
//  Created by ibrahim özdemir on 5.07.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import Foundation

class AccountStorageAdapterManager: BaseContractManager {
    
    // MARK: - Variables
    
    private lazy var accountStorageAdapter = AccountStorageAdapter(address: cons.AccountStorageAdapterAddress)

    // MARK: - Public
    
    func setAccountFieldMainData(type: AccountFieldMainType, value: String) throws -> [String: Any] {
        let params = [value.sha256(), type.rawValue]
        let method = accountStorageAdapter.transactions.setAccountFieldMainData
        
        return try quorumManager.send(contract: accountStorageAdapter, method: method, params: params)
    }
}
