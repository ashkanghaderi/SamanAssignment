//
//  MapNavigator.swift
//  SamanTest
//
//  Created by Ashkan Ghaderi on 2022-02-16.
//

import Foundation
import Domain
import UIKit

protocol MapPointNavigatorProtocol {
    func toAirPorts(model: [AirPortModel])
}

class MapPointNavigator: MapPointNavigatorProtocol {
    
    private let navigationController: UINavigationController
    private let services: UseCaseProvider
    
    init(navigationController: UINavigationController, services: UseCaseProvider) {
        self.navigationController = navigationController
        self.services = services
    }
    
    func setup() {
        let mapVC = MapPointViewController(nibName: "MapPointViewController", bundle: nil)
        mapVC.viewModel = MapPointViewModel(navigator: self, useCase: services.makeAirPortUseCase())
        navigationController.viewControllers = [mapVC]
    }
    
    func toAirPorts(model: [AirPortModel]) {
        AirPortNavigator(navigationController: navigationController, services: services).setup(model: model)
    }
    
}
