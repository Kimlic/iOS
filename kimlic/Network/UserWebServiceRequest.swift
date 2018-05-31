//
//  UserWebServiceRequest
//  CustomTabBar
//
//  Created by İzzet Öztürk on 23.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
import Foundation
import ObjectMapper
import Alamofire
import SwiftyUserDefaults

class UserWebServiceRequest: NSObject {
    
    func createUser(user: User, completion: @escaping (UserCreateResponse?) -> Void) {
        
        let requestUrl = Constants.WebServicesUrl.CreateUser
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + (Defaults[.accessToken] ?? "")
        ]
        
        let parameters: Parameters = [
            "data": [
                "attributes": [
                    "first_name": user.firstName,
                    "last_name": user.lastName,
                    "email": user.email
                ]
            ]
        ]
        
        WebServicesBaseRequest().executeRequest(url: requestUrl, method: .post, params: parameters, headers: headers) { (stringJson) in
            if stringJson != nil {
                let userCreateRes = WrappedRootResponse<UserCreateResponse>(JSONString: stringJson!) // WrappedRootResponse.WrappedResponse.UserCreateResponse -> data.attributes
                if  userCreateRes != nil {
                    let user = userCreateRes?.data?.attributes
                    completion(user)
                }else {
                    completion(nil)
                }
            }else {
                completion(nil)
            }
        }
        
    }
    
    func updateProfileImage(user: User, completion: @escaping (UserResponse?) -> Void) {
        let requestUrl = Constants.WebServicesUrl.UpdateUser
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + (Defaults[.userToken] ?? "")
        ]
        
        let parameters: Parameters = [
            "data": [
                "attributes": [
                    "first_name": user.firstName,
                    "last_name": user.lastName,
                    "avatar": "data:image/png;base64, " + (user.image?.convertBase64() ?? "")
                ]
            ]
        ]
        
        WebServicesBaseRequest().executeRequest(url: requestUrl, method: .put, params: parameters, headers: headers) { (stringJson) in
            if stringJson != nil {
                let userCreateRes = WrappedRootResponse<UserResponse>(JSONString: stringJson!) // WrappedRootResponse.WrappedResponse.UserResponse -> data.attributes
                if  userCreateRes != nil {
                    let user = userCreateRes?.data?.attributes
                    completion(user)
                }else {
                    completion(nil)
                }
            }else {
                completion(nil)
            }
        }
        
    }
}

