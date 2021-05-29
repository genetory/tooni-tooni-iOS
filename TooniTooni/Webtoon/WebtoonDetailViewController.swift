//
//  WebtoonDetailViewController.swift
//  TooniTooni
//
//  Created by GENETORY on 2021/05/29.
//

import UIKit

enum WebtoonDetailViewType: Int {
    case info
    
    static let count = 1
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
        let infoCell = UINib.init(nibName: kWebtoonDetailInfoCellID, bundle: nil)
        self.mainTableView.register(infoCell, forCellReuseIdentifier: kWebtoonDetailInfoCellID)
        
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
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == WebtoonDetailViewType.info.rawValue,
           let cell = tableView.dequeueReusableCell(withIdentifier: kWebtoonDetailInfoCellID, for: indexPath) as? WebtoonDetailInfoCell {
            cell.bind(self.webtoonItem)
            
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
