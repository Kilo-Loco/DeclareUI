//
//  UIStackView+Extensions.swift
//  DeclareUI
//
//  Created by Kyle Lee on 9/12/20.
//  Copyright © 2020 Kilo Loco. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { self.addArrangedSubview($0) }
    }
}
#endif
