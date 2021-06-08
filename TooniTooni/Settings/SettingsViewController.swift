//
//  SettingsViewController.swift
//  TooniTooni
//
//  Created by GENETORY on 2021/04/12.
//

import UIKit

enum SettingsType: Int, CaseIterable {
    case feedback
    case opensources
    case made
    
    var title: String {
        switch self {
        case .feedback:
            return "피드백 보내기"
        case .opensources:
            return "오픈소스"
        case .made:
            return "만든 사람들"
        }
    }
    
    var image: String {
        switch self {
        case .feedback:
            return "icon_feedback"
        case .opensources:
            return "icon_opensources"
        case .made:
            return "icon_made"
        }
    }
    
    static let count = 3
}

class SettingsViewController: BaseViewController {

    // MARK: - Vars
    
    @IBOutlet weak var navigationView: GeneralNavigationView!
    @IBOutlet weak var mainTableView: UITableView!
    
    // MARK: - Life Cycle
    
    func initVars() {
        self.showBigTitle = false
    }
    
    func initBackgroundView() {
        self.view.backgroundColor = kWHITE
    }
    
    func initNavigationView() {
        self.setInteractiveRecognizer()
        
        self.navigationView.title(self.tabItem?.title)
        self.navigationView.bigTitle(self.showBigTitle)
        self.navigationView.leftButton(false)
        
        self.navigationView.rightButton.isHidden = false
        self.navigationView.rightButton.setImage(UIImage.init(named: "icon_search")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.navigationView.rightButton.tintColor = kGRAY_90
        self.navigationView.rightButton.addTarget(self, action: #selector(doSearch), for: .touchUpInside)
    }
    
    func initTableView() {
        let headerView = UINib.init(nibName: kSettingsHeaderViewID, bundle: nil)
        self.mainTableView.register(headerView, forHeaderFooterViewReuseIdentifier: kSettingsHeaderViewID)
        
        let listCell = UINib.init(nibName: kSettingsListCellID, bundle: nil)
        self.mainTableView.register(listCell, forCellReuseIdentifier: kSettingsListCellID)
        
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        self.mainTableView.separatorStyle = .none
        self.mainTableView.backgroundColor = kWHITE
        self.mainTableView.rowHeight = UITableView.automaticDimension
        self.mainTableView.estimatedRowHeight = 200.0
        self.mainTableView.sectionHeaderHeight = UITableView.automaticDimension
        self.mainTableView.estimatedSectionHeaderHeight = 44.0
        self.mainTableView.showsVerticalScrollIndicator = false
        self.mainTableView.insetsContentViewsToSafeArea = false
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

extension SettingsViewController {
    
    @objc
    func doSearch() {
        self.openSearchVC()
    }
    
    func openSearchVC() {
        if let vc = GeneralHelper.sharedInstance.makeVC("Search", "SearchViewController") as? SearchViewController {
            vc.hidesBottomBarWhenPushed = true
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}

// MARK: - UITableView

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingsType.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: kSettingsHeaderViewID) as? SettingsHeaderView {
            headerView.bind()
            
            return headerView
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: kSettingsListCellID, for: indexPath) as? SettingsListCell {
            let type = SettingsType.init(rawValue: indexPath.row)
            cell.bind(type)
            
            return cell
        }
        
        return .init()
    }    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}
