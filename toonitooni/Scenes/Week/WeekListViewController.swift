//
//  WeekListViewController.swift
//  toonitooni
//
//  Created by buzz on 2021/05/20.
//

import UIKit

class WeekListViewController: BaseViewController {

  // MARK: - UI Properties

  lazy var contentCollectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .horizontal
    flowLayout.minimumInteritemSpacing = .zero
    flowLayout.minimumLineSpacing = .zero

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    collectionView.showsVerticalScrollIndicator = false
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.isPagingEnabled = true
    collectionView.backgroundColor = .white
    collectionView.dataSource = self
    collectionView.delegate = self
    return collectionView
  }()

  // MARK: - Properties

  var currentWeekDayIndex: Int = 0

  var weekWebtoon: WeekWebtoon? {
    didSet { reloadData() }
  }

  // MARK: - Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }

  // MARK: - Setup

  func setupUI() {
    view.backgroundColor = .white
    view.addSubview(contentCollectionView)
    setupContentCollectionView()
  }

  func setupContentCollectionView() {
    contentCollectionView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      contentCollectionView.topAnchor.constraint(equalTo: view.topAnchor),
      contentCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      contentCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      contentCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])

    let weekWebToonListCell = UINib(nibName: WeekWebToonListCell.reuseIdentifier, bundle: nil)
    contentCollectionView.register(weekWebToonListCell, forCellWithReuseIdentifier: WeekWebToonListCell.reuseIdentifier)
  }
}

// MARK: - Helper methods

extension WeekListViewController {

  private func selectCurrentWeekDay() {
    let indexPath = IndexPath(item: WeekMenuBarItem.currentWeekDay, section: 0)
    contentCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: .centeredHorizontally)

    fetchWeekWebtoon()
  }

  func scrollToMenuItem(at indexPath: IndexPath) {
    contentCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
  }

  func fetchWeekWebtoon() {
    weekWebtoon = nil

    TooniNetworkService.shared.request(
      to: .weekWebtoon(WeekMenuBarItem.transformShort(by: currentWeekDayIndex)),
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

extension WeekListViewController: UICollectionViewDataSource {

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekWebToonListCell.reuseIdentifier, for: indexPath) as? WeekWebToonListCell else {
      return UICollectionViewCell()
    }

    if let webtoons = weekWebtoon?.webtoons {
      cell.bind(webtoons)
    }

    return cell
  }
}

// MARK: - CollectionView delegate

extension WeekListViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
  }
}

