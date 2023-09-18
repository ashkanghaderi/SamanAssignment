//
//  AuthModel.swift
//  Domain
//
//  Created by Ashkan Ghaderi on 2022-02-15.
//

import Foundation

public struct AuthModel: Codable {
    public let type: String?
    public let username: String?
    public let application_name: String?
    public let client_id: String?
    public let token_type: String?
    public let access_token: String?
    public let expires_in: Int?
    public let state: String?
    public let scope: String?
}
