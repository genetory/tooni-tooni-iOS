//
//  HomeHeaderView.swift
//  TooniTooni
//
//  Created by GENETORY on 2021/05/28.
//

import UIKit

class HomeHeaderView: BaseCustomView {
    
    // MARK: - Vars
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    var topBanner: [HomeBanner]?
    
    // MARK: - Life Cycle
    
    func initVars() {
        self.clipsToBounds = true
    }
    
    func initBackgroundView() {
        self.baseView.backgroundColor = kWHITE
    }
    
    func initCollectionView() {
        let noticeCell = UINib.init(nibName: kHomeNoticeCellID, bundle: nil)
        self.mainCollectionView.register(noticeCell, forCellWithReuseIdentifier: kHomeNoticeCellID)
        
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize.init(width: kDEVICE_WIDTH, height: 368.0)
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        layout.headerReferenceSize = .zero
        layout.footerReferenceSize = .zero
        layout.sectionInset = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        
        self.mainCollectionView.delegate = self
        self.mainCollectionView.dataSource = self
        self.mainCollectionView.backgroundColor = kWHITE
        self.mainCollectionView.showsVerticalScrollIndicator = false
        self.mainCollectionView.showsHorizontalScrollIndicator = false
        self.mainCollectionView.alwaysBounceHorizontal = true
        self.mainCollectionView.alwaysBounceVertical = false
        self.mainCollectionView.isPagingEnabled = true
        self.mainCollectionView.collectionViewLayout = layout
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initVars()
        self.initBackgroundView()
        self.initCollectionView()
    }
    
}

// MARK: - Bind

extension HomeHeaderView {
    
    func bind(_ topBanner: [HomeBanner]?) {
        self.topBanner = topBanner
        self.mainCollectionView.reloadData()
    }
    
}

// MARK: - UICollectionView

extension HomeHeaderView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let topBanner = self.topBanner, topBanner.count > 0 {
            return topBanner.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kHomeNoticeCellID, for: indexPath) as? HomeNoticeCell,
           let topBanner = self.topBanner, topBanner.count > 0 {
            let banner = topBanner[indexPath.row]
            cell.bind(banner)
            
            return cell
        }
        
        return .init()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
    
}
