//
//  BaseTabBarViewController.swift
//  toonitooni
//
//  Created by buzz on 2021/04/25.
//

import AVKit
import UIKit

class BaseTabBarViewController: UITabBarController {

  // MARK: - Vars

  // MARK: - Life Cycle

  func initVars() {
    navigationController?.setNavigationBarHidden(true, animated: false)
  }

  func initNavigationView() {
    navigationController?.setNavigationBarHidden(true, animated: false)
  }

  func initTabBar() {
    UITabBar.appearance().tintColor = .darkGray
    UITabBar.appearance().backgroundImage = UIImage.imageFromColor(.white)
    UITabBar.appearance().shadowImage = UIImage.imageFromColor(UIColor(white: 0.9, alpha: 1.0))
    UITabBar.appearance().selectionIndicatorImage = UIImage.imageFromColor(.clear)

    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font:UIFont.systemFont(ofSize: 9.0)], for: .normal)
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.darkGray, NSAttributedString.Key.font:UIFont.systemFont(ofSize: 9.0)], for: .disabled)
    UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.darkGray, NSAttributedString.Key.font:UIFont.systemFont(ofSize: 9.0)], for: .selected)

    if let tabBarItems = tabBar.items {
      GeneralHelper.sharedInstance.tabList.enumerated().forEach { index, item in
        tabBarItem.tag = index

        let tabBarItem = tabBarItems[index]
        tabBarItem.title = item.title
        tabBarItem.tag = index
      }
    }
  }

  func initViewControllers() {
    viewControllers = GeneralHelper.sharedInstance.tabList
      .map { navigationController(tabItem: $0) }
  }

  private func navigationController(tabItem: TabItem) -> UINavigationController {
    let vc = GeneralHelper.sharedInstance.makeVC(tabItem.storyBoard, tabItem.viewController)
    vc.tabItem = tabItem

    return UINavigationController(rootViewController: vc)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    initVars()
    initViewControllers()
    initTabBar()
  }
}
