//
//  WeekViewController.swift
//  toonitooni
//
//  Created by buzz on 2021/04/26.
//

import UIKit
import Moya

class WeekViewController: BaseViewController {

  // MARK: - UI Properties

  @IBOutlet weak var navigationView: GeneralNavigationView!
  @IBOutlet weak var weekMenuBarView: WeekMenuBarView!
  @IBOutlet weak var weekCategoryView: WeekCategoryView!
  @IBOutlet weak var contentCollectionView: UICollectionView!

  // MARK: - Properties

  var weekWebtoon = WeekWebtoon() {
    didSet { reloadData() }
  }

  // MARK: - Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    didSelectWeekMenuBarItem()

    for familyName in UIFont.familyNames {
        print("\n-- \(familyName) \n")
        for fontName in UIFont.fontNames(forFamilyName: familyName) {
            print(fontName)
        }
    }
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    selectCurrentWeekDay()
  }

  // MARK: - Setup

  func setupUI() {
    view.backgroundColor = .white
    setupNavigationView()
    setupContentCollectionView()
  }

  func setupNavigationView() {
    navigationView.title(tabItem?.title)
    navigationView.bigTitle(false)
  }

  func setupContentCollectionView() {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .horizontal
    flowLayout.minimumInteritemSpacing = .zero
    flowLayout.minimumLineSpacing = .zero
    flowLayout.itemSize = CGSize(width: view.frame.width, height: contentCollectionView.frame.height)

    contentCollectionView.collectionViewLayout = flowLayout
    contentCollectionView.showsVerticalScrollIndicator = false
    contentCollectionView.showsHorizontalScrollIndicator = false
    contentCollectionView.isPagingEnabled = true
    contentCollectionView.backgroundColor = .white
    contentCollectionView.dataSource = self
    contentCollectionView.delegate = self

    let weekWebToonListCell = UINib(nibName: WeekWebToonListCell.reuseIdentifier, bundle: nil)
    contentCollectionView.register(
      weekWebToonListCell,
      forCellWithReuseIdentifier: WeekWebToonListCell.reuseIdentifier
    )
  }
}

// MARK: - Handler

extension WeekViewController {

  private func didSelectWeekMenuBarItem() {
    weekMenuBarView.didSelectWeekMenuBarItem = { [weak self] menuBar, indexPath in
      self?.contentCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
      self?.fetchWeekWebtoon(at: indexPath.row)
    }
  }
}

// MARK: - Helper methods

extension WeekViewController {

  private func selectCurrentWeekDay() {
    let indexPath = IndexPath(item: WeekMenuBarItem.currentWeekDay, section: 0)
    contentCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredHorizontally)
    fetchWeekWebtoon(at: indexPath.row)
  }

  private func fetchWeekWebtoon(at index: Int) {
    TooniNetworkService.shared.request(
      to: .weekWebtoon(WeekMenuBarItem.transformShort(by: index)),
      decoder: WeekWebtoon.self
    ) { [weak self] response in
      switch response.result {
      case .success:
        guard let weekWebtoon = response.json as? WeekWebtoon else { return }
        self?.weekWebtoon = weekWebtoon
      case .failure:
        print(response)
      }
    }
  }

  private func reloadData() {
    DispatchQueue.main.async {
      self.contentCollectionView.reloadData()
    }
  }
}

// MARK: - CollectionView datasource

extension WeekViewController: UICollectionViewDataSource {

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return WeekMenuBarItem.total.rawValue
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekWebToonListCell.reuseIdentifier, for: indexPath) as? WeekWebToonListCell else {
      return UICollectionViewCell()
    }

    cell.bind(weekWebtoon.webtoons)

    return cell
  }
}

// MARK: - CollectionView delegate

extension WeekViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
  }

  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let position = Int(scrollView.contentOffset.x / view.frame.width)
    let indexPath = IndexPath(item: position, section: 0)

    weekMenuBarView.selectMenuBarItem(at: indexPath)
  }
}
