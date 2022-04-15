//
//  UILable+Extension.swift
//  exemplaryRestaurant
//
//  Created by 김준건 on 2022/04/12.
//
import UIKit

extension UILabel {
    static func makeLabel(font: UIFont.TextStyle = .body, text: String? = "-", color: UIColor = .black) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = color
        label.font = UIFont.preferredFont(forTextStyle: font)
        label.text = text
        return label
    }
}
