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
    static let categoryViewInset: CGFloat = 20
    static let itemSpacing: CGFloat = 8
    static let itemSize: CGFloat = 40
  }

  // MARK: - UI Properties

  @IBOutlet var collectionView: UICollectionView!

  // MARK: - Properties

  let categoryItems: [String] = ["All", "N", "K"]
  var didSelectCategoryItem: ((WeekCategoryView, IndexPath) -> Void)?

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
    flowLayout.minimumInteritemSpacing = Metric.itemSpacing
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

// MARK: - Helper methods

extension WeekCategoryView {

  func selectCategoryItem(at indexPath: IndexPath) {
    collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
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

extension WeekCategoryView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    selectCategoryItem(at: indexPath)
    didSelectCategoryItem?(self, indexPath)
  }
}
