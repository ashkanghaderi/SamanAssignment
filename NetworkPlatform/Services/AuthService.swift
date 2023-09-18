//
//  AuthService.swift
//  NetworkPlatform
//
//  Created by Ashkan Ghaderi on 2022-02-16.
//

import Foundation
import RxSwift
import Domain

public final class AuthService{
    
    private let network: NetworkManager
    
    init(network: NetworkManager) {
        self.network = network
    }
    
    public func getToken(onResult: @escaping ((AuthModel?) -> Void),onError: @escaping (Error?) -> Void) {
        network.authorize() { result in
            let decoder = JSONDecoder()
            switch result {
            case .success(let data):
                do
                {
                    let value = try decoder.decode(AuthModel.self, from: data)
                    AuthorizationInfo.saveData(data: value)
                    onResult(value)
                } catch let err {
                    onError(err)
                }
            case .failure(let error):
                onError(error)
            }
        }
    }
}
