//
//  Extensions.swift
//  20220824-TadreikCampbell-NYCSchools
//
//  Created by Tadreik Campbell on 8/25/22.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for v in views {
            addSubview(v)
        }
    }
}

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
