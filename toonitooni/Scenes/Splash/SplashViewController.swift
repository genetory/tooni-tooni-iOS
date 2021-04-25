//
//  SplashViewController.swift
//  toonitooni
//
//  Created by buzz on 2021/04/26.
//

import UIKit

class SplashViewController: BaseViewController {

  // MARK: - Vars

  // MARK: - Life Cycle

  func initBackgroundView() {
    view.backgroundColor = .white
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    initBackgroundView()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    startApp()
  }
}

// MARK: - Start

extension SplashViewController {

  func startApp() {
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let sceneDelegate = windowScene.delegate as? SceneDelegate
    else {
      return
    }

    sceneDelegate.createTabVC()
  }
}
