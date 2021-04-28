//
//  WeekCategoryView.swift
//  toonitooni
//
//  Created by buzz on 2021/04/28.
//

import UIKit

class WeekCategoryView: BaseCustomView {

  // MARK: - Constant

  private enum Metric {
    static let categoryViewInset: CGFloat = 16
    static let itemSpacing: CGFloat = 16
    static let itemSize: CGFloat = 48
  }

  // MARK: - UI Properties

  @IBOutlet var collectionView: UICollectionView!

  // MARK: - Properties

  let categoryItems: [String] = ["전체", "N", "K"]

  // MARK: - Life cycle

  override func awakeFromNib() {
    super.awakeFromNib()
    setupUI()
  }

  // MARK: - Setup

  private func setupUI() {
    setupCollectionView()
  }

  private func setupCollectionView() {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .horizontal
    flowLayout.minimumLineSpacing = Metric.itemSpacing
    flowLayout.minimumInteritemSpacing = .zero
    flowLayout.sectionInset = UIEdgeInsets(top: 0, left: Metric.categoryViewInset, bottom: 0, right: Metric.categoryViewInset)
    flowLayout.itemSize = CGSize(width: Metric.itemSize, height: Metric.itemSize)

    collectionView.collectionViewLayout = flowLayout
    collectionView.showsVerticalScrollIndicator = false
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.backgroundColor = .white
    collectionView.dataSource = self
    collectionView.delegate = self

    let categoryItemCell = UINib(nibName: WeekCategoryItemCell.reuseIdentifier, bundle: nil)
    collectionView.register(
      categoryItemCell,
      forCellWithReuseIdentifier: WeekCategoryItemCell.reuseIdentifier
    )
  }
}

// MARK: - CollectionView datasource

extension WeekCategoryView: UICollectionViewDataSource {

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return categoryItems.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekCategoryItemCell.reuseIdentifier, for: indexPath) as? WeekCategoryItemCell else {
      return UICollectionViewCell()
    }

    let item = categoryItems[indexPath.item]
    cell.bind(item)

    return cell
  }
}

// MARK: - CollectionView delegate

extension WeekCategoryView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {}
