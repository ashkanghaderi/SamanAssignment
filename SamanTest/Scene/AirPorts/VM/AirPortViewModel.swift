//
//  AirPortViewModel.swift
//  SamanTest
//
//  Created by Ashkan Ghaderi on 2022-02-16.
//

import Foundation
import Domain
import RxSwift
import RxCocoa

final class AirPortViewModel: ViewModelType {
    
    private let navigator: AirPortNavigatorProtocol
    private let useCase: Domain.AirPortUseCase
    private let model: [AirPortModel]
    
    init( navigator: AirPortNavigatorProtocol,
          useCase: Domain.AirPortUseCase,
          model: [AirPortModel]) {
        self.useCase = useCase
        self.navigator = navigator
        self.model = model
    }
    
    func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        let airPorts = Driver.of(self.model)
        
        let lat = self.model.first?.geoCode?.latitude
        let lng = self.model.first?.geoCode?.longitude
        
        let sortedAirPorts = input.sortSegment.flatMapLatest { sortIndex in
            return self.useCase.fetchAirPorts(lat: lat ?? 0.0, lng: lng ?? 0.0 ,sort: self.provideSortString(sortIndex))
                .trackActivity(activityIndicator)
                .trackError(errorTracker)
                .asDriverOnErrorJustComplete()
                .map { $0.map { AirPortModel($0) } }
        }
           
        let selectedAirPort = input.selectionTrigger
            .withLatestFrom(airPorts) { (indexPath, items) -> AirPortModel in
                return items[indexPath.row]
            }.do(onNext: navigator.toAirPortDetail)
        
                let fetching = activityIndicator.asDriver()
                let errors = errorTracker.asDriver()
                let finalAirPorts = Driver.merge(airPorts,sortedAirPorts)
                
                return Output(airPorts: finalAirPorts,sortedAirPorts: sortedAirPorts ,selectedAirPort: selectedAirPort,error: errors, isFetching: fetching)
                }
    
    private func provideSortString(_ index:Int) -> String {
        switch index {
        case 0:
            return "relevance"
        case 1:
            return "distance"
        case 2:
            return "analytics.flights.score"
        case 3:
            return "analytics.travelers.score"
        default :
            return "relevance"
        }
    }
}

extension AirPortViewModel {
    struct Input {
        let selectionTrigger: Driver<IndexPath>
        let sortSegment: Driver<Int>
    }
    
    struct Output {
        
        let airPorts: Driver<[AirPortModel]>
        let sortedAirPorts: Driver<[AirPortModel]>
        let selectedAirPort: Driver<AirPortModel>
        let error: Driver<Error>
        let isFetching: Driver<Bool>
        
    }
    
}



