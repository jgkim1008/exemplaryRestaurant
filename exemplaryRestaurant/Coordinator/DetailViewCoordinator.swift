//
//  DetailViewCoordinator.swift
//  exemplaryRestaurant
//
//  Created by 김준건 on 2022/04/12.
//

import UIKit

final class DetailViewCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationConrtoller: UINavigationController
    weak var parentCoordinator: MainCoordinator?
    var viewModel: DetailViewModel
    
    init(navigationController: UINavigationController, viewModel: DetailViewModel) {
        self.navigationConrtoller = navigationController
        self.viewModel = viewModel
    }
    
    func start() {
        let detailViewController = DetailViewController(viewModel: viewModel)
        detailViewController.coordinator = self
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
