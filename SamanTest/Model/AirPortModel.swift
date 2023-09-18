//
//  AirPortModel.swift
//  SamanTest
//
//  Created by Ashkan Ghaderi on 2022-02-16.
//

import Foundation
import Domain

// MARK: - AirPortModel
public struct AirPortModel {
    public var type: String?
    public var subType: String?
    public var name, detailedName: String?
    public var timeZoneOffset: String?
    public var iataCode: String?
    public var geoCode: GeoCode?
    public var address: Address?
    public var distance: Distance?
    public var analytics: Analytics?
    public var relevance: Double?
    
    public init(_ model: Domain.AirPort?) {
        self.type = model?.type
        self.subType = model?.subType
        self.name = model?.name
        self.detailedName = model?.detailedName
        self.timeZoneOffset = model?.timeZoneOffset
        self.geoCode = GeoCode(model?.geoCode)
        self.address = Address(model?.address)
        self.distance = Distance(model?.distance)
        self.analytics = Analytics(model?.analytics)
        self.relevance = model?.relevance
        self.iataCode = model?.iataCode
    }
    
    public init() {}
}

// MARK: - Address
public struct Address {
    public var cityName, cityCode: String?
    public var countryName: String?
    public var countryCode: String?
    public var regionCode: String?
    
    public init(_ model: Domain.Address?) {
        self.cityName = model?.cityName
        self.cityCode = model?.cityCode
        self.countryName = model?.countryName
        self.countryCode = model?.countryCode
        self.regionCode = model?.regionCode
    }
}

// MARK: - Analytics
public struct Analytics {
    public var flights, travelers: Flights?
    
    public init(_ model: Domain.Analytics?) {
        self.flights = Flights(model?.flights)
        self.travelers = Flights(model?.travelers)
    }
}

// MARK: - Flights
public struct Flights {
    public var score: Int?
    
    public init(_ model: Domain.Flights?) {
        self.score = model?.score
    }
}

// MARK: - Distance
public struct Distance {
    public var value: Int?
    public var unit: String?
    
    public init(_ model: Domain.Distance?) {
        self.value = model?.value
        self.unit = model?.unit
    }
}

// MARK: - GeoCode
public struct GeoCode {
    public var latitude, longitude: Double?
    
    public init(_ model: Domain.GeoCode?) {
        self.latitude = model?.latitude
        self.longitude = model?.longitude
    }
}

// MARK: - Meta
public struct Meta {
    public var count: Int?
    public var links: Links?
    
    public init(_ model: Domain.Meta) {
        self.count = model.count
        self.links = Links(model.links)
    }
}

// MARK: - Links
public struct Links {
    public var linksSelf, next, last: String?
    
    public init(_ model: Domain.Links?) {
        self.linksSelf = model?.linksSelf
        self.next = model?.next
        self.last = model?.last
    }
}
