//
//  UIView+Extension.swift
//  toonitooni
//
//  Created by buzz on 2021/04/28.
//

import UIKit

extension UIView {

  static var reuseIdentifier: String {
    let nameSpace = NSStringFromClass(self)
    guard let className = nameSpace.components(separatedBy: ".").last else {
      return nameSpace
    }

    return className
  }
}
