//
//  WebServicesBaseRequest
//  CustomTabBar
//
//  Created by İzzet Öztürk on 23.11.2017.
//  Copyright © 2017 Ratel. All rights reserved.
import Foundation
import Alamofire
import SwiftyJSON

class WebServicesBaseRequest: NSObject {
    
    func executeRequest(url: String, method: HTTPMethod, params : Parameters?, headers: HTTPHeaders?, completion : @escaping (String?) -> Void){
        
        Alamofire.request(url, method: method, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success:
                if response.response?.statusCode == 200 || response.response?.statusCode == 201{
                    if let data = response.data, let utf8Json = String(data: data, encoding: .utf8) {
                        completion(utf8Json)
                    }else {
                        completion(nil)
                    }
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
}

