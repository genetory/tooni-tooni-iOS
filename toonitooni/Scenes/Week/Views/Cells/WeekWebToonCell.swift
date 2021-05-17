//
//  WeekWebToonCell.swift
//  toonitooni
//
//  Created by buzz on 2021/04/28.
//

import UIKit
import Kingfisher

class WeekWebToonCell: UICollectionViewCell {

  // MARK: - UI Properties

  @IBOutlet weak var thumbnailImageView: UIImageView!
  @IBOutlet weak var platformImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var authorLabel: UILabel!

  // MARK: - Life cycle

  override func awakeFromNib() {
    super.awakeFromNib()
    setupUI()
  }

  // MARK: - Setup

  private func setupUI() {
    titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    authorLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
  }
}

// MARK: - Helper methods

extension WeekWebToonCell {

  func bind(_ item: WebToon) {
    thumbnailImageView.backgroundColor = .lightGray
    titleLabel.text = item.title
    authorLabel.text = item.author.map { $0 }.joined(separator: " / ")
    thumbnailImageView.kf.setImage(with: URL(string: item.thumbnail))
  }
}
