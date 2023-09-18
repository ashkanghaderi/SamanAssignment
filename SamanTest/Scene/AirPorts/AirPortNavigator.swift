//
//  AirPortNavigator.swift
//  SamanTest
//
//  Created by Ashkan Ghaderi on 2022-02-16.
//

import Foundation
import Domain
import UIKit

protocol AirPortNavigatorProtocol {
    func toAirPortDetail(model: AirPortModel)
}

class AirPortNavigator: AirPortNavigatorProtocol {
    
    private let navigationController: UINavigationController
    private let services: UseCaseProvider
    
    init(navigationController: UINavigationController, services: UseCaseProvider) {
        self.navigationController = navigationController
        self.services = services
    }
    
    func setup(model: [AirPortModel]) {
        let airPortVC = AirPortViewController(nibName: "AirPortViewController", bundle: nil)
        airPortVC.viewModel = AirPortViewModel(navigator: self, useCase: services.makeAirPortUseCase(), model: model)
        navigationController.pushViewController(airPortVC, animated: true)
    }
    
    func toAirPortDetail(model: AirPortModel) {
       // to air port detail info
    }
}
