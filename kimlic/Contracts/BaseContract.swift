//
//  BaseContract.swift
//  kimlic
//
//  Created by ibrahim özdemir on 5.07.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import Foundation
import Quorum


class BaseContract{
    private let configCustom = Web3Config(scheme: "http", host: "127.0.0.1", port: 22000, path:"/api/proxy", networkId: 10)
    public var quorumManager: Quorum
    
    init(){
        quorumManager = Quorum(configCustom)
        initMnemonic()
    }
    
    private func initMnemonic(){
        let mnemonic = try! Quorum.mnemonic()
        print("MNEMONIC: ", mnemonic, "\n")
        try! Quorum.keystoreWith(mnemonic: mnemonic)
    }

}
