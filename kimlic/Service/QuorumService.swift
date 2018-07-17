//
//  QuorumService.swift
//  kimlic
//
//  Created by ibrahim özdemir on 13.07.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import Foundation
import web3swift

class QuorumService{
    
    private lazy var accountStorageAdapterManager = AccountStorageAdapterManager()
    
    func setAccountFieldMainDataHelper(type: AccountFieldMainType, data: String, completion: @escaping (String?) -> Void) {
        do{
            guard let quorumAddress = self.accountStorageAdapterManager.quorumManager.accountAddress() else { fatalError("No quorum address found") }
            let result = try self.accountStorageAdapterManager.setAccountFieldMainData(type: type, value: data)
            guard let receipt = result["receipt"] as? TransactionReceipt, receipt.status == .ok else { throw KimlicError("Receipt not received!") }
            completion(quorumAddress.lowercased())
        } catch let error {
            print("Error \(error.localizedDescription)")
            completion(nil)
        }
    }
}
