//
//  APIService.swift
//  Heady
//
//  Created by Saurabh Gupta on 09/07/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import Foundation
import Alamofire

class APIService {
    
    static let standard = APIService()
    
    private func request(url : String,
                         method: HTTPMethod,
                         parameters: [String: Any]?,
                         headers: HTTPHeaders?,
                         completionHandler: @escaping ([String: Any]? , Error?) -> Void) {
        let request = Alamofire.request(url, method: method, parameters: parameters, headers: headers).responseJSON { response in
            guard response.result.isSuccess else {
                completionHandler(nil, response.result.error)
                return
            }
            
            guard let value = response.result.value as? [String: Any] else {
                completionHandler(nil, NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Malformed data received"]))
                return
            }
            
            completionHandler(value, nil)
        }
        debugPrint(request)
    }
    
    func getProducts(completionHandler: @escaping ((Product?, Error?) -> Void)) {
        let productURL = "https://stark-spire-93433.herokuapp.com/json"
        request(url: productURL,
                method: .get,
                parameters: nil,
                headers: nil) { [weak self]
                    (responseValue, error) in
                    if let error = error {
                        completionHandler(nil, error)
                        return
                    }
                    
                    if let value = responseValue {
                        // Error handling should be present here for all the error codes designed by backend engineer for this Endpoint. One example is given below.
                        
//                        let status = value["status"] as! String
//                        let errorCode = value["error_code"] as! String
//                        if status == "failure" && errorCode == "1" {
//                            completionHandler(nil, NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid Request"]))
//
//                            return
//                        }
                        do {
                            let data = try JSONSerialization.data(withJSONObject: value as Any, options: .prettyPrinted)
                            let decoder = JSONDecoder()
                            var allProduct = try decoder.decode(Product.self, from: data)
                            
                            completionHandler(allProduct, nil)
                        } catch let err {
                            print("Err", err)
                            completionHandler(nil, err)
                        }
                    }
        }
    }
}
