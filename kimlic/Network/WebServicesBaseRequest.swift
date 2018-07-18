//
//  WebServicesBaseRequest
//  CustomTabBar
//
//  Created by İzzet Öztürk on 23.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
//
//  Changed by Dmytro Nasyrov on 18.07.2018.
//  Copyright © 2018 Pharos Production Inc. All rights reserved.

import Foundation
import Alamofire
import SwiftyJSON

class WebServicesBaseRequest: NSObject {
    
    func executeRequest(url: String, method: HTTPMethod, params: Parameters?, headers: HTTPHeaders, success: @escaping ([String: Any]) -> Void, failure: @escaping (String?) -> Void) {
        Alamofire.request(url, method: method, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON() { response in
            switch response.result {
            case .failure(let error): failure(error.localizedDescription)
            case .success:
                guard let code = response.response?.statusCode, 200...299 ~= code else { failure(nil); return }
                guard let json = response.value as? [String: Any] else { failure(nil); return }
                success(json)
            }
        }
    }    
}

