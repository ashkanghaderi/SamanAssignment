//
//  UseCaseProvider.swift
//  Domain
//
//  Created by Ashkan Ghaderi on 2022-02-16.
//

import Foundation

public protocol UseCaseProvider {
    func makeAirPortUseCase() -> AirPortUseCase
}
