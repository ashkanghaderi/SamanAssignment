//
//  AirPortUseCase.swift
//  Domain
//
//  Created by Ashkan Ghaderi on 2022-02-16.
//

import Foundation
import RxSwift

public protocol AirPortUseCase {
    func getToken() -> Observable<Bool>
    func fetchAirPorts(lat:Double,lng:Double,sort:String?) -> Observable<[AirPort]>
}
