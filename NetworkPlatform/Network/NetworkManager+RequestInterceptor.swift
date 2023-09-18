//
//  NetworkManager+RequestInterceptor.swift
//  NetworkPlatform
//
//  Created by Ashkan Ghaderi on 2022-02-15.
//

import Foundation
import Alamofire
import Domain

extension NetworkManager: RequestInterceptor {
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var request = urlRequest
        guard let token = AuthorizationInfo.getToken() else {
            completion(.success(urlRequest))
            return
        }
        let bearerToken = "Bearer \(token)"
        request.setValue(bearerToken, forHTTPHeaderField: "Authorization")
        print("\nadapted; token added to the header field is: \(bearerToken)\n")
        completion(.success(request))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error,
               completion: @escaping (RetryResult) -> Void) {
        guard request.retryCount < retryLimit else {
            completion(.doNotRetry)
            return
        }
        print("\nretried; retry count: \(request.retryCount)\n")
        refreshToken { isSuccess in
            isSuccess ? completion(.retry) : completion(.doNotRetry)
        }
    }
    
    func refreshToken(completion: @escaping (_ isSuccess: Bool) -> Void) {
        let apiKey = AppSetting.API_KEY
        let secretKey = AppSetting.API_SECRET
        let headerArray: HTTPHeaders = [ "Content-Type": "application/x-www-form-urlencoded"]
        let parameters = ["grant_type": "client_credentials", "client_id": apiKey, "client_secret": secretKey]
        AF.request(authorize, method: .post, parameters: parameters, headers: headerArray ).responseJSON { response in
            if let data = response.data {
                let decoder = JSONDecoder()
                
                if let value = try? decoder.decode(AuthModel.self, from: data) {
                    
                    AuthorizationInfo.saveData(data: value)
                    print("success",value)
                }
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
}
