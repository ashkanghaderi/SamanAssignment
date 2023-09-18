//
//  Service+Injection.swift
//  NetworkPlatform
//
//  Created by Ashkan Ghaderi on 2022-02-16.
//

import Foundation
import Resolver
import Domain

extension Resolver{
    
    public static func  ServiceInjection(){
        register(AuthService.self) {AuthService(network: NetworkManager())}
        register(AirPortService.self) {AirPortService(network: NetworkManager())}
    }
}

