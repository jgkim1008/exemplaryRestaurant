//
//  ViewController.swift
//  exemplaryRestaurant
//
//  Created by 김준건 on 2022/03/31.
//

import UIKit
import MapKit
import RxSwift
import RxCocoa
import RxMKMapView

class MainViewController: UIViewController {
    private var mapView = MKMapView()
    let viewModel = MapViewModel()
    let viewDisposeBag = DisposeBag()
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayoutForMapView()
        bindLocation()
        bindAnnotation()
        selectAnnotationView()

    }
    
    private func bindLocation() {
        viewModel.currentLocationObservable
            .asDriver(onErrorJustReturn: MKCoordinateRegion())
            .drive(mapView.rx.region)
            .disposed(by: viewDisposeBag)
    }
    
    private func bindAnnotation() {
        viewModel.restaurantObservable
            .asDriver(onErrorJustReturn: [])
            .drive(mapView.rx.annotations)
            .disposed(by: viewDisposeBag)
    }
    
    private func selectAnnotationView() {
        mapView.rx.didSelectAnnotationView
            .subscribe(onNext: { _ in
                print("터치됨")
            })
    }
    
    private func setLayoutForMapView() {
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.heightAnchor.constraint(equalTo: view.heightAnchor),
            mapView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        ])
    }
}
