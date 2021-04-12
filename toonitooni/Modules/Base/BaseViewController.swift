//
//  BaseViewController.swift
//  toonitooni
//
//  Created by buzz on 2021/04/12.
//

import UIKit

class BaseViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }

  func setupUI() {
  }

  deinit {
    print("\(type(of: self)): Deinited")
  }
}
