//
//  ConfigWebServiceRequest.swift
//  kimlic
//
//  Created by Dmytro Nasyrov on 7/17/18.
//  Copyright © 2018 Pharos Production Inc. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import SwiftyUserDefaults

final class ConfigWebServiceRequest {
    
    static func execute(accountAddress: String, success: @escaping ([String: Any]) -> Void, failure: @escaping (String?) -> Void) {
        let url = Constants.APIEndpoint.config.url()
        let headers: HTTPHeaders = [
            "account-address": accountAddress.lowercased()
        ]
        WebServicesBaseRequest().executeRequest(url: url, method: .get, params: nil, headers: headers, success: { result in
            guard let data = result["data"] as? [String: Any] else { failure(nil); return }
            success(data)
        }, failure: failure)
    }
}
