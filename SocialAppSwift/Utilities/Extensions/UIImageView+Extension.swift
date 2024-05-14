//
//  UIImageView+Extension.swift
//  SocialAppSwift
//
//  Created by Zeeshan Munir  on 13/05/2024.
//

import Foundation
import SDWebImage

extension UIImageView {
    func makeProfileImage(_ imageURL: String) {
        self.sd_setImage(with: URL(string: (imageURL)), placeholderImage: UIImage(named: "user_placeholder"))
    }
}
