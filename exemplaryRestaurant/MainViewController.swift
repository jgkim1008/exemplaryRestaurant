//
//  ViewController.swift
//  exemplaryRestaurant
//
//  Created by 김준건 on 2022/03/31.
//

import UIKit
import MapKit
import RxCocoa

class MainViewController: UIViewController {
    private var mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayoutForMapView()
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

