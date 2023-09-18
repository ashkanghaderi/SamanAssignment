//
//  AirPort.swift
//  Domain
//
//  Created by Ashkan Ghaderi on 2022-02-15.
//

import Foundation

// MARK: - Welcome
public struct AirPortResult: Codable {
    public let meta: Meta
    public let data: [AirPort]
}

// MARK: - Datum
public struct AirPort: Codable {
    public let type: String?
    public let subType: String?
    public let name, detailedName: String?
    public let timeZoneOffset: String?
    public let iataCode: String?
    public let geoCode: GeoCode?
    public let address: Address?
    public let distance: Distance?
    public let analytics: Analytics?
    public let relevance: Double?
}

// MARK: - Address
public struct Address: Codable {
    public let cityName, cityCode: String?
    public let countryName: String?
    public let countryCode: String?
    public let regionCode: String?
}

// MARK: - Analytics
public struct Analytics: Codable {
    public let flights, travelers: Flights?
}

// MARK: - Flights
public struct Flights: Codable {
    public let score: Int?
}

// MARK: - Distance
public struct Distance: Codable {
    public let value: Int?
    public let unit: String?
}

// MARK: - GeoCode
public struct GeoCode: Codable {
    public let latitude, longitude: Double?
}

// MARK: - Meta
public struct Meta: Codable {
    public let count: Int?
    public  let links: Links?
}

// MARK: - Links
public struct Links: Codable {
    public let linksSelf, next, last: String?

    enum CodingKeys: String, CodingKey {
        case linksSelf = "self"
        case next, last
    }
}
