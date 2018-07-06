//
//  BaseContract.swift
//  kimlic
//
//  Created by ibrahim özdemir on 5.07.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import Foundation
import Quorum


class BaseContractManager{
    public let cons = Constants.Contracts()
    private var configCustom: Web3Config
    public var quorumManager: Quorum
    
    init(){
        configCustom = Web3Config(scheme: cons.BaseHTTP, host: cons.BaseURL, port: cons.BasePort, path: cons.BasePath, networkId: 10)
        quorumManager = Quorum(configCustom)
        initMnemonic()
    }
    
    private func initMnemonic(){
        let mnemonic = try! Quorum.mnemonic()
        print("MNEMONIC: ", mnemonic, "\n")
        try! Quorum.keystoreWith(mnemonic: mnemonic)
    }
    
    private struct ContractAddressProduction {
        static let appBlue = "123"
    }
    
    private struct ContractAddressDebug {
        static let appBlue = "456"
    }

}
