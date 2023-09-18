//
//  CustomError.swift
//  Domain
//
//  Created by Ashkan Ghaderi on 2022-02-15.
//

import Foundation

// MARK: - Welcome
public struct CustomError: Codable {
    public let errors: [PublicError]?
}

// MARK: - Error
public struct PublicError: Codable {
    public let status, code: Int?
    public let title, detail: String?
    public let source: Source?
}

// MARK: - Source
public struct Source: Codable {
    public let parameter, example: String?
}
