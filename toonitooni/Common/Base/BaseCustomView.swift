//
//  BaseCustomView.swift
//  toonitooni
//
//  Created by buzz on 2021/04/26.
//

import UIKit

class BaseCustomView: UIView {

  // MARK: - Vars

  var containerView: UIView!

  // MARK: - Life Cycle

  convenience init() {
    self.init(frame: CGRect.zero)
  }

  override init(frame: CGRect) {
    super.init(frame: frame)

    commonInit()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    commonInit()
  }

  func commonInit() {
    containerView = Bundle.main.loadNibNamed(className, owner: self, options: nil)?.first as? UIView
    containerView.frame = bounds
    containerView.backgroundColor = .clear
    addSubview(containerView)
  }
}

extension NSObject {

  var className: String {
    return String(describing: type(of: self))
  }

  class var className: String {
    return String(describing: self)
  }
}
