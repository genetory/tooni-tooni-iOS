//
//  WeekListViewController.swift
//  TooniTooni
//
//  Created by GENETORY on 2021/04/27.
//

import UIKit

class WeekListViewController: BaseViewController {
    
    // MARK: - Vars
    
    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    var webtoonList: [WebtoonItem] = []
    
    // MARK: - Life Cycle
    
    func initBackgroundView() {
        self.view.backgroundColor = .white
        
        self.webtoonList = GeneralHelper.sharedInstance.webtoonList.shuffled()
    }
    
    func initCollectionView() {
        let menuCell = UINib.init(nibName: kWeekWebtoonCellID, bundle: nil)
        self.mainCollectionView.register(menuCell, forCellWithReuseIdentifier: kWeekWebtoonCellID)
        
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize.init(width: (kDEVICE_WIDTH - 64.0) / 3.0, height: (kDEVICE_WIDTH - 64.0) / 3.0 + 52.0)
        layout.minimumLineSpacing = 8.0
        layout.minimumInteritemSpacing = 8.0
        layout.headerReferenceSize = .zero
        layout.footerReferenceSize = .zero
        layout.sectionInset = UIEdgeInsets.init(top: 16.0, left: 24.0, bottom: 16.0, right: 24.0)
        
        self.mainCollectionView.delegate = self
        self.mainCollectionView.dataSource = self
        self.mainCollectionView.backgroundColor = .white
        self.mainCollectionView.showsVerticalScrollIndicator = false
        self.mainCollectionView.showsHorizontalScrollIndicator = false
        self.mainCollectionView.alwaysBounceHorizontal = false
        self.mainCollectionView.alwaysBounceVertical = true
        self.mainCollectionView.collectionViewLayout = layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.initBackgroundView()
        self.initCollectionView()
    }
    
}

// MARK: - UICollectionView

extension WeekListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.webtoonList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kWeekWebtoonCellID, for: indexPath) as? WeekWebtoonCell {
            let webtoonItem = self.webtoonList[indexPath.row]
            cell.bind(webtoonItem)
            
            return cell
        }
        
        return .init()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
    }
    
}
