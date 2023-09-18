//
//  AirPortUseCaseMock.swift
//  SamanTestTests
//
//  Created by Ashkan Ghaderi on 2022-02-18.
//

@testable import SamanTest
import Foundation
import RxSwift
import Domain

class AirPortUseCaseMock: Domain.AirPortUseCase {

  var airPorts_ReturnValue: Observable<[AirPort]> = Observable.just([])
  var airPorts_Called = false
  var token_ReturnValue: Observable<Bool> = Observable.just(true)
  var token_Called = false
    
    func getToken() -> Observable<Bool> {
        token_Called = true
        return token_ReturnValue
    }
    
    func fetchAirPorts(lat: Double, lng: Double, sort: String?) -> Observable<[AirPort]> {
        airPorts_Called = true
        return airPorts_ReturnValue
    }
}
