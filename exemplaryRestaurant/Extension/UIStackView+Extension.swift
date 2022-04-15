//
//  UIStackView+Extension.swift
//  exemplaryRestaurant
//
//  Created by 김준건 on 2022/04/12.
//

import UIKit

extension UIStackView {
    static func makeStackView(alignment: UIStackView.Alignment = .fill,
                              distribution: UIStackView.Distribution = .fill,
                              axis: NSLayoutConstraint.Axis = .horizontal,
                              spacing: CGFloat = 0,
                              subviews: [UIView] = [])
    -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: subviews)
        stackView.alignment = alignment
        stackView.distribution = distribution
        stackView.axis = axis
        stackView.spacing = spacing
        return stackView
    }
}
