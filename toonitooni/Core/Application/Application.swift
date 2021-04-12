//
//  Application.swift
//  toonitooni
//
//  Created by buzz on 2021/04/13.
//

import UIKit

final class Application: NSObject {

  /// singleton
  static let shared = Application()

  private override init() {

  }
}


extension Application {

  func globalConfigure() { }
}
