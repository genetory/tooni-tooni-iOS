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

  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var menuUnderLineView: UIView!
  @IBOutlet weak var menuUnderLineViewWidthConstraint: NSLayoutConstraint!
  @IBOutlet weak var menuUnderLineViewLeadingConstraint: NSLayoutConstraint!

  // MARK: - Properties

  var selectedIndexPath = IndexPath(item: WeekMenuBarItem.currentWeekDay, section: 0)
  var didSelectWeekMenuBarItem: ((WeekMenuBarView, IndexPath) -> Void)?

  // MARK: - Life cycle

  override func awakeFromNib() {
    super.awakeFromNib()
    setupUI()
  }

  // MARK: - Setup

  private func setupUI() {
    backgroundColor = .white
    setupCollectionView()
    setupMenuUnderLineView()
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

  private func setupMenuUnderLineView() {
    menuUnderLineView.backgroundColor = .lightGray
    menuUnderLineViewWidthConstraint.constant = Metric.menuBarWidth
    menuUnderLineViewLeadingConstraint.constant = Metric.menuBarInset

    selectMenuBarItem(at: selectedIndexPath)
  }
}

// MARK: - Helper methods

extension WeekMenuBarView {

  private func menuUnderLineViewMove(at indexPath: IndexPath) {
    selectedIndexPath = indexPath
    menuUnderLineViewLeadingConstraint.constant = (Metric.menuBarWidth * CGFloat(indexPath.item)) + Metric.menuBarInset

    UIView.animate(withDuration: 0.33) {
      self.layoutIfNeeded()
    }
  }

  func selectMenuBarItem(at indexPath: IndexPath) {
    menuUnderLineViewMove(at: indexPath)
    collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
  }
}

// MARK: - CollectionView datasource

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

// MARK: - CollectionView delegate

extension WeekMenuBarView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    menuUnderLineViewMove(at: indexPath)
    didSelectWeekMenuBarItem?(self, indexPath)
  }
}
