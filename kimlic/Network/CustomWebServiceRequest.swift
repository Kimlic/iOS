//
//  CustomWebServiceRequest.swift
//  kimlic
//
//  Created by izzet öztürk on 29.07.2018.
//  Copyright © 2018 Kimlic. All rights reserved.
//

import Foundation
import Alamofire
import web3swift

final class CustomWebServiceRequest {
    
    private static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // MARK: - Get Config
    static func getConfig(accountAddress: String, success: @escaping ([String: Any]) -> Void, failure: @escaping (String?) -> Void) {
        let url = Constants.APIEndpoint.config.url()
        let headers: HTTPHeaders = [
            "account-address": accountAddress.lowercased()
        ]
        WebServicesBaseRequest().executeRequest(url: url, method: .get, params: nil, headers: headers, success: { result in
            guard let data = result["data"] as? [String: Any] else { failure(nil); return }
            success(data)
        }, failure: failure)
    }
    
    // MARK: - Create Email
    static func createEmail(email: String, success: @escaping () -> Void, failure: @escaping (String) -> Void) {
        do {
            let result = try appDelegate.quorumAPI?.setFieldMainData(type: QuorumAPI.AccountFieldMainType.email, value: email)
            guard let receipt = result!["receipt"] as? TransactionReceipt, receipt.status == .ok else { failure("errorMessage".localized); return }
            
            let url = Constants.APIEndpoint.emailVerification.url()
            let headers = ["account-address": appDelegate.quorumManager!.accountAddress.lowercased()]
            let params =  ["email": email]
            
            WebServicesBaseRequest().executeRequest(url: url, method: .post, params: params, headers: headers, success: { (data) in
                success()
            }) { (error) in
                failure(error ?? "errorMessage".localized)
            }
        } catch _ {
            failure("errorMessage".localized)
        }
    }
    
    // MARK: - Create Phone
    static func createPhone(phone: String, success: @escaping () -> Void, failure: @escaping (String) -> Void) {
        do {
            let result = try appDelegate.quorumAPI?.setFieldMainData(type: QuorumAPI.AccountFieldMainType.phone, value: phone)
            guard let receipt = result!["receipt"] as? TransactionReceipt, receipt.status == .ok else { failure("errorMessage".localized); return }
            
            let url = Constants.APIEndpoint.phoneVerification.url()
            let headers = ["account-address": appDelegate.quorumManager!.accountAddress.lowercased()]
            let params =  ["phone": phone]
            
            WebServicesBaseRequest().executeRequest(url: url, method: .post, params: params, headers: headers, success: { (data) in
                success()
            }) { (error) in
                failure(error ?? "errorMessage".localized)
            }
        } catch _ {
            failure("errorMessage".localized)
        }
    }
    
    // MARK: - Approve Code
    static func approveCode(code: String, type: VerificationType, success: @escaping () -> Void, failure: @escaping (String) -> Void) {
        
        
        var url: String
        
        switch type {
        case .phone: url = Constants.APIEndpoint.phoneVerificationApprove.url()
        case .email: url = Constants.APIEndpoint.emailVerificationApprove.url()
        }
        
        let headers = ["account-address": appDelegate.quorumManager!.accountAddress.lowercased()]
        let params =  ["code": code]
        WebServicesBaseRequest().executeRequest(url: url, method: .post, params: params, headers: headers, success: { (data) in
            success()
        }) { (error) in
            failure(error ?? "errorMessage".localized)
        }
    }
    
    // MARK: - Verification Documents
    static func getVerificationDocuments(success: @escaping ([VerificationDocument]) -> Void, failure: @escaping (String?) -> Void) {
        let url = "https://ap-api-test.kimlic.com/api/verifications/digital/vendors"
        let headers = ["account-address": appDelegate.quorumManager!.accountAddress.lowercased()]
        
        WebServicesBaseRequest().executeRequest(url: url, method: .get, params: nil, headers: headers, success: { (response) in
            do {
                let data = try JSONSerialization.data(withJSONObject: response["data"], options: .prettyPrinted)
                let documents = try JSONDecoder().decode([VerificationDocument].self, from: data)
                success(documents)
            } catch {
                failure("errorMessage".localized)
            }
        }) { (error) in
            failure(error ?? "errorMessage".localized)
        }
    }
}
