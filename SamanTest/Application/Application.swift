//
//  Application.swift
//  SamanTest
//
//  Created by Ashkan Ghaderi on 2022-02-16.
//

import Foundation
import Domain
import NetworkPlatform
import UIKit

final class Application {
    static let shared = Application()
    
    private let networkUseCaseProvider: Domain.UseCaseProvider
    private init() {
        
        self.networkUseCaseProvider = UseCaseProvider()
    }
    
    func configureMainInterface(_ window: UIWindow){
        let mainNavigationController = MainNavigationController()
        window.rootViewController = mainNavigationController
        window.makeKeyAndVisible()
        
        MapPointNavigator(navigationController: mainNavigationController, services: networkUseCaseProvider).setup()
        
    }
}
