//
//  QuorumManager.swift
//  kimlic
//
//  Created by Dmytro Nasyrov on 17.07.2018.
//  Copyright © 2018 Pharos Production Inc. All rights reserved.

import Foundation
import Quorum

final class QuorumManager {

    // MARK: - Variables
    
    let quorum: Quorum
    let mnemonic: String
    let accountAddress: String
    
    // MARK: - Life
    
    init(mnemonic: String?) {
        let quorumConfig = Constants.QuorumConfig()
        let web3Config = Web3Config(
            scheme: quorumConfig.scheme,
            host: quorumConfig.host,
            port: quorumConfig.port,
            path: quorumConfig.path,
            networkId: quorumConfig.networkId)
        quorum = Quorum(web3Config)

        switch mnemonic {
        case nil:
            self.mnemonic = try! Quorum.mnemonic()
            try! Quorum.keystoreWith(mnemonic: self.mnemonic)

        case let mnemonic?: self.mnemonic = mnemonic
        }

        self.accountAddress = quorum.accountAddress()!
    }
}
