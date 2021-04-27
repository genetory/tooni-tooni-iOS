//
//  ViewController.swift
//  TooniTooni
//
//  Created by GENETORY on 2021/04/12.
//

import UIKit

protocol HomeViewSectionTitle {
    var title: String? { get }
}

enum HomeViewType: Int, HomeViewSectionTitle {
    case notice
    case new
    case webtoon
    case popular
    case genre
    case author
    
    var title: String? {
        switch self {
        case .notice:
            return nil
        case .new:
            return nil
        case .webtoon:
            return "🔥불금 추천 웹툰🔥"
        case .popular:
            return "인기 급상승 투니"
        case .genre:
            return "장르별 TOP"
        case .author:
            return "작가 추천"
        }
    }
    
    static let count = 6
}

class HomeViewController: BaseViewController {

    // MARK: - Vars
    
    @IBOutlet weak var navigationView: GeneralNavigationView!
    @IBOutlet weak var mainTableView: UITableView!
    
    var popularList: [WebtoonItem] = []
    var genreList: [WebtoonItem] = []
    
    // MARK: - Life Cycle
    
    func initVars() {
        self.showBigTitle = false

        self.popularList = Array(GeneralHelper.sharedInstance.webtoonList[0..<4])
        self.genreList = Array(GeneralHelper.sharedInstance.webtoonList[0..<3])
    }
    
    func initBackgroundView() {
        self.view.backgroundColor = .white
    }
    
    func initNavigationView() {
        self.navigationView.title("TOONITOONI")
        self.navigationView.bigTitle(self.showBigTitle)
        
        self.navigationView.rightButton.isHidden = false
        self.navigationView.rightButton.setImage(UIImage.init(named: "icon_search"), for: .normal)
        self.navigationView.rightButton.addTarget(self, action: #selector(doSearch), for: .touchUpInside)
    }
    
    func initTableView() {
        let headerView = UINib.init(nibName: kGeneralTitleHeaderViewID, bundle: nil)
        self.mainTableView.register(headerView, forHeaderFooterViewReuseIdentifier: kGeneralTitleHeaderViewID)
        
        let noticeCell = UINib.init(nibName: kHomeNoticeCellID, bundle: nil)
        self.mainTableView.register(noticeCell, forCellReuseIdentifier: kHomeNoticeCellID)
        
        let newCell = UINib.init(nibName: kHomeNewListCellID, bundle: nil)
        self.mainTableView.register(newCell, forCellReuseIdentifier: kHomeNewListCellID)
        
        let webtoonCell = UINib.init(nibName: kHomeWebtoonListCellID, bundle: nil)
        self.mainTableView.register(webtoonCell, forCellReuseIdentifier: kHomeWebtoonListCellID)
        
        let popularCell = UINib.init(nibName: kHomePopularCellID, bundle: nil)
        self.mainTableView.register(popularCell, forCellReuseIdentifier: kHomePopularCellID)
        
        let genreCell = UINib.init(nibName: kHomeGenreCellID, bundle: nil)
        self.mainTableView.register(genreCell, forCellReuseIdentifier: kHomeGenreCellID)
        
        let authorCell = UINib.init(nibName: kHomeAuthorListCellID, bundle: nil)
        self.mainTableView.register(authorCell, forCellReuseIdentifier: kHomeAuthorListCellID)
        
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        self.mainTableView.separatorStyle = .none
        self.mainTableView.backgroundColor = .white
        self.mainTableView.rowHeight = UITableView.automaticDimension
        self.mainTableView.estimatedRowHeight = 200.0
        self.mainTableView.sectionHeaderHeight = UITableView.automaticDimension
        self.mainTableView.estimatedSectionHeaderHeight = 44.0
        self.mainTableView.contentInset = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        self.mainTableView.showsVerticalScrollIndicator = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.initVars()
        self.initBackgroundView()
        self.initNavigationView()
        self.initTableView()
    }

}

// MARK: - Event

extension HomeViewController {
    
    @objc
    func doSearch() {
        self.showReadyAlert(vc: self)
    }
    
}

// MARK: - UITableView

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return HomeViewType.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == HomeViewType.popular.rawValue {
            return self.popularList.count
        }
        else if section == HomeViewType.genre.rawValue {
            return self.genreList.count
        }

        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: kGeneralTitleHeaderViewID) as? GeneralTitleHeaderView,
           let title = HomeViewType.init(rawValue: section)?.title {
            headerView.bind(title)
            
            return headerView
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let _ = HomeViewType.init(rawValue: section)?.title {
            return UITableView.automaticDimension
        }
        
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == HomeViewType.notice.rawValue,
           let cell = tableView.dequeueReusableCell(withIdentifier: kHomeNoticeCellID, for: indexPath) as? HomeNoticeCell {
            
            return cell
        }
        else if indexPath.section == HomeViewType.new.rawValue,
                let cell = tableView.dequeueReusableCell(withIdentifier: kHomeNewListCellID, for: indexPath) as? HomeNewListCell {
            let webtoonList = Array(GeneralHelper.sharedInstance.webtoonList[0...3])
            cell.bind(webtoonList)
            
            return cell
        }
        else if indexPath.section == HomeViewType.webtoon.rawValue,
                let cell = tableView.dequeueReusableCell(withIdentifier: kHomeWebtoonListCellID, for: indexPath) as? HomeWebtoonListCell {
            let webtoonList = Array(GeneralHelper.sharedInstance.webtoonList[0...5])
            cell.bind(webtoonList)
            
            return cell
        }
        else if indexPath.section == HomeViewType.popular.rawValue,
                let cell = tableView.dequeueReusableCell(withIdentifier: kHomePopularCellID, for: indexPath) as? HomePopularCell {
            let webtoonItem = self.popularList[indexPath.row]
            cell.bind(webtoonItem)
            
            return cell
        }
        else if indexPath.section == HomeViewType.genre.rawValue,
                let cell = tableView.dequeueReusableCell(withIdentifier: kHomeGenreCellID, for: indexPath) as? HomeGenreCell {
            let webtoonItem = self.genreList[indexPath.row]
            cell.bind(webtoonItem)
            
            return cell
        }
        else if indexPath.section == HomeViewType.author.rawValue,
                let cell = tableView.dequeueReusableCell(withIdentifier: kHomeAuthorListCellID, for: indexPath) as? HomeAuthorListCell {
            let authorList = Array(GeneralHelper.sharedInstance.authorList[0..<5])
            cell.bind(authorList)
            
            return cell
        }

        return .init()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}
