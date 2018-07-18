//
//  QrCodeWebServiceRequest.swift
//  kimlic
//
//  Created by İzzet Öztürk on 27.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
import Foundation
import ObjectMapper
import Alamofire
import SwiftyUserDefaults

class QrCodeWebServiceRequest: NSObject {
    
    func authenticationRequest(appId: String, token: String, completion: @escaping (Bool?) -> Void) {
        
        let requestUrl = Constants.WebServicesUrl.Authenticate
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + (Defaults[.userToken] ?? "")
        ]
        
        let parameters: Parameters = [
            "data": [
                "attributes": [
                    "application_id": appId,
                    "token": token
                ]
            ]
        ]
        
        Alamofire.request(requestUrl, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success:
                if response.response?.statusCode == 200 || response.response?.statusCode == 204{
                    completion(true)
                }else {
                    completion(nil)
                }
                break
            case .failure(let error):
                print(error)
                completion(nil)
                break
                
            }
        }
    }
    func getApplicationDetail(appId: String, completion: @escaping (PermissionDetailResponse?) -> Void) {
        
        let requestUrl = Constants.WebServicesUrl.Applications + "/\(appId)"
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + (Defaults[.userToken] ?? "")
        ]
        
//        WebServicesBaseRequest().executeRequest(url: requestUrl, method: .get, params: [:], headers: headers, success: { (stringJson) in
//            if stringJson != nil {
//                // WrappedRootResponse.WrappedResponse.PermissionDetailResponse -> data.attributes
//                let permissionDetail = WrappedRootResponse<PermissionDetailResponse>(JSONString: stringJson!)
//                if  permissionDetail != nil {
//                    let permissionDetail = permissionDetail?.data?.attributes
//                    completion(permissionDetail)
//                }else {
//                    completion(nil)
//                }
//            }else {
//                completion(nil)
//            }
//        }, failure: { _ in })
    }
    
    func getUserAllPermissions(completion: @escaping ([PermissionDetailResponse]?) -> Void) {
        
        let requestUrl = Constants.WebServicesUrl.AllPermissions
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + (Defaults[.userToken] ?? "")
        ]
//        
//        WebServicesBaseRequest().executeRequest(url: requestUrl, method: .get, params: [:], headers: headers, success: { (stringJson) in
//            if stringJson != nil {
//                // WrappedRootResponseCollection.[WrappedResponse].PermissionDetailResponse
//                let allPermissions = WrappedRootResponseCollection<PermissionDetailResponse>(JSONString: stringJson!)
//                if  allPermissions != nil && allPermissions?.included != nil{
//                    var permissionList = [PermissionDetailResponse]()
//                    allPermissions!.included!.forEach({ (wrapResponse) in
//                        if let permission = wrapResponse.attributes {
//                             permissionList.append(permission)
//                        }
//                    })
//                    completion(permissionList)
//                }else {
//                    completion(nil)
//                }
//            }else {
//                completion(nil)
//            }
//        }, failure: { _ in })
    }
}
