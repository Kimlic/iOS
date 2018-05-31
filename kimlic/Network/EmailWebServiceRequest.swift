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

class EmailWebServiceRequest: NSObject {
    
    func getEmail(completion: @escaping (EmailResponse?) -> Void) {
        
        let requestUrl = Constants.WebServicesUrl.BaseEmails
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + (Defaults[.userToken] ?? "")
        ]
        
        WebServicesBaseRequest().executeRequest(url: requestUrl, method: .get, params: nil, headers: headers) { (stringJson) in
            if stringJson != nil {
                let emailRes = WrappedRootResponseCollection<EmailResponse>(JSONString: stringJson!) // WrappedRootResponseCollection.[WrappedResponse].EmailResponse -> data[].attributes
                if  emailRes != nil {
                    let email = emailRes?.data?[0].attributes
                    completion(email)
                }else {
                    completion(nil)
                }
            }else {
                completion(nil)
            }
        }
    }    
}
