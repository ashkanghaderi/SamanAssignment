//
//  ServiceRouter.swift
//  Domain
//
//  Created by Ashkan Ghaderi on 2022-02-15.
//

import Foundation

public enum BaseURL: String {
    
    case dev = "https://test.api.amadeus.com/"
    
}

// MARK: - ServiceRouter Definition

public enum ServiceRouter {
    case AuthServiceRoute(AuthRoute)
    case LocationServiceRoute(LocationRoute)
}

extension ServiceRouter {
    public var url: String {
        switch self {
        case .AuthServiceRoute(let authRoute):
            return authRoute.path
            
        case .LocationServiceRoute(let locRoute):
            return locRoute.path
        
        }
 
    }
}


// MARK: - AuthRoute

public enum AuthRoute: String {
    
    case oAuth = "/security/oauth2/token"
    
    var path: String {
        return  AppSetting.API_VERSION + rawValue
    }
}

// MARK: - LocationRoute

public enum LocationRoute: String {
    
    case airports = "/reference-data/locations/airports"
    
    var path: String {
        return  AppSetting.API_VERSION + rawValue
    }
}
