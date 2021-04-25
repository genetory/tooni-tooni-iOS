//
//  GeneralNavigationView.swift
//  toonitooni
//
//  Created by buzz on 2021/04/25.
//

import UIKit

class GeneralNavigationView: UIView {

  // MARK: - Vars

  @IBOutlet var baseView: UIView!
  @IBOutlet var topView: UIView!
  @IBOutlet var leftButton: UIButton!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var subButton: UIButton!
  @IBOutlet var rightButton: UIButton!
  @IBOutlet var bigTitleLabel: UILabel!

  // MARK: - Life Cycle

  func initVars() {
    clipsToBounds = true
  }

  func initBackgroundView() {
    baseView.backgroundColor = .clear
  }

  func initButtons() {
    leftButton.isHidden = true
    subButton.isHidden = true
    rightButton.isHidden = true
  }

  func initLabels() {
    titleLabel.font = UIFont.systemFont(ofSize: 16.0, weight: UIFont.Weight.bold)
    titleLabel.textColor = .black
    titleLabel.textAlignment = .center
    titleLabel.text = nil

    bigTitleLabel.font = UIFont.systemFont(ofSize: 26.0, weight: UIFont.Weight.heavy)
    bigTitleLabel.textColor = .black
    bigTitleLabel.text = nil
  }

  override func awakeFromNib() {
    super.awakeFromNib()

    initVars()
    initBackgroundView()
    initButtons()
    initLabels()
  }
}

// MARK: -

extension GeneralNavigationView {

  func title(_ title: String?) {
    titleLabel.text = title
    bigTitleLabel.text = title
  }

  func bgColor(_ color: UIColor) {
    topView.backgroundColor = color
    baseView.backgroundColor = color
  }

  func bigTitle(_ bigTitle: Bool) {
    titleLabel.alpha = bigTitle ? 0.0 : 1.0
    bigTitleLabel.alpha = bigTitle ? 1.0 : 0.0
  }
}
