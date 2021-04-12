//
//  AppDelegate+Setup.swift
//  toonitooni
//
//  Created by buzz on 2021/04/13.
//

import Foundation
import UIKit

extension AppDelegate {

  func setup(application: UIApplication,
             launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
    Application.shared.globalConfigure()
  }
}
