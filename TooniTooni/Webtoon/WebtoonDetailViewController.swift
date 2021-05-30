//
//  WebtoonDetailViewController.swift
//  TooniTooni
//
//  Created by GENETORY on 2021/05/29.
//

import UIKit
import SafariServices

enum WebtoonDetailViewType: Int {
    case info
    case score
    case comments
    case recommend
    
    static let count = 4
}

let kWEBTOON_DETAIL_HEADER_HEIGHT: CGFloat =                            252.0

class WebtoonDetailViewController: BaseViewController {
    
    // MARK: - Vars
    
    @IBOutlet weak var hideNavigationView: GeneralNavigationView!
    @IBOutlet weak var hideNavigationViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var hideNavigationViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerView: WebtoonDetailHeaderView!
    @IBOutlet weak var headerViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var portalView: UIView!
    @IBOutlet weak var portalButton: UIButton!
    @IBOutlet weak var portalLabel: UILabel!
    @IBOutlet weak var portalButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var portalButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var activity: GeneralActivity!

    var selectedIdx = 0
    var showHideNavigationView = false

    var webtoonItem: Webtoon!
    var webtoonDetailItem: WebtoonDetail!

    // MARK: - Life Cycle
    
    func initVars() {
        self.showBigTitle = false
    }
    
    func initBackgroundView() {
        self.view.backgroundColor = kWHITE
    }
    
