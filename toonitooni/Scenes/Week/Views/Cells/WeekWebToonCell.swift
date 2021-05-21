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

  @IBOutlet weak var thumbnailContainerView: UIView!
  @IBOutlet weak var thumbnailImageView: UIImageView!
  @IBOutlet weak var statusView: UIView!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var commentCountLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var authorLabel: UILabel!

  // MARK: - Life cycle

  override func awakeFromNib() {
    super.awakeFromNib()
    setupUI()
  }

  // MARK: - Setup

  private func setupUI() {
    // thumbnail container
    thumbnailContainerView.backgroundColor = .clear
    thumbnailContainerView.layer.cornerRadius = 5
    thumbnailContainerView.layer.masksToBounds = true

    // thumbnail imageview
    thumbnailImageView.contentMode = .scaleAspectFill

    // title
    titleLabel.font = Theme.font.caption1Medium
    titleLabel.textColor = Theme.color.gray90

    //author
    authorLabel.font = Theme.font.caption2Regular
    authorLabel.textColor = Theme.color.gray50

    // status view
    statusView.backgroundColor = Theme.color.gray90
    statusView.alpha = 0.3

    // rating
    ratingLabel.font = Theme.font.caption2Bold
    ratingLabel.textColor = Theme.color.white
    ratingLabel.text = "0.0"

    // comment count
    commentCountLabel.font = Theme.font.caption3Regular
    commentCountLabel.textColor = Theme.color.white
    commentCountLabel.text = "(0)"
  }
}

// MARK: - Helper methods

extension WeekWebToonCell {

  func bind(_ item: WebToon) {
    thumbnailImageView.backgroundColor = Theme.color.gray30
    thumbnailImageView.kf.setImage(with: URL(string: item.thumbnail))
    titleLabel.text = item.title
    authorLabel.text = item.authors.map { $0.name }.joined(separator: " / ")
  }
}
