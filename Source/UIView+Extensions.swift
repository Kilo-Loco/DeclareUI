//
//  UIView+Extensions.swift
//  DeclareUI
//
//  Created by Kyle Lee on 9/12/20.
//  Copyright © 2020 Kilo Loco. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { [weak self] in self?.addSubview($0) }
    }
    
    var declare: DeclarableObject {
        DeclarableObject(self)
    }
}
#endif
