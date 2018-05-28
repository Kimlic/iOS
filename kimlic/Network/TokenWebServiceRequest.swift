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
            "grant_type" : Bundle.main.grantType,
            "client_id" : Bundle.main.clientID,
            "client_secret" : Bundle.main.clientSecret
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

