//
//  NetworkManager.swift
//  NetworkPlatform
//
//  Created by Ashkan Ghaderi on 2022-02-15.
//

import Foundation
import Alamofire
import Domain

class NetworkManager {
    static let shared: NetworkManager = {
        return NetworkManager()
    }()
    typealias completionHandler = ((Result<Data, SamanError>) -> Void)
    var request: Alamofire.Request?
    let retryLimit = 3
    let authorize = BaseURL.dev.rawValue + ServiceRouter.AuthServiceRoute(.oAuth).url
    func authorize(completion: @escaping completionHandler) {
        request?.cancel()
        let apiKey = AppSetting.API_KEY
        let secretKey = AppSetting.API_SECRET
        let headerArray: HTTPHeaders = [ "Content-Type": "application/x-www-form-urlencoded"]
        let parameters = ["grant_type": "client_credentials", "client_id": apiKey, "client_secret": secretKey]
        request = AF.request(authorize, method: .post, parameters: parameters, headers: headerArray).responseJSON { response in
            if let data = response.data {
                completion(.success(data))
            } else {
                completion(.failure(.unknownMessage))
            }
        }
    }
    
    func request(_ url: String, method: HTTPMethod = .get, parameters: Parameters? = nil,
                 encoding: ParameterEncoding = URLEncoding.queryString, headers: HTTPHeaders? = nil,
                 interceptor: RequestInterceptor? = nil, completion: @escaping completionHandler) {
        AF.request(url, method: method, parameters: parameters, encoding: encoding,
                   headers: headers, interceptor: interceptor ?? self).validate().responseJSON { (response) in
            if let data = response.data {
                completion(.success(data))
            } else {
                completion(.failure(.unknownMessage))
            }
        }
    }
    
}

