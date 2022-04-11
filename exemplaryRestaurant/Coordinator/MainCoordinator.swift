//
//  Coordinator.swift
//  exemplaryRestaurant
//
//  Created by 김준건 on 2022/04/10.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinator: [Coordinator] { get set}
    var navigationConrtoller: UINavigationController { get set }
    
    func start()
}

final class MainCoordinator: Coordinator {
    var childCoordinator = [Coordinator]()
    var navigationConrtoller: UINavigationController
    
    init(navigationConrtoller: UINavigationController) {
        self.navigationConrtoller = navigationConrtoller
    }
    
    func start() {
        let mainViewController = MainViewController()
        mainViewController.coordinator = self
        navigationConrtoller.pushViewController(mainViewController, animated: true)
    }
    
    
}
