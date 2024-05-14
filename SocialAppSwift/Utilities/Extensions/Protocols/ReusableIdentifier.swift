//
//  ReusableIdentifier.swift
//  SocialAppSwift
//
//  Created by Zeeshan Munir  on 13/05/2024.
//

import UIKit

protocol ReusableIdentifier {
    static var reuseIdentifier: String { get }
}

extension ReusableIdentifier {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UIView: ReusableIdentifier {}
extension UIViewController: ReusableIdentifier {}
