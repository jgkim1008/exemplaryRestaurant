//
//  DetailViewCoordinator.swift
//  exemplaryRestaurant
//
//  Created by 김준건 on 2022/04/12.
//

import UIKit
import MapKit

final class DetailViewCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationConrtoller: UINavigationController
    weak var parentCoordinator: MainCoordinator?
    private var detailViewModel: DetailViewModel
    
    init(navigationController: UINavigationController, restaurant: MKAnnotation) {
        self.navigationConrtoller = navigationController
        self.detailViewModel = DefaultDetailViewModel(restaurant: restaurant)
    }
    
    func start() {
        let detailViewController = DetailViewController(viewModel: detailViewModel)
        let defaultDetailViewModel = detailViewModel as? DefaultDetailViewModel
        defaultDetailViewModel?.coordinator = self
        if let sheet = detailViewController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.selectedDetentIdentifier = .medium
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 30
        }
        navigationConrtoller.present(detailViewController, animated: true, completion: nil)
    }
    
    func viewWillDisapper() {
        parentCoordinator?.childDidFinish(self)
    }
}
