//
//  WeekMenuBarItemCell.swift
//  toonitooni
//
//  Created by buzz on 2021/04/28.
//

import UIKit

class WeekMenuBarItemCell: UICollectionViewCell {

  // MARK: - UI Properties

  @IBOutlet weak var titleLabel: UILabel!

  // MARK: - Properties

  override var isSelected: Bool {
    didSet {
      titleLabel.textColor = isSelected ? .black : .lightGray
    }
  }

  // MARK: - Life cycle

  override func awakeFromNib() {
    super.awakeFromNib()
    setupUI()
  }

  // MARK: - Setup

  private func setupUI() {
    // titleLabel
    titleLabel.text = nil
    titleLabel.textAlignment = .center
    titleLabel.textColor = .lightGray
  }
}

// MARK: - Helper methods

extension WeekMenuBarItemCell {

  func bind(_ item: String?) {
    titleLabel.text = item
  }
}
