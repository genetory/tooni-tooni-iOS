//
//  WeekWebToonListCell.swift
//  toonitooni
//
//  Created by buzz on 2021/04/28.
//

import UIKit

class WeekWebToonListCell: UICollectionViewCell {

  // MARK: - Constant

  private enum Metric {
    static let listInset: CGFloat = 16
    static let listSpacing: CGFloat = 8
    static let itemCount: CGFloat = 3
    static let itemHeight: CGFloat = 160
    static let itemWidth: CGFloat = (kDEVICE_WIDTH / itemCount) - (listSpacing * 2)
  }

  // MARK: - UI Properties

  @IBOutlet var listCollectionView: UICollectionView!

  // MARK: - Properties

  var webToons: [WebToon] = [] {
    didSet {
      listCollectionView.reloadData()
    }
  }

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
    flowLayout.scrollDirection = .vertical
    flowLayout.minimumLineSpacing = Metric.listSpacing
    flowLayout.minimumInteritemSpacing = Metric.listSpacing
    flowLayout.sectionInset = UIEdgeInsets(top: Metric.listSpacing, left: Metric.listInset, bottom: Metric.listSpacing, right: Metric.listInset)

    listCollectionView.collectionViewLayout = flowLayout
    listCollectionView.showsVerticalScrollIndicator = false
    listCollectionView.showsHorizontalScrollIndicator = false
    listCollectionView.dataSource = self
    listCollectionView.delegate = self

    let weekWebToonCell = UINib(nibName: WeekWebToonCell.reuseIdentifier, bundle: nil)
    listCollectionView.register(
      weekWebToonCell,
      forCellWithReuseIdentifier: WeekWebToonCell.reuseIdentifier
    )
  }
}

// MARK: - Helper methods

extension WeekWebToonListCell {

  func bind(_ items: [WebToon]) {
    webToons = items
  }
}

// MARK: - CollectionView datasource

extension WeekWebToonListCell: UICollectionViewDataSource {

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return webToons.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekWebToonCell.reuseIdentifier, for: indexPath) as? WeekWebToonCell else {
      return UICollectionViewCell()
    }

    let webToon = webToons[indexPath.item]
    cell.bind(webToon)

    return cell
  }
}

// MARK: - CollectionView delegate

extension WeekWebToonListCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: Metric.itemWidth, height: Metric.itemHeight)
  }
}
