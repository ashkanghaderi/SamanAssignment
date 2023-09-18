//
//  AuthorizationInfo.swift
//  NetworkPlatform
//
//  Created by Ashkan Ghaderi on 2022-02-15.
//

import Foundation
import Foundation
import KeychainAccess
import Domain
import Alamofire

public class AuthorizationInfo {
    
    public static func isAuth() -> Bool{
        let keychain = Keychain(service: "com.Home.SamanTest")
        if keychain["access_token"] != nil{
            return true
        } else{
            return false
        }
    }
    
    public static func isAllowToContinue(message: String?) -> Bool {
        let keychain = Keychain(service: "com.Home.SamanTest")
        
        return keychain["access_token"] != nil
    }
    
    public static func getToken()->String?{
        let keychain = Keychain(service: "com.Home.SamanTest")
        return keychain["access_token"]
    }
    
    public static func save(_ value:String?,key:String){
        let keychain = Keychain(service: "com.Home.SamanTest")
        keychain[key] = value
    }
    
    public static func saveData(data: AuthModel){
        let keychain = Keychain(service: "com.Home.SamanTest")
        keychain["username"] = data.username
        keychain["client_id"] = data.client_id
        keychain["access_token"] = data.access_token
    }
    
    public static func remove(by key:String){
        let keychain = Keychain(service: "com.Home.SamanTest")
        try? keychain.remove(key)
    }
    
    public static func get(by key: String)->String?{
        let keychain = Keychain(service: "com.Home.SamanTest")
        return keychain[key]
        
    }
    
    public static func clearAuth(){
        do {
            let keychain = Keychain(service: "com.Home.SamanTest")
            try keychain.removeAll()
        } catch {
            print("error on clear creditionals")
        }
    }
    
}
