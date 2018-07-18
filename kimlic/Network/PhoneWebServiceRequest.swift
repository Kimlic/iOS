//
//  PhoneWebServiceRequest
//  CustomTabBar
//
//  Created by İzzet Öztürk on 23.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
import Foundation
import ObjectMapper
import Alamofire
import SwiftyUserDefaults

class PhoneWebServiceRequest: NSObject {
    
    func createPhone(phoneNumber: String!, countryCode: UInt64!, completion: @escaping (PhoneResponse?) -> Void) {
        
        let requestUrl = Constants.WebServicesUrl.BasePhone
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + (Defaults[.userToken] ?? "")
        ]
        
        let parameters: Parameters = [
            "data": [
                "attributes": [
                    "value": phoneNumber,
                    "country_code": countryCode
                ]
            ]
        ]
//        
//        WebServicesBaseRequest().executeRequest(url: requestUrl, method: .post, params: parameters, headers: headers, success: { (stringJson) in
//            if stringJson != nil {
//                let phoneCreateRes = WrappedRootResponse<PhoneResponse>(JSONString: stringJson!) // WrappedRootResponse.WrappedResponse.PhoneResponse -> data.attributes
//                if  phoneCreateRes != nil {
//                    let phone = phoneCreateRes?.data?.attributes
//                    Defaults[.phoneId] = phoneCreateRes?.data?.id
//                    completion(phone)
//                }else {
//                    completion(nil)
//                }
//            }else {
//                completion(nil)
//            }
//        }, failure: { _ in })
        
    }
    
    func verifyPhone(verifiyCode: String!, completion: @escaping (PhoneResponse?) -> Void) {
        
        let baseUrl = Constants.WebServicesUrl.BasePhone + "/" + (Defaults[.phoneId] ?? "")
        let verifyUrl = "/verify/" + verifiyCode
        let requestUrl = baseUrl + verifyUrl
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + (Defaults[.userToken] ?? "")
        ]
        
        
//        WebServicesBaseRequest().executeRequest(url: requestUrl, method: .put, params: [:], headers: headers, success: { (stringJson) in
//            if stringJson != nil {
//                let phoneVerifyRes = WrappedRootResponse<PhoneResponse>(JSONString: stringJson!) // WrappedRootResponse.WrappedResponse.PhoneResponse -> data.attributes
//                if  phoneVerifyRes != nil {
//                    let phone = phoneVerifyRes?.data?.attributes
//                    completion(phone)
//                }else {
//                    completion(nil)
//                }
//            }else {
//                completion(nil)
//            }
//        }, failure: { _ in })
        
    }
    func resendVerifiyCode(completion: @escaping (PhoneResponse?) -> Void) {
        
        let baseUrl = Constants.WebServicesUrl.BasePhone + "/" + (Defaults[.phoneId] ?? "")
        let requestUrl = baseUrl + "/verification_request"
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + (Defaults[.userToken] ?? "")
        ]
        
        
//        WebServicesBaseRequest().executeRequest(url: requestUrl, method: .post, params: [:], headers: headers, success: { (stringJson) in
//            if stringJson != nil {
//                let phoneVerifyRes = WrappedRootResponse<PhoneResponse>(JSONString: stringJson!) // WrappedRootResponse.WrappedResponse.PhoneResponse -> data.attributes
//                if  phoneVerifyRes != nil {
//                    let phone = phoneVerifyRes?.data?.attributes
//                    completion(phone)
//                }else {
//                    completion(nil)
//                }
//            }else {
//                completion(nil)
//            }
//        }, failure: { _ in })
        
    }
}
