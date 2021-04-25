//
//  Constants.swift
//  toonitooni
//
//  Created by buzz on 2021/04/26.
//

import UIKit

// MARK: - Device

let kDEVICE_WIDTH: CGFloat =                        UIScreen.main.bounds.size.width
let kDEVICE_HEIGHT: CGFloat =                       UIScreen.main.bounds.size.height

let kDEVICE_TOP_AREA: CGFloat =                     UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0
let kDEVICE_BOTTOM_AREA: CGFloat =                  UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.safeAreaInsets.bottom ?? 0.0
