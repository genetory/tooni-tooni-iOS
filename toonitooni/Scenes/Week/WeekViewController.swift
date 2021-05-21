//
//  WeekViewController.swift
//  toonitooni
//
//  Created by buzz on 2021/04/26.
//

import UIKit

class WeekViewController: BaseViewController {

  // MARK: - UI Properties

  @IBOutlet var navigationView: GeneralNavigationView!
  @IBOutlet var weekMenuBarView: WeekMenuBarView!
  @IBOutlet var weekCategoryView: WeekCategoryView!
  @IBOutlet var contentView: UIView!
  var pageViewController: UIPageViewController!

  // MARK: - Properties

  var currentSelectedIndex = WeekMenuBarItem.currentWeekDay
  var weekListViewControllers = WeekMenuBarItem.allCases.map { _ in
    GeneralHelper.sharedInstance.makeVC("Week", "WeekListViewController")
  }

  // MARK: - Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    bind()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    selectCurrentWeekDay()
  }

  // MARK: - Setup

  func setupUI() {
    view.backgroundColor = .white
    setupNavigationView()
    setupPageViewController()
  }

  func setupNavigationView() {
    navigationView.title(tabItem?.title)
    navigationView.bigTitle(false)
  }

  func setupPageViewController() {
    pageViewController = GeneralHelper.sharedInstance.makePageVC("Week", "WeekPageViewController")
    pageViewController.delegate = self
    pageViewController.dataSource = self

    let currentViewController = weekListViewController(at: currentSelectedIndex)
    pageViewController.setViewControllers(
      [currentViewController], direction: .forward, animated: true, completion: nil
    )

    pageViewController.view.frame = contentView.bounds
    addChild(pageViewController)
    contentView.addSubview(pageViewController.view)
  }
}

// MARK: - PageViewController

extension WeekViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {

  func pageViewController(
    _ pageViewController: UIPageViewController,
    viewControllerBefore viewController: UIViewController
  ) -> UIViewController? {
    guard let index = weekListViewControllers.firstIndex(of: viewController as! BaseViewController) else { return nil }
    let previousIndex = index - 1

    if previousIndex < 0 {
      return nil
    }

    return weekListViewController(at: previousIndex)
  }

  func pageViewController(
    _ pageViewController: UIPageViewController,
    viewControllerAfter viewController: UIViewController
  ) -> UIViewController? {
    guard let index = weekListViewControllers.firstIndex(of: viewController as! BaseViewController) else { return nil }

    let nextIndex = index + 1
    if nextIndex == weekListViewControllers.count {
      return nil
    }

    return weekListViewController(at: nextIndex)
  }

  func pageViewController(
    _ pageViewController: UIPageViewController,
    didFinishAnimating finished: Bool,
    previousViewControllers: [UIViewController],
    transitionCompleted completed: Bool
  ) {
    if completed {
      if let firstVC = self.pageViewController.viewControllers?.first as? BaseViewController {
        if let index = weekListViewControllers.firstIndex(of: firstVC) {
          currentSelectedIndex = index
          weekMenuBarView.selectMenuBarItem(at: IndexPath(row: index, section: 0))
          weekListViewController(at: index).fetchWeekWebtoon()
        }
      }
    }
  }
}

// MARK: - binding

extension WeekViewController {

  private func bind() {
    didSelectWeekMenuBarItem()
    didSelectCategoryItem()
  }

  private func didSelectWeekMenuBarItem() {
    weekMenuBarView.didSelectWeekMenuBarItem = { [weak self] menuBar, indexPath in
      guard let self = self else { return }

      let index = indexPath.row
      guard self.currentSelectedIndex != index else { return }

      let weekListViewController = self.weekListViewController(at: index)

      var direction: UIPageViewController.NavigationDirection = .forward
      if index < self.currentSelectedIndex {
        direction = .reverse
      }

      self.currentSelectedIndex = index

      self.pageViewController.setViewControllers([weekListViewController as BaseViewController], direction: direction, animated: true, completion: nil)

      weekListViewController.fetchWeekWebtoon()
    }
  }

  private func didSelectCategoryItem() {
    weekCategoryView.didSelectCategoryItem = { [weak self] categoryView, indexPath in
      print(indexPath)
    }
  }
}

// MARK: - Helper methods

extension WeekViewController {

  private func selectCurrentWeekDay() {
    let indexPath = IndexPath(item: WeekMenuBarItem.currentWeekDay, section: 0)
    let weekListViewController = weekListViewControllers[WeekMenuBarItem.currentWeekDay] as! WeekListViewController
    weekListViewController.scrollToMenuItem(at: indexPath)
    weekListViewController.fetchWeekWebtoon()
  }

  private func weekListViewController(at index: Int) -> WeekListViewController {
    let weekListViewController = weekListViewControllers[index] as! WeekListViewController
    weekListViewController.currentWeekDayIndex = index

    return weekListViewController
  }
}
