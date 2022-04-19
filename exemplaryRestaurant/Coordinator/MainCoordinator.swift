//
//  Coordinator.swift
//  exemplaryRestaurant
//
//  Created by 김준건 on 2022/04/10.
//

import UIKit
import MapKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set}
    var navigationConrtoller: UINavigationController { get set }
    
    func start()
}

final class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationConrtoller: UINavigationController
    
    init(navigationConrtoller: UINavigationController) {
        self.navigationConrtoller = navigationConrtoller
    }
    
    func start() {
        let mapViewModel = DefaultMapViewModel()
        let mainViewController = MainViewController(viewModel: mapViewModel)
        mapViewModel.coordinator = self
        navigationConrtoller.pushViewController(mainViewController, animated: true)
        
    }
    
    func pushDetailVC(_ restaurant: MKAnnotation?) {
        guard let restaurant = restaurant else {
            return
        }
        let detailCoordinator = DetailViewCoordinator(navigationController: navigationConrtoller, restaurant: restaurant)
        detailCoordinator.parentCoordinator = self
        childCoordinators.append(detailCoordinator)
        detailCoordinator.start()
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
            }
        }
    }
    
}
