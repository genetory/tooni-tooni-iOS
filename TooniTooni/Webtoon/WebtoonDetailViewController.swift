//
//  WebtoonDetailViewController.swift
//  TooniTooni
//
//  Created by GENETORY on 2021/05/29.
//

import UIKit

enum WebtoonDetailViewType: Int {
    case info
    case score
    case comments
    case recommend
    
    static let count = 4
}

class WebtoonDetailViewController: BaseViewController {
    
    // MARK: - Vars
    
    @IBOutlet weak var navigationView: GeneralNavigationView!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var activity: GeneralActivity!

    var webtoonItem: Webtoon!

    // MARK: - Life Cycle
    
    func initVars() {
        self.showBigTitle = true
    }
    
    func initBackgroundView() {
        self.view.backgroundColor = kWHITE
    }
    
    func initNavigationView() {
        self.navigationView.title(nil)
        self.navigationView.bigTitle(self.showBigTitle)
        
        self.navigationView.leftButton.isHidden = false
        self.navigationView.leftButton.setImage(UIImage.init(named: "icon_back"), for: .normal)
        self.navigationView.leftButton.addTarget(self, action: #selector(doBack), for: .touchUpInside)
    }

    func initTableView() {
        let headerView = UINib.init(nibName: kGeneralTitleHeaderViewID, bundle: nil)
        self.mainTableView.register(headerView, forHeaderFooterViewReuseIdentifier: kGeneralTitleHeaderViewID)

        let infoCell = UINib.init(nibName: kWebtoonDetailInfoCellID, bundle: nil)
        self.mainTableView.register(infoCell, forCellReuseIdentifier: kWebtoonDetailInfoCellID)
        
        let scoreCell = UINib.init(nibName: kWebtoonDetailScoreCellID, bundle: nil)
        self.mainTableView.register(scoreCell, forCellReuseIdentifier: kWebtoonDetailScoreCellID)

        let commentCell = UINib.init(nibName: kWebtoonDetailCommentCellID, bundle: nil)
        self.mainTableView.register(commentCell, forCellReuseIdentifier: kWebtoonDetailCommentCellID)

        let recommendCell = UINib.init(nibName: kHomeWebtoonListCellID, bundle: nil)
        self.mainTableView.register(recommendCell, forCellReuseIdentifier: kHomeWebtoonListCellID)
        
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        self.mainTableView.separatorStyle = .none
        self.mainTableView.backgroundColor = kWHITE
        self.mainTableView.rowHeight = UITableView.automaticDimension
        self.mainTableView.estimatedRowHeight = 200.0
        self.mainTableView.sectionHeaderHeight = UITableView.automaticDimension
        self.mainTableView.estimatedSectionHeaderHeight = 44.0
        self.mainTableView.contentInset = UIEdgeInsets.init(top: 16.0, left: 0.0, bottom: 16.0, right: 0.0)
        self.mainTableView.showsVerticalScrollIndicator = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initVars()
        self.initBackgroundView()
        self.initNavigationView()
        self.initTableView()
        
        self.startActivity()
        self.fetchWebtoonDetail()
    }
    
}

// MARK: - Week Webtoon

extension WebtoonDetailViewController {
    
    func fetchWebtoonDetail() {
        guard let webtoonId = self.webtoonItem.id?.string else { return }

        TooniNetworkService.shared.request(to: .webtoonDetail(webtoonId), decoder: Webtoon.self) { [weak self] response in
            switch response.result {
            case .success:
                guard let webtoon = (response.json as? Webtoon) else { return }
                
                self?.webtoonItem = webtoon
                
                DispatchQueue.main.async {
                    self?.stopActivity()
                    self?.mainTableView.reloadData()
                }
            case .failure:
                print(response)
            }
        }
    }
    
}

// MARK: - Event

extension WebtoonDetailViewController {
    
    @objc
    func doBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

// MARK: - UITableView

extension WebtoonDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return WebtoonDetailViewType.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case WebtoonDetailViewType.info.rawValue:
            return 1
        case WebtoonDetailViewType.score.rawValue:
            return 1
        case WebtoonDetailViewType.comments.rawValue:
            return 5
        case WebtoonDetailViewType.recommend.rawValue:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == WebtoonDetailViewType.comments.rawValue,
           let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: kGeneralTitleHeaderViewID) as? GeneralTitleHeaderView {
            headerView.bind("투니 베스트 댓글")
            
            return headerView
        }
        else if section == WebtoonDetailViewType.recommend.rawValue,
           let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: kGeneralTitleHeaderViewID) as? GeneralTitleHeaderView {
            headerView.bind("이런 투니는 어때요?")
            
            return headerView
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == WebtoonDetailViewType.comments.rawValue ||
            section == WebtoonDetailViewType.recommend.rawValue {
            return UITableView.automaticDimension
        }
        
        return .leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == WebtoonDetailViewType.comments.rawValue {
            let headerView = UIView()
            return headerView
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == WebtoonDetailViewType.comments.rawValue {
            return 16.0
        }
        
        return .leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == WebtoonDetailViewType.info.rawValue,
           let cell = tableView.dequeueReusableCell(withIdentifier: kWebtoonDetailInfoCellID, for: indexPath) as? WebtoonDetailInfoCell {
            cell.bind(self.webtoonItem)
            
            return cell
        }
        else if indexPath.section == WebtoonDetailViewType.score.rawValue,
                let cell = tableView.dequeueReusableCell(withIdentifier: kWebtoonDetailScoreCellID, for: indexPath) as? WebtoonDetailScoreCell {
            cell.bind(self.webtoonItem)
            
            return cell
        }
        else if indexPath.section == WebtoonDetailViewType.comments.rawValue,
                let cell = tableView.dequeueReusableCell(withIdentifier: kWebtoonDetailCommentCellID, for: indexPath) as? WebtoonDetailCommentCell {
            
            return cell
        }
        else if indexPath.section == WebtoonDetailViewType.recommend.rawValue,
                let cell = tableView.dequeueReusableCell(withIdentifier: kHomeWebtoonListCellID, for: indexPath) as? HomeWebtoonListCell {
            
            return cell
        }

        return .init()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}

// MARK: - Activity

extension WebtoonDetailViewController {
    
    func startActivity() {
        if self.activity.isAnimating() { return }
        self.activity.start()
    }
    
    func stopActivity() {
        if !self.activity.isAnimating() { return }
        self.activity.stop()
    }
    
}
