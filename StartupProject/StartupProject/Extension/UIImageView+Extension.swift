//  UIImageView+Extension.swift
//  StartupProject
//
//  Created by Hiral Jotaniya on 02/12/21.
//

import Foundation
import UIKit
extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}

