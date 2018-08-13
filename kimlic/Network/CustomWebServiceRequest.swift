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
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
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
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
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
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
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
    
    // MARK: - Create verification session
    // TODO: Code Refactoring
    static func createVerificationSession(success: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let user = CoreDataHelper.getUser()
        let url = "https://ap-api-test.kimlic.com/api/verifications/digital/sessions"
        let headers = ["account-address": appDelegate.quorumManager!.accountAddress.lowercased()]
        let params =  ["first_name": user?.firstName,
                       "last_name": user?.lastName,
                       "lang": "en",
                       "document_type": "DRIVERS_LICENSE",
                       "timestamp": 1631209420,
                       "contract_address": appDelegate.quorumAPI?.addresses.contextContract,
                       "device_os": "ios",
                       "device_token": user?.deviceToken
            ] as [String : Any]
        
        WebServicesBaseRequest().executeRequest(url: url, method: .post, params: params, headers: headers, success: { (data) in
            print(data)
            success("")
        }) { (error) in
            failure(error ?? "errorMessage".localized)
        }
    }
    
    // MARK: - Create verification session
    // TODO: Code Refactoring
    static func photoUpload(image: UIImage, sessionID: String, context: DocumentPhotoContext, countryCode: String, success: (() -> Void)? = nil, failure: ((String) -> Void)? = nil) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let url = "https://ap-api-test.kimlic.com/api/verifications/digital/sessions/\(sessionID)/media"
        let headers = ["account-address": appDelegate.quorumManager!.accountAddress.lowercased()]
        let params =  [
            "country": countryCode,
            "context": context.rawValue,
            "content": image.convertBase64(),
            "timestamp": 1631209420
            ] as [String : Any]
        
        WebServicesBaseRequest().executeRequest(url: url, method: .post, params: params, headers: headers, success: { (data) in
            print(data)
            success()
        }) { (error) in
            failure(error ?? "errorMessage".localized)
        }
    }
    
}
