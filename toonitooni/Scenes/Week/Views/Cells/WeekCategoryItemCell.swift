//
//  WeekCategoryItemCell.swift
//  toonitooni
//
//  Created by buzz on 2021/04/28.
//

import UIKit

class WeekCategoryItemCell: UICollectionViewCell {

  // MARK: - Constant

  private enum Metric {
    static let categoryButtonSize: CGFloat = 48
  }

  // MARK: - UI Properties

  @IBOutlet weak var categoryButton: UIButton!

  // MARK: - Life cycle

  override func awakeFromNib() {
    super.awakeFromNib()
    setupUI()
  }

  // MARK: - Setup

  private func setupUI() {
    // category button
    categoryButton.setTitle(nil, for: .normal)
    categoryButton.setTitleColor(.white, for: .normal)
    categoryButton.backgroundColor = .lightGray
    categoryButton.layer.cornerRadius = Metric.categoryButtonSize / 2
    categoryButton.layer.masksToBounds = true
  }
}

// MARK: - Helper methods

extension WeekCategoryItemCell {

  func bind(_ item: String?) {
    categoryButton.setTitle(item, for: .normal)
  }
}
