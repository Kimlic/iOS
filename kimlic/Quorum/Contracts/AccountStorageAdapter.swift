//
//  AccountStorageAdapter.swift
//  kimlic
//
//  Created by ibrahim özdemir on 5.07.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import Foundation
import Quorum

struct AccountStorageAdapter: QuorumContract {
    
    struct Getters {
    }
    
    struct Transactions {
        let setAccountFieldMainData = "setAccountFieldMainData"
    }
    
    let address: String
    let ABI: String
    let getters = Getters()
    let transactions = Transactions()
    
    init(address: String) throws {
        self.address = address
        ABI = "[{\"constant\":false,\"inputs\":[],\"name\":\"renounceOwnership\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[],\"name\":\"owner\",\"outputs\":[{\"name\":\"\",\"type\":\"address\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"newOwner\",\"type\":\"address\"}],\"name\":\"transferOwnership\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"inputs\":[{\"name\":\"contextstorage\",\"type\":\"address\"}],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"constructor\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"name\":\"previousOwner\",\"type\":\"address\"}],\"name\":\"OwnershipRenounced\",\"type\":\"event\"},{\"anonymous\":false,\"inputs\":[{\"indexed\":true,\"name\":\"previousOwner\",\"type\":\"address\"},{\"indexed\":true,\"name\":\"newOwner\",\"type\":\"address\"}],\"name\":\"OwnershipTransferred\",\"type\":\"event\"},{\"constant\":false,\"inputs\":[{\"name\":\"fieldName\",\"type\":\"string\"}],\"name\":\"addAllowedFieldName\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"fieldName\",\"type\":\"string\"}],\"name\":\"removeAllowedFieldName\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"fieldName\",\"type\":\"string\"}],\"name\":\"isAllowedFieldName\",\"outputs\":[{\"name\":\"\",\"type\":\"bool\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"data\",\"type\":\"string\"},{\"name\":\"accountFieldName\",\"type\":\"string\"}],\"name\":\"setAccountFieldMainData\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"accountAddress\",\"type\":\"address\"},{\"name\":\"accountFieldName\",\"type\":\"string\"}],\"name\":\"getLastAccountDataVerificationContractAddress\",\"outputs\":[{\"name\":\"verificationContract\",\"type\":\"address\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"accountAddress\",\"type\":\"address\"},{\"name\":\"accountFieldName\",\"type\":\"string\"},{\"name\":\"index\",\"type\":\"uint256\"}],\"name\":\"getAccountDataVerificationContractAddress\",\"outputs\":[{\"name\":\"verificationContract\",\"type\":\"address\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"accountAddress\",\"type\":\"address\"},{\"name\":\"accountFieldName\",\"type\":\"string\"}],\"name\":\"getAccountFieldLastMainData\",\"outputs\":[{\"name\":\"data\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"accountAddress\",\"type\":\"address\"},{\"name\":\"accountFieldName\",\"type\":\"string\"},{\"name\":\"index\",\"type\":\"uint256\"}],\"name\":\"getAccountFieldMainData\",\"outputs\":[{\"name\":\"data\",\"type\":\"string\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"accountAddress\",\"type\":\"address\"},{\"name\":\"accountFieldName\",\"type\":\"string\"}],\"name\":\"getAccountFieldLastVerificationData\",\"outputs\":[{\"name\":\"verificationStatus\",\"type\":\"uint8\"},{\"name\":\"verificationContractAddress\",\"type\":\"address\"},{\"name\":\"verifiedAt\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"accountAddress\",\"type\":\"address\"},{\"name\":\"accountFieldName\",\"type\":\"string\"},{\"name\":\"index\",\"type\":\"uint256\"}],\"name\":\"getAccountFieldVerificationData\",\"outputs\":[{\"name\":\"verificationStatus\",\"type\":\"uint8\"},{\"name\":\"verificationContractAddress\",\"type\":\"address\"},{\"name\":\"verifiedAt\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"accountAddress\",\"type\":\"address\"},{\"name\":\"accountFieldName\",\"type\":\"string\"},{\"name\":\"verificationContractAddress\",\"type\":\"address\"}],\"name\":\"setAccountFieldVerificationContractAddress\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":false,\"inputs\":[{\"name\":\"accountAddress\",\"type\":\"address\"},{\"name\":\"accountFieldName\",\"type\":\"string\"},{\"name\":\"index\",\"type\":\"uint256\"},{\"name\":\"verificationContractAddress\",\"type\":\"address\"}],\"name\":\"setAccountFieldVerificationContractAddress\",\"outputs\":[],\"payable\":false,\"stateMutability\":\"nonpayable\",\"type\":\"function\"},{\"constant\":true,\"inputs\":[{\"name\":\"accountAddress\",\"type\":\"address\"},{\"name\":\"accountFieldName\",\"type\":\"string\"}],\"name\":\"getFieldHistoryLength\",\"outputs\":[{\"name\":\"length\",\"type\":\"uint256\"}],\"payable\":false,\"stateMutability\":\"view\",\"type\":\"function\"}]"
    }
}