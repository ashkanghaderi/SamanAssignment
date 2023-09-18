//
//  UseCaseProvider.swift
//  NetworkPlatform
//
//  Created by Ashkan Ghaderi on 2022-02-16.
//

import Foundation
import Domain

public final class UseCaseProvider: Domain.UseCaseProvider
{
    public init() {}
    
    public func makeAirPortUseCase() -> Domain.AirPortUseCase {
        AirPortUseCase()
    }
}
