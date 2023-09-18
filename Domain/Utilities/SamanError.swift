//
//  SamanError.swift
//  Domain
//
//  Created by Ashkan Ghaderi on 2022-02-15.
//

import Foundation

public enum SamanError: LocalizedError {
    
    case failure(message: String?)
    case unknownMessage

    public var localization: String {
        switch self {
        case .failure(let message):
            if let msg = message {
                return msg
            }
            return ""
        case .unknownMessage:
            return ""
        }
    }
    
    static func  getError(err: Error) -> SamanError  {
        return .unknownMessage
    }
}
