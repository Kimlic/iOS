//
//  QuorumAPI.swift
//  kimlic
//
//  Created by Dmytro Nasyrov on 7/18/18.
//  Copyright © 2018 Kimlic. All rights reserved.
//

import Foundation
import web3swift

final class QuorumAPI {
    
    // MARK: - Types
    
    enum AccountFieldMainType: String {
        case email = "email"
        case phone = "phone"
    }
    
    struct ContractAddresses {
        let contextContract: String
        let accountStorageAdapter: String?
    }
    
    struct QuroumAPIError: Error {

        enum ErrorKind: String {
            case contextContractAddress = "No context contract address"
            case accountStorageAdapterAddress = "No account storage adapter address"
        }
        
        let kind: ErrorKind
    }
    
    // MARK: - Variables
    
    let addresses: ContractAddresses
    let quorumManager: QuorumManager

    private lazy var accountStorageAdapter: AccountStorageAdapter = {
        return try! AccountStorageAdapter(address: addresses.accountStorageAdapter!)
    }()
    
    // MARK: - Public
    
    init(addresses: [String: Any], manager: QuorumManager) throws {
        quorumManager = manager
        
        guard let contextContractAddress = addresses["context_contract"] as? String else { throw QuroumAPIError(kind: .contextContractAddress) }
        let contractAddresses = ContractAddresses(contextContract: contextContractAddress, accountStorageAdapter: nil)
        
        let contextContract = KimlicContextContract(address: contractAddresses.contextContract)
        let result = try! manager.quorum.call(contract: contextContract, method: contextContract.getters.getAccountStorageAdapter)
        
        guard let accountStorageAdapterAddress = result["accountStorageAdapter"] as? EthereumAddress else { throw QuroumAPIError(kind: .contextContractAddress) }
        self.addresses = ContractAddresses(
            contextContract: contextContractAddress,
            accountStorageAdapter: accountStorageAdapterAddress.address)
    }
    
    // TODO: Alttaki yapi degistirilecek, duzenlenecek
    func setAccountFieldMainData(type: AccountFieldMainType, value: String) throws -> [String: Any] {
//        ‘{“phone”: “151090B5FC99E6391180FC30D59C41D7B62D7DE92ED671AFF374D5084718407A”}’
//
//        setFieldMainData(‘{“phone”: “151090B5FC99E6391180FC30D59C41D7B62D7DE92ED671AFF374D5084718407A”}’, ‘phone’)
//
//        setFieldMainData(“151090B5FC99E6391180FC30D59C41D7B62D7DE92ED671AFF374D5084718407A”, ‘phone’)
        
        let param = "{\"phone\":\"\(value.sha256())\"}"

        let params = [param, type.rawValue]
        let method = accountStorageAdapter.transactions.setAccountFieldMainData
        print("PARAMS: \(params)   METHOD: \(method)")
        return try quorumManager.quorum.send(contract: accountStorageAdapter, method: method, params: params)
    }
}
