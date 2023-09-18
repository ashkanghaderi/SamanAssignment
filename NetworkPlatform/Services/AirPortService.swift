//
//  AirPortService.swift
//  NetworkPlatform
//
//  Created by Ashkan Ghaderi on 2022-02-16.
//

import Foundation
import RxSwift
import Domain
import Alamofire

public final class AirPortService{
    
    private let network: NetworkManager
    
    init(network: NetworkManager) {
        self.network = network
    }
    
    public func fetchAirPorts(lat:Double,lng:Double,sort: String?,onResult: @escaping ((AirPortResult?) -> Void),onError: @escaping (Error?) -> Void) {
        let url = BaseURL.dev.rawValue + ServiceRouter.LocationServiceRoute(.airports).url
        guard let token = AuthorizationInfo.getToken() else {
            return
        }
        let param = ["latitude":lat,"longitude":lng,"page[limit]":20,"sort":sort ?? "relevance"] as [String : Any]
        let headerArray: HTTPHeaders = [ "Authorization": "Bearer  \(token)"]
        network.request(url,parameters: param,headers: headerArray) { result in
            let decoder = JSONDecoder()
            switch result {
            case .success(let data):
                do
                {
                    let value = try decoder.decode(AirPortResult.self, from: data)
                    
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

