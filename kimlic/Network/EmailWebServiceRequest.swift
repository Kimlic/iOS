//
//  EmailWebServiceRequest
//  CustomTabBar
//
//  Created by İzzet Öztürk on 23.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
import Foundation
import ObjectMapper
import Alamofire
import SwiftyUserDefaults
import web3swift

final class EmailWebServiceRequest: NSObject {
    
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
    
    func getEmail(completion: @escaping (EmailResponse?) -> Void) {
        
        let requestUrl = Constants.WebServicesUrl.BaseEmails
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + (Defaults[.userToken] ?? "")
        ]
        
//        WebServicesBaseRequest().executeRequest(url: requestUrl, method: .get, params: [:], headers: headers, success: { (stringJson) in
//            if stringJson != nil {
//                let emailRes = WrappedRootResponseCollection<EmailResponse>(JSONString: stringJson!) // WrappedRootResponseCollection.[WrappedResponse].EmailResponse -> data[].attributes
//                if  emailRes != nil {
//                    let email = emailRes?.data?[0].attributes
//                    completion(email)
//                }else {
//                    completion(nil)
//                }
//            }else {
//                completion(nil)
//            }
//        }, failure: { _ in })
    }    
}
