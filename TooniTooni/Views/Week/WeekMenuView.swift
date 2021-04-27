//
//  WeekMenuView.swift
//  TooniTooni
//
//  Created by GENETORY on 2021/04/27.
//

import UIKit

protocol WeekMenuTitle {
    var title: String { get }
}

enum WeekMenuType: Int, WeekMenuTitle {
    case mon
    case tue
    case wed
    case thu
    case fri
    case sat
    case sun
    case completed
    
    var title: String {
        switch self {
        case .mon:
            return "월"
        case .tue:
            return "화"
        case .wed:
            return "수"
        case .thu:
            return "목"
        case .fri:
            return "금"
        case .sat:
            return "토"
        case .sun:
            return "일"
        case .completed:
            return "완결"
        }
    }
    
    static let count = 8
}

protocol WeekMenuViewDelegate: class {
    func didMenuWeekMenuView(view: WeekMenuView, idx: Int)
}

class WeekMenuView: BaseCustomView {
    
    // MARK: - Vars
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var selectedViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var selectedViewLeftConstraint: NSLayoutConstraint!

    var selectedIdx = 0
    let cellWidth = (kDEVICE_WIDTH - 48.0) / CGFloat(WeekMenuType.count)
    
    weak var delegate: WeekMenuViewDelegate?
    
    // MARK: - Life Cycle
    
    func initVars() {
        self.clipsToBounds = true
    }
    
    func initBackgroundView() {
        self.baseView.backgroundColor = .white
    }
    
    func initCollectionView() {
        let menuCell = UINib.init(nibName: kWeekMenuCellID, bundle: nil)
        self.mainCollectionView.register(menuCell, forCellWithReuseIdentifier: kWeekMenuCellID)
        
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize.init(width: self.cellWidth, height: 50.0)
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        layout.headerReferenceSize = .zero
        layout.footerReferenceSize = .zero
        layout.sectionInset = UIEdgeInsets.init(top: 0.0, left: 24.0, bottom: 0.0, right: 24.0)
        
        self.mainCollectionView.delegate = self
        self.mainCollectionView.dataSource = self
        self.mainCollectionView.backgroundColor = .white
        self.mainCollectionView.showsVerticalScrollIndicator = false
        self.mainCollectionView.showsHorizontalScrollIndicator = false
        self.mainCollectionView.alwaysBounceHorizontal = true
        self.mainCollectionView.alwaysBounceVertical = false
        self.mainCollectionView.isScrollEnabled = false
        self.mainCollectionView.collectionViewLayout = layout
    }
    
    func initSelectedView() {
        self.selectedViewLeftConstraint.constant = 24.0
        self.selectedViewWidthConstraint.constant = self.cellWidth
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initVars()
        self.initBackgroundView()
        self.initCollectionView()
        self.initSelectedView()
    }
    
}

// MARK: - Bind

extension WeekMenuView {
    
    func bind(_ selectedIdx: Int) {
        self.selectedIdx = selectedIdx
        self.mainCollectionView.reloadData()
    }
    
    func move(_ idx: Int) {
        self.selectedIdx = idx
        
        UIView.animate(withDuration: 0.25) {
            self.selectedViewLeftConstraint.constant = self.cellWidth * CGFloat(idx) + 24.0
            self.layoutIfNeeded()
        }

        self.mainCollectionView.reloadData()
    }
    
}

// MARK: - UICollectionView

extension WeekMenuView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return WeekMenuType.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kWeekMenuCellID, for: indexPath) as? WeekMenuCell {
            let title = WeekMenuType.init(rawValue: indexPath.row)?.title
            cell.bind(title)
            cell.selected(indexPath.row == self.selectedIdx ? true : false)
            
            return cell
        }
        
        return .init()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        self.move(indexPath.row)
        self.delegate?.didMenuWeekMenuView(view: self, idx: indexPath.row)
    }
    
}
