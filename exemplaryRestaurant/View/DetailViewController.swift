//
//  DetailViewController.swift
//  exemplaryRestaurant
//
//  Created by 김준건 on 2022/04/12.
//

import UIKit

class DetailViewController: UIViewController {
    private let viewModel: DetailViewModel
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var titleLabel = UILabel.makeLabel(font: .title1, text: viewModel.restaurantMKAnnotation?.title, color: .black)
    private lazy var typeLabel = UILabel.makeLabel(font: .caption1, text: viewModel.restaurantMKAnnotation?.type, color: .black)
    private var locationImageView = UIImageView(image: UIImage(systemName: "map.circle"))
    private lazy var locationLabel = UILabel.makeLabel(font: .body, text: viewModel.restaurantMKAnnotation?.locationName, color: .black)
    private lazy var foodMenuLabel = UILabel.makeLabel(font: .body, text: viewModel.restaurantMKAnnotation?.subtitle, color: .black)
    private lazy var titleStackView = UIStackView.makeStackView(alignment: .fill, distribution: .fillProportionally, axis: .horizontal, subviews: [titleLabel, typeLabel])
    private lazy var loctaionStackView = UIStackView.makeStackView(alignment: .fill, distribution: .fillProportionally, axis: .horizontal, spacing: 5, subviews: [locationImageView, locationLabel])
    private lazy var infoStackView = UIStackView.makeStackView(alignment: .fill, distribution: .fill, axis: .vertical, spacing: 5, subviews: [titleStackView, loctaionStackView,foodMenuLabel])

    override func viewDidLoad() {
        view.backgroundColor = .white
        setLayoutForInfoStackView()
        configureLabel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        viewModel.viewWillDisapper()
    }
    
    private func configureLabel() {
        titleLabel.adjustsFontSizeToFitWidth = true
        typeLabel.adjustsFontSizeToFitWidth = true
        foodMenuLabel.numberOfLines = 0
    }
    
    private func setLayoutForInfoStackView() {
        view.addSubview(infoStackView)

        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoStackView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, constant: -20),
            infoStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            infoStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            infoStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])

    }
}