    func initNavigationView() {
        self.hideNavigationView.bgColor(kWHITE)
        self.hideNavigationView.title(self.webtoonItem.title)
        self.hideNavigationView.bigTitle(false)
        self.hideNavigationView.leftButton(true)
        self.hideNavigationView.alpha = 0.0
        
        self.hideNavigationView.leftButton.isHidden = false
        self.hideNavigationView.leftButton.setImage(UIImage.init(named: "icon_back")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.hideNavigationView.leftButton.tintColor = kGRAY_90
        self.hideNavigationView.leftButton.addTarget(self, action: #selector(doBack), for: .touchUpInside)
        
        self.hideNavigationViewHeightConstraint.constant = 44.0 + kDEVICE_TOP_AREA
        self.hideNavigationViewTopConstraint.constant = -self.hideNavigationViewHeightConstraint.constant - kDEVICE_TOP_AREA
    }

    func initHeaderView() {
        self.headerView.bind(self.webtoonItem)
        self.headerView.delegate = self
        self.headerView.alpha = 0.0
        
        self.view.layoutIfNeeded()
        self.headerViewHeightConstraint.constant = kWEBTOON_DETAIL_HEADER_HEIGHT
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
        self.mainTableView.estimatedSectionHeaderHeight = 40.0
        self.mainTableView.sectionFooterHeight = UITableView.automaticDimension
        self.mainTableView.estimatedSectionFooterHeight = 16.0
        self.mainTableView.contentInset = UIEdgeInsets.init(top: kWEBTOON_DETAIL_HEADER_HEIGHT - kDEVICE_TOP_AREA - 24.0, left: 0.0, bottom: self.portalButtonBottomConstraint.constant + self.portalButtonHeightConstraint.constant + 16.0, right: 0.0)
        self.mainTableView.showsVerticalScrollIndicator = false
        self.mainTableView.alpha = 0.0
    }
    
    func initCommentView() {
        self.commentView.alpha = 0.0
    }
    
    func initPortalView() {
        self.portalView.backgroundColor = kGRAY_80
        self.portalView.layer.cornerRadius = 3.0
        self.portalView.clipsToBounds = true
        
        self.portalView.layer.shadowOpacity = 0.5
        self.portalView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.portalView.layer.shadowRadius = 3.0
        self.portalView.layer.masksToBounds = false

        self.portalLabel.textColor = kWHITE
        self.portalLabel.font = kBODY2_MEDIUM
        self.portalLabel.textAlignment = .center
        self.portalLabel.text = "투니 감상하기"
        
        self.portalButton.addTarget(self, action: #selector(doPortal), for: .touchUpInside)
        
        self.portalButtonBottomConstraint.constant = -200.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initVars()
        self.initBackgroundView()
        self.initNavigationView()
        self.initHeaderView()
        self.initTableView()
        self.initCommentView()
        self.initPortalView()
        
        self.startActivity()
        self.fetchWebtoonDetail()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.headerView.bind(self.webtoonItem)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.showHideNavigationView ? .default : .lightContent
    }

}

// MARK: - Week Webtoon

extension WebtoonDetailViewController {
    
    func fetchWebtoonDetail() {
        guard let webtoonId = self.webtoonItem.id?.string else { return }

        TooniNetworkService.shared.request(to: .webtoonDetail(webtoonId), decoder: WebtoonDetail.self) { [weak self] response in
            switch response.result {
            case .success:
                guard let webtoonDetail = (response.json as? WebtoonDetail) else { return }
                
                self?.webtoonItem = webtoonDetail.webtoon
                self?.webtoonDetailItem = webtoonDetail
                
                DispatchQueue.main.async {
                    self?.stopActivity()
                    self?.mainTableView.reloadData()
                    
                    self?.view.layoutIfNeeded()
                    self?.mainTableView.setContentOffset(CGPoint.init(x: 0.0, y: -kWEBTOON_DETAIL_HEADER_HEIGHT + kDEVICE_TOP_AREA + 24.0), animated: false)
                    
                    UIView.animate(withDuration: 0.3) {
                        self?.headerView.alpha = 1.0
                        self?.mainTableView.alpha = 1.0
                        self?.hideNavigationView.alpha = 1.0
                    }
                    
                    self?.view.layoutIfNeeded()
                    UIView.animate(withDuration: 0.7,
                                   delay: 0.25,
                                   usingSpringWithDamping: 0.8,
                                   initialSpringVelocity: 0.0,
                                   options: .curveEaseInOut) {
                        self?.portalButtonBottomConstraint.constant = 16.0
                        self?.view.layoutIfNeeded()
                    } completion: { _ in
                        
                    }

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
    
    @objc
    func doPortal() {
        if let webtoonUrl = self.webtoonItem.url,
           let url = URL.init(string: webtoonUrl) {
            let safariVC = SFSafariViewController(url: url)

            self.present(safariVC, animated: true) {
                GeneralHelper.sharedInstance.addRecentWebtoon(self.webtoonItem)
            }
        }
    }
    
}

// MARK: - WebtoonDetailHeaderView

extension WebtoonDetailViewController: WebtoonDetailHeaderViewDelegate {
    
    func didMenuWebtoonDetailHeaderView(view: WebtoonDetailHeaderView, idx: Int) {
        self.selectedIdx = idx
        
        self.refreshUI()
    }
    
    func refreshUI() {
        self.commentView.alpha = self.selectedIdx == 0 ? 0.0 : 1.0
    }
    
    func didBackWebtoonDetailHeaderView(view: WebtoonDetailHeaderView) {
        self.doBack()
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
            cell.delegate = self
            
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

// MARK: - WebtoonDetailInfoCell

extension WebtoonDetailViewController: WebtoonDetailInfoCellDelegate {
    
    func didFavoriteWebtoonDetailInfoCell(cell: WebtoonDetailInfoCell) {
        GeneralHelper.sharedInstance.doVibrate()
        
        if GeneralHelper.sharedInstance.existFavorite(self.webtoonItem) {
            GeneralHelper.sharedInstance.removeFavoriteWebtoon(self.webtoonItem)
        }
        else {
            GeneralHelper.sharedInstance.addFavoriteWebtoon(self.webtoonItem)
        }
        
        self.mainTableView.reloadRows(at: [IndexPath.init(row: WebtoonDetailViewType.info.rawValue, section: 0)], with: .none)
    }
    
}

// MARK: - UIScrollView

extension WebtoonDetailViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = -scrollView.contentOffset.y + kDEVICE_TOP_AREA - kWEBTOON_DETAIL_HEADER_HEIGHT
        let zeroOffsetY = offsetY + 24.0
        let topMargin = kWEBTOON_DETAIL_HEADER_HEIGHT - self.hideNavigationViewHeightConstraint.constant - 50
        
        self.hideNavigationViewTopConstraint.constant = -self.hideNavigationViewHeightConstraint.constant - zeroOffsetY
        if zeroOffsetY <= -self.hideNavigationViewHeightConstraint.constant {
            self.hideNavigationViewTopConstraint.constant = 0.0
        }
                        
        if offsetY >= -24.0 {
            let height = kWEBTOON_DETAIL_HEADER_HEIGHT - kDEVICE_TOP_AREA - 24.0
            scrollView.contentOffset.y = -height

            self.headerViewTopConstraint.constant = 0.0
            
            self.showHideNavigationView = false
            self.setNeedsStatusBarAppearanceUpdate()
        }
        else if zeroOffsetY <= -topMargin {
            self.headerViewTopConstraint.constant = -topMargin
            
            self.showHideNavigationView = true
            self.setNeedsStatusBarAppearanceUpdate()
        }
        else {
            self.headerViewTopConstraint.constant = offsetY + 24.0
        }
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

