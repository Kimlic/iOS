//
//  TokenWebServiceRequest
//  CustomTabBar
//
//  Created by paltimoz on 11/23/17.
//  Copyright © 2017 Ratel. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

class TokenWebServiceRequest: NSObject {
    
    func clientCredentialsRequest(completion: @escaping (TokenResponse?) -> Void) {
        
        let requestUrl = Constants.WebServicesUrl.ClientCredentials
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        let parameters: Parameters = [
            "grant_type" : "client_credentials",
            "client_id" : "90c8c7cab6a1cfe3808992bb9fc3d96f14d783581371336eb046e8143e3eedab",
            "client_secret" : "38ef41d735a0a323d536ab8a2fcc6881d267a1710956bffbb6df3672edd8a333"
        ]
        
        WebServicesBaseRequest().executeRequest(url: requestUrl, method: .post, params: parameters, headers: headers) { (stringJson) in
            if stringJson != nil {
                if let clientCredentials = TokenResponse(JSONString: stringJson!) {
                    completion(clientCredentials)
                }else {
                    completion(nil)
                }
            }else {
                completion(nil)
            }
        }
    }
    
    
    func resourceOwnerRequest(walletAddress: String!, privateKey: String!, completion: @escaping (TokenResponse?) -> Void) {
        
        let requestUrl = Constants.WebServicesUrl.ClientCredentials        
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        let parameters: Parameters = [
            "grant_type" : "password",
            "redirect_uri": "urn:ietf:wg:oauth:2.0:oob",
            "username" : walletAddress,
            "password" : privateKey
        ]
        
        WebServicesBaseRequest().executeRequest(url: requestUrl, method: .post, params: parameters, headers: headers) { (stringJson) in
            if stringJson != nil {
                if let clientCredentials = TokenResponse(JSONString: stringJson!) {
                    completion(clientCredentials)
                }else {
                    completion(nil)
                }
            }else {
                completion(nil)
            }
        }
    }
    
    
    
}

