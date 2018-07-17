//
//  PhoneService.swift
//  kimlic
//
//  Created by ibrahim özdemir on 13.07.2018.
//  Copyright © 2018 Ratel. All rights reserved.
//

import Foundation

import ObjectMapper
import Alamofire
import SwiftyUserDefaults

class PhoneService: NSObject {
    
    private lazy var quorumService = QuorumService()

    
    func addPhone(type: AccountFieldMainType, data: String, completion: @escaping (PermissionDetailResponse?) -> Void) {
        quorumService.setAccountFieldMainDataHelper(type: type, data: data) { (quorumAddress) in
            if quorumAddress == nil {
                completion(nil)
            }
            self.addPhoneHelper(type: type, data: data, quorumAddress: quorumAddress!, completion: { (permissionDetailResponse) in
                completion(nil)
            })
        }
    }
    
    private func addPhoneHelper(type: AccountFieldMainType, data: String, quorumAddress: String, completion: @escaping (PermissionDetailResponse?) -> Void) {

        
       // guard let responsewww = responsea as? [String: [String: AnyObject]] else { strongSelf.showPhoneError(); return }
        
       // guard let code = responsewww["meta"]?["code"] as? Int, code == 201 else { strongSelf.showPhoneError(); return }
        
        
        
        
        
        let requestUrl = Constants.ServicesUrl.AddPhone
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "account-address": quorumAddress.lowercased()
        ]
        
        let parameters = ["phone": data]
        
        WebServicesBaseRequest().executeRequest(url: requestUrl, method: .post, params: parameters, headers: headers) { (stringJson) in
            if stringJson != nil {
                // WrappedRootResponse.WrappedResponse.PermissionDetailResponse -> data.attributes
                let permissionDetail = WrappedRootResponse<PermissionDetailResponse>(JSONString: stringJson!)
                if  permissionDetail != nil {
                    let permissionDetail = permissionDetail?.data?.attributes
                    completion(permissionDetail)
                }else {
                    completion(nil)
                }
            }else {
                completion(nil)
            }
        }
    }
    
    func getUserAllPermissions(completion: @escaping ([PermissionDetailResponse]?) -> Void) {
        
        let requestUrl = Constants.WebServicesUrl.AllPermissions
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + (Defaults[.userToken] ?? "")
        ]
        
        WebServicesBaseRequest().executeRequest(url: requestUrl, method: .get, params: nil, headers: headers) { (stringJson) in
            if stringJson != nil {
                // WrappedRootResponseCollection.[WrappedResponse].PermissionDetailResponse
                let allPermissions = WrappedRootResponseCollection<PermissionDetailResponse>(JSONString: stringJson!)
                if  allPermissions != nil && allPermissions?.included != nil{
                    var permissionList = [PermissionDetailResponse]()
                    allPermissions!.included!.forEach({ (wrapResponse) in
                        if let permission = wrapResponse.attributes {
                            permissionList.append(permission)
                        }
                    })
                    completion(permissionList)
                }else {
                    completion(nil)
                }
            }else {
                completion(nil)
            }
        }
    }
}
