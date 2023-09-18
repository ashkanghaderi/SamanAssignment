//
//  MapViewController.swift
//  SamanTest
//
//  Created by Ashkan Ghaderi on 2022-02-16.
//

import Foundation
import Domain
import RxSwift
import RxCocoa

final class MapPointViewModel: ViewModelType {
    
    private let navigator: MapPointNavigatorProtocol
    private let useCase: Domain.AirPortUseCase
    
    init( navigator: MapPointNavigatorProtocol, useCase: Domain.AirPortUseCase) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let canStart = input.viewWillAppearTrigger.flatMapLatest {
            return self.useCase.getToken()
                .trackActivity(activityIndicator)
                .trackError(errorTracker)
                .asDriverOnErrorJustComplete()
                .map { $0 }
        }
        
        let airPorts = Driver.combineLatest(input.latitude,input.longitude).flatMapLatest {
            param in
            return self.useCase.fetchAirPorts(lat: param.0, lng: param.1,sort: nil)
                .trackActivity(activityIndicator)
                .trackError(errorTracker)
                .asDriverOnErrorJustComplete()
                .map { $0.map { AirPortModel($0) }
                    
                }.do(onNext: self.navigator.toAirPorts)
        }
        
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
        
        return Output(airPorts: airPorts ,canStart: canStart, error: errors, isFetching: fetching)
    }
}

extension MapPointViewModel {
    struct Input {
        let viewWillAppearTrigger: Driver<Void>
        let latitude: Driver<Double>
        let longitude: Driver<Double>
    }
    
    struct Output {
        let airPorts: Driver<[AirPortModel]>
        let canStart: Driver<Bool>
        let error: Driver<Error>
        let isFetching: Driver<Bool>
    }
}
