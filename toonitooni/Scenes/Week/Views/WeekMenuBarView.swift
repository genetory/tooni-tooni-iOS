//
//  WeekMenuBarView.swift
//  toonitooni
//
//  Created by buzz on 2021/04/28.
//

import UIKit

class WeekMenuBarView: BaseCustomView {

  // MARK: - Constant

  private enum Metric {
    static let menuBarInset: CGFloat = 16
    static let menuBarHeight: CGFloat = 46
    static let menuBarWidth: CGFloat = (kDEVICE_WIDTH - (menuBarInset * 2)) / CGFloat(WeekMenuBarItem.total.rawValue)
  }

  // MARK: - UI Properties

  @IBOutlet var collectionView: UICollectionView!

  // MARK: - Life cycle

  override func awakeFromNib() {
    super.awakeFromNib()
    setupUI()
  }

  // MARK: - Setup

  private func setupUI() {
    backgroundColor = .white
    setupCollectionView()
  }

  private func setupCollectionView() {
    
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .horizontal
    flowLayout.minimumLineSpacing = .zero
    flowLayout.minimumInteritemSpacing = .zero
    flowLayout.sectionInset = UIEdgeInsets(top: 0, left: Metric.menuBarInset, bottom: 0, right: Metric.menuBarInset)
    flowLayout.itemSize = CGSize(width: Metric.menuBarWidth, height: Metric.menuBarHeight)

    collectionView.collectionViewLayout = flowLayout
    collectionView.showsVerticalScrollIndicator = false
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.backgroundColor = .white
    collectionView.dataSource = self
    collectionView.delegate = self

    let menuBarItemCell = UINib(nibName: WeekMenuBarItemCell.reuseIdentifier, bundle: nil)
    collectionView.register(
      menuBarItemCell,
      forCellWithReuseIdentifier: WeekMenuBarItemCell.reuseIdentifier
    )
  }
}

extension WeekMenuBarView: UICollectionViewDataSource {

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return WeekMenuBarItem.total.rawValue
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekMenuBarItemCell.reuseIdentifier, for: indexPath) as? WeekMenuBarItemCell else {
      return UICollectionViewCell()
    }

    let title = WeekMenuBarItem(rawValue: indexPath.item)?.title
    cell.bind(title)

    return cell
  }
}

extension WeekMenuBarView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

  }
}
