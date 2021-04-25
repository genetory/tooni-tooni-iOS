//
//  WeekViewController.swift
//  toonitooni
//
//  Created by buzz on 2021/04/26.
//

import UIKit

class WeekViewController: BaseViewController {

  // MARK: - Vars

  @IBOutlet var navigationView: GeneralNavigationView!

  // MARK: - Life Cycle

  func initBackgroundView() {
    view.backgroundColor = .white
  }

  func initNavigationView() {
    navigationView.title(tabItem?.title)
    navigationView.bigTitle(showBigTitle)
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    initBackgroundView()
    initNavigationView()
  }
}
