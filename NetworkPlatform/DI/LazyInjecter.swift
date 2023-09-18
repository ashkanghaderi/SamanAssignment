//
//  LazyInjecter.swift
//  NetworkPlatform
//
//  Created by Ashkan Ghaderi on 2022-02-16.
//

import Foundation
import Resolver

extension Resolver:ResolverRegistering{
    // new injections should be added here
    public static func registerAllServices() {
        ServiceInjection()
    }
}

@propertyWrapper
struct LazyInjected<Service> {
    private var service: Service!
    public var container: Resolver?
    public var name: Resolver.Name?
    public init() {}
    public init(name: Resolver.Name? = nil, container: Resolver? = nil) {
        self.name = name
        self.container = container
    }
    public var wrappedValue: Service {
        mutating get {
            if self.service == nil {
                self.service = container?.resolve(Service.self, name: name) ?? Resolver.resolve(Service.self, name: name)
            }
            return service
        }
        mutating set { service = newValue  }
    }
    public var projectedValue: LazyInjected<Service> {
        get { return self }
        mutating set { self = newValue }
    }
}
