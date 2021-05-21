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
    static let categorySize: CGFloat = 40
  }

  // MARK: - UI Properties

  @IBOutlet weak var categoryLabel: UILabel!

  // MARK: - Properties

  override var isSelected: Bool {
    didSet {
      categoryLabel.backgroundColor = isSelected ? Theme.color.blue : Theme.color.white
      categoryLabel.textColor = isSelected ? Theme.color.gray90 : Theme.color.gray50
      categoryLabel.layer.borderWidth = isSelected ? 0 : 1
    }
  }

  // MARK: - Life cycle

  override func awakeFromNib() {
    super.awakeFromNib()
    setupUI()
  }

  // MARK: - Setup

  private func setupUI() {
    // category label
    categoryLabel.text = nil
    categoryLabel.textColor = Theme.color.gray50
    categoryLabel.textAlignment = .center
    categoryLabel.font = Theme.font.body2Medium
    categoryLabel.backgroundColor = Theme.color.white
    categoryLabel.layer.cornerRadius = Metric.categorySize / 2
    categoryLabel.layer.masksToBounds = true
    categoryLabel.layer.borderWidth = 1
    categoryLabel.layer.borderColor = Theme.color.gray50.cgColor
  }
}

// MARK: - Helper methods

extension WeekCategoryItemCell {

  func bind(_ item: String?) {
    categoryLabel.text = item
  }
}
