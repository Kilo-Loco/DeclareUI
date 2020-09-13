//
//  DeclarableObject.swift
//  DeclareUI
//
//  Created by Kyle Lee on 9/12/20.
//  Copyright © 2020 Kilo Loco. All rights reserved.
//

#if canImport(UIKit)
import UIKit

public struct DeclarableObject {
    let view: UIView
    
    public init(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view = view
    }
}

public extension DeclarableObject {
    @discardableResult
    func width(_ value: CGFloat) -> Self {
        view.widthAnchor.constraint(equalToConstant: value).isActive = true
        return self
    }
    
    @discardableResult
    func height(_ value: CGFloat) -> Self {
        view.heightAnchor.constraint(equalToConstant: value).isActive = true
        return self
    }
    
    @discardableResult
    func size(_ value: CGFloat) -> Self {
        width(value)
        height(value)
        return self
    }
    
    @discardableResult
    func height(_ ratio: CGFloat, of layoutDimension: NSLayoutDimension) -> Self {
        view.heightAnchor.constraint(equalTo: layoutDimension, multiplier: ratio).isActive = true
        return self
    }
    
    @discardableResult
    func toSuperview(with padding: CGFloat = 0) -> Self {
        guard let superview = view.superview else { return self }
        view.topAnchor.constraint(equalTo: superview.topAnchor, constant: padding).isActive = true
        view.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: padding).isActive = true
        view.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -padding).isActive = true
        view.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -padding).isActive = true
        return self
    }
    
    @discardableResult
    func toSuperviewGuide(with padding: CGFloat = 0) -> Self {
        guard let constrainingView = view.superview?.layoutMarginsGuide else { return self }
        view.topAnchor.constraint(equalTo: constrainingView.topAnchor, constant: padding).isActive = true
        view.leadingAnchor.constraint(equalTo: constrainingView.leadingAnchor, constant: padding).isActive = true
        view.trailingAnchor.constraint(equalTo: constrainingView.trailingAnchor, constant: -padding).isActive = true
        view.bottomAnchor.constraint(equalTo: constrainingView.bottomAnchor, constant: -padding).isActive = true
        return self
    }
    
    @discardableResult
    func centerHorizontally() -> Self {
        guard let superview = view.superview else { return self }
        view.centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        return self
    }
    
    @discardableResult
    func centerVertically(with constrainingView: UIView? = nil) -> Self {
        guard
            let superview = constrainingView?.layoutMarginsGuide
                ?? view.superview?.layoutMarginsGuide
            else { return self }
        view.centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
        return self
    }
    
    enum Anchor {
        case top
        case leading
        case trailing
        case bottom
        case topWithOffset(CGFloat)
        case leadingWithOffset(CGFloat)
        case trailingWithOffset(CGFloat)
        case bottomWithOffset(CGFloat)
    }

    enum Edge {
        case top
        case leading
        case trailing
        case bottom
    }
    
    @discardableResult
    func constrainTo(_ anchors: Anchor...) -> Self {
        guard let superview = view.superview else { return self }
        
        for anchor in anchors {
            switch anchor {
            case .top:
                view.topAnchor.constraint(equalTo: superview.topAnchor)
                    .isActive = true
            case .leading:
                view.leadingAnchor.constraint(equalTo: superview.leadingAnchor)
                    .isActive = true
            case .trailing:
                view.trailingAnchor.constraint(equalTo: superview.trailingAnchor)
                    .isActive = true
            case .bottom:
                view.bottomAnchor.constraint(equalTo: superview.bottomAnchor)
                    .isActive = true
            case .topWithOffset(let constant):
                view.topAnchor.constraint(equalTo: superview.topAnchor, constant: constant)
                    .isActive = true
            case .leadingWithOffset(let constant):
                view.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant)
                    .isActive = true
            case .trailingWithOffset(let constant):
                view.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -constant)
                    .isActive = true
            case .bottomWithOffset(let constant):
                view.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant)
                    .isActive = true
            }
        }
        return self
    }
    
    @discardableResult
    func constrain(_ anchors: Anchor..., to constrainingView: UIView, _ edge: Edge) -> Self {
        
        let axisAnchor = [Edge.leading, Edge.trailing].contains(edge)
            ? edge == .leading ? constrainingView.leadingAnchor : constrainingView.trailingAnchor
            : edge == .top ? constrainingView.topAnchor : constrainingView.bottomAnchor
        
        for anchor in anchors {
            switch anchor {
            case .top:
                guard let yAxisAnchor = axisAnchor as? NSLayoutAnchor<NSLayoutYAxisAnchor> else { return self }
                view.topAnchor.constraint(equalTo: yAxisAnchor)
                    .isActive = true
            case .leading:
                guard let xAxisAnchor = axisAnchor as? NSLayoutAnchor<NSLayoutXAxisAnchor> else { return self }
                view.leadingAnchor.constraint(equalTo: xAxisAnchor)
                    .isActive = true
            case .trailing:
                guard let xAxisAnchor = axisAnchor as? NSLayoutAnchor<NSLayoutXAxisAnchor> else { return self }
                view.trailingAnchor.constraint(equalTo: xAxisAnchor)
                    .isActive = true
            case .bottom:
                guard let yAxisAnchor = axisAnchor as? NSLayoutAnchor<NSLayoutYAxisAnchor> else { return self }
                view.bottomAnchor.constraint(equalTo: yAxisAnchor)
                    .isActive = true
            case .topWithOffset(let constant):
                guard let yAxisAnchor = axisAnchor as? NSLayoutAnchor<NSLayoutYAxisAnchor> else { return self }
                view.topAnchor.constraint(equalTo: yAxisAnchor, constant: constant)
                    .isActive = true
            case .leadingWithOffset(let constant):
                guard let xAxisAnchor = axisAnchor as? NSLayoutAnchor<NSLayoutXAxisAnchor> else { return self }
                view.leadingAnchor.constraint(equalTo: xAxisAnchor, constant: constant)
                    .isActive = true
            case .trailingWithOffset(let constant):
                guard let xAxisAnchor = axisAnchor as? NSLayoutAnchor<NSLayoutXAxisAnchor> else { return self }
                view.trailingAnchor.constraint(equalTo: xAxisAnchor, constant: -constant)
                    .isActive = true
            case .bottomWithOffset(let constant):
                guard let yAxisAnchor = axisAnchor as? NSLayoutAnchor<NSLayoutYAxisAnchor> else { return self }
                view.bottomAnchor.constraint(equalTo: yAxisAnchor, constant: -constant)
                    .isActive = true
            }
        }
        return self
    }
    
    @discardableResult
    func constrainGuide(_ anchors: Anchor..., to constrainingView: UIView, _ edge: Edge) -> Self {
        
        let axisAnchor = [Edge.leading, Edge.trailing].contains(edge)
            ? edge == .leading ? constrainingView.leadingAnchor : constrainingView.trailingAnchor
            : edge == .top ? constrainingView.topAnchor : constrainingView.bottomAnchor
        
        for anchor in anchors {
            switch anchor {
            case .top:
                guard let yAxisAnchor = axisAnchor as? NSLayoutAnchor<NSLayoutYAxisAnchor> else { return self }
                view.topAnchor.constraint(equalTo: yAxisAnchor)
                    .isActive = true
            case .leading:
                guard let xAxisAnchor = axisAnchor as? NSLayoutAnchor<NSLayoutXAxisAnchor> else { return self }
                view.leadingAnchor.constraint(equalTo: xAxisAnchor)
                    .isActive = true
            case .trailing:
                guard let xAxisAnchor = axisAnchor as? NSLayoutAnchor<NSLayoutXAxisAnchor> else { return self }
                view.trailingAnchor.constraint(equalTo: xAxisAnchor)
                    .isActive = true
            case .bottom:
                guard let yAxisAnchor = axisAnchor as? NSLayoutAnchor<NSLayoutYAxisAnchor> else { return self }
                view.bottomAnchor.constraint(equalTo: yAxisAnchor)
                    .isActive = true
            case .topWithOffset(let constant):
                guard let yAxisAnchor = axisAnchor as? NSLayoutAnchor<NSLayoutYAxisAnchor> else { return self }
                view.topAnchor.constraint(equalTo: yAxisAnchor, constant: constant)
                    .isActive = true
            case .leadingWithOffset(let constant):
                guard let xAxisAnchor = axisAnchor as? NSLayoutAnchor<NSLayoutXAxisAnchor> else { return self }
                view.leadingAnchor.constraint(equalTo: xAxisAnchor, constant: constant)
                    .isActive = true
            case .trailingWithOffset(let constant):
                guard let xAxisAnchor = axisAnchor as? NSLayoutAnchor<NSLayoutXAxisAnchor> else { return self }
                view.trailingAnchor.constraint(equalTo: xAxisAnchor, constant: -constant)
                    .isActive = true
            case .bottomWithOffset(let constant):
                guard let yAxisAnchor = axisAnchor as? NSLayoutAnchor<NSLayoutYAxisAnchor> else { return self }
                view.bottomAnchor.constraint(equalTo: yAxisAnchor, constant: -constant)
                    .isActive = true
            }
        }
        return self
    }
    
    
    @discardableResult
    func constrainToGuide(_ anchors: Anchor...) -> Self {
        guard let constrainingView = view.superview?.layoutMarginsGuide else { return self }
        
        for anchor in anchors {
            switch anchor {
            case .top:
                view.topAnchor.constraint(equalTo: constrainingView.topAnchor)
                    .isActive = true
            case .leading:
                view.leadingAnchor.constraint(equalTo: constrainingView.leadingAnchor)
                    .isActive = true
            case .trailing:
                view.trailingAnchor.constraint(equalTo: constrainingView.trailingAnchor)
                    .isActive = true
            case .bottom:
                view.bottomAnchor.constraint(equalTo: constrainingView.bottomAnchor)
                    .isActive = true
            case .topWithOffset(let constant):
                view.topAnchor.constraint(equalTo: constrainingView.topAnchor, constant: constant)
                    .isActive = true
            case .leadingWithOffset(let constant):
                view.leadingAnchor.constraint(equalTo: constrainingView.leadingAnchor, constant: constant)
                    .isActive = true
            case .trailingWithOffset(let constant):
                view.trailingAnchor.constraint(equalTo: constrainingView.trailingAnchor, constant: -constant)
                    .isActive = true
            case .bottomWithOffset(let constant):
                view.bottomAnchor.constraint(equalTo: constrainingView.bottomAnchor, constant: -constant)
                    .isActive = true
            }
        }
        return self
    }
}
#endif
