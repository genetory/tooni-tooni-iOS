//
//  GeneralHelper.swift
//  toonitooni
//
//  Created by buzz on 2021/04/26.
//

import UIKit

class GeneralHelper {

  // MARK: - Vars

  static let sharedInstance = GeneralHelper()

  var tabList: [TabItem] = []

  // MARK: - Life Cycle

  func setup() {
    initTabList()
    FirebaseService.shared.configure()
  }
}

// MARK: - Tab

extension GeneralHelper {

  func initTabList() {
    let homeItem = TabItem(storyBoard: "Home",
                           viewController: "HomeViewController",
                           title: "홈",
                           type: .home)
    let weekdayItem = TabItem(storyBoard: "Week",
                              viewController: "WeekViewController",
                              title: "요일별",
                              type: .weekday)
    let favoriteItem = TabItem(storyBoard: "Favorite",
                               viewController: "FavoriteViewController",
                               title: "즐겨찾기",
                               type: .favorite)
    let settingsItem = TabItem(storyBoard: "Settings",
                               viewController: "SettingsViewController",
                               title: "설정",
                               type: .settings)

    tabList = [homeItem, weekdayItem, favoriteItem, settingsItem]
  }
}

// MARK: - Make ViewController

extension GeneralHelper {

  func makeVC(_ storyBoard: String, _ viewController: String) -> BaseViewController {
    let sb = UIStoryboard(name: storyBoard, bundle: nil)
    let vc = sb.instantiateViewController(withIdentifier: viewController) as! BaseViewController

    return vc
  }

  func makeTabBarViewController(_ storyBoard: String, _ viewController: String) -> UITabBarController {
    let sb: UIStoryboard = UIStoryboard(name: storyBoard, bundle: nil)
    let vc: BaseTabBarViewController = sb.instantiateViewController(withIdentifier: viewController) as! BaseTabBarViewController

    return vc
  }
}
