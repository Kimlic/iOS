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
    
    // MARK: - Verify ID created
    static func createVerifyID(request: VerifyIDModel, success: @escaping () -> Void, failure: @escaping (String?) -> Void) {
        CustomWebServiceRequest.createVerificationSession(request: request, success: { (sessionID) in
            print(sessionID)
//            CustomWebServiceRequest.photoUploads(sessionID: sessionID, request: request, success: {}, failure: { (error) in failure(error)})
        }) { (error) in
            UIUtils.stopLoading()
            // TODO: Error Popup
            print(error)
        }
    }
    
    private static func photoUploads(sessionID: String, request: VerifyIDModel, success: @escaping () -> Void, failure: @escaping (String?) -> Void) {
        
        // face upload
        CustomWebServiceRequest.photoUpload(sessionID: sessionID, request: request, context: .face, success: {success()}, failure: {err in failure(err)})
        
        // front image upload
        CustomWebServiceRequest.photoUpload(sessionID: sessionID, request: request, context: .documentFront, success: {success()}, failure: {err in failure(err)})
        
        // back image upload
        CustomWebServiceRequest.photoUpload(sessionID: sessionID, request: request, context: .documentBack, success: {success()}, failure: {err in failure(err)})
    }
    
    // MARK: - Create verification session
    static func createVerificationSession(request: VerifyIDModel, success: @escaping (String) -> Void, failure: @escaping (String) -> Void) {
        
        // Set local varibles
        let url = "https://ap-api-test.kimlic.com/api/verifications/digital/sessions"
        let headers = ["account-address": request.accountAddress]
        let params =  [
            "first_name": request.firstName,
            "last_name": request.lastName,
            "lang": request.lang,
            "document_type": request.documentType.rawValue,
            "timestamp": request.timestamp,
            "contract_address": request.contractAddress,
            "device_os": request.deviceOs,
            "device_token": request.deviceToken
            ] as [String : Any]
        
        // Web service request
        WebServicesBaseRequest().executeRequest(url: url, method: .post, params: params, headers: headers, success: { (response) in
            print(response)
            if let data = response["data"] as? [String: Any], let sessionID = data["session_id"] as? String {
                success(sessionID)
            } else {
                failure("errorMessage".localized)
            }
        }) { (error) in
            failure(error ?? "errorMessage".localized)
        }
    }
    
    // MARK: - Photo Upload
    static func photoUpload(sessionID: String, request: VerifyIDModel, context: DocumentPhotoContext, success: (() -> Void)? = nil, failure: ((String) -> Void)? = nil) {
        
        var contextValue: String = ""
        
        switch context {
        case .face:
            contextValue = request.faceImage?.convertBase64() ?? contextValue
        case .documentFront:
            contextValue = request.documentFrontImage?.convertBase64() ?? contextValue
        case .documentBack:
            contextValue = request.documentBackImage?.convertBase64() ?? contextValue
        }
        
        let url = "https://ap-api-test.kimlic.com/api/verifications/digital/sessions/\(sessionID)/media"
        let headers = ["account-address": request.accountAddress]
        let params =  [
            "country": request.country,
            "context": context.rawValue,
            "content": contextValue,
            "timestamp": request.timestamp
            ] as [String : Any]
        
        WebServicesBaseRequest().executeRequest(url: url, method: .post, params: params, headers: headers, success: { (data) in
//            print(data)
            success?()
        }) { (error) in
            failure?(error ?? "errorMessage".localized)
        }
    }
    
}
