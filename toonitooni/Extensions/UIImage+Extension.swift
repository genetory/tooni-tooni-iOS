//
//  UIImage+Extension.swift
//  toonitooni
//
//  Created by buzz on 2021/04/25.
//

import UIKit

extension UIImage {

  class func imageFromColor(_ color: UIColor, width: CGFloat = 1.0, height: CGFloat = 1.0) -> UIImage? {
    var image: UIImage?

    let rect = CGRect(origin: CGPoint.zero, size: CGSize(width: width, height: height))

    UIGraphicsBeginImageContext(rect.size)
    if let context: CGContext = UIGraphicsGetCurrentContext() {
      context.setFillColor(color.cgColor)
      context.fill(rect)

      image = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
    }

    return image
  }
}
