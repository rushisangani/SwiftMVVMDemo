//
//  UIView+Constraints.swift
//  SwiftMVVMDemo
//
//  Created by Rushi Sangani on 06/12/2023.
//

import Foundation
import UIKit

extension UIView {
    func autoPinEdgesToSuperViewEdges() {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
    }
}
