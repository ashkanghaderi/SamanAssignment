//
//  AirPortUseCase.swift
//  NetworkPlatform
//
//  Created by Ashkan Ghaderi on 2022-02-16.
//

import Foundation
import Domain
import RxSwift

public final class AirPortUseCase: Domain.AirPortUseCase {
    
    @LazyInjected private var authService: AuthService
    @LazyInjected private var airPortService: AirPortService
    
    public init(){}
    
    public func getToken() -> Observable<Bool> {
        Observable<Bool>.create { observer in
            self.authService.getToken(onResult: { auth in
                if auth != nil {
                    observer.onNext(true)
                } else {
                    observer.onNext(false)
                }
                observer.onCompleted()
            }, onError: { error in
                observer.onError(SamanError.failure(message: error?.localizedDescription))
            })
           return Disposables.create()
        }
    }
    
    public func fetchAirPorts(lat: Double, lng: Double,sort: String? = "relevance") -> Observable<[AirPort]> {
        Observable<[AirPort]>.create { observer in
            self.airPortService.fetchAirPorts(lat: lat, lng: lng, sort: sort, onResult: { airPortResult in
                if let airPorts = airPortResult {
                    observer.onNext(airPorts.data)
                    observer.onCompleted()
                }
            }, onError: { error in
                observer.onError(SamanError.failure(message: error?.localizedDescription))
            })
           return Disposables.create()
        }
    }
}

