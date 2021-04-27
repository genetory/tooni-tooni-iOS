//
//  HomeWebtoonCell.swift
//  TooniTooni
//
//  Created by GENETORY on 2021/04/27.
//

import UIKit

let kHomeWebtoonCellID =                                        "HomeWebtoonCell"

class HomeWebtoonCell: UICollectionViewCell {
    
    // MARK: - Vars
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var badgeView: GeneralBadgeView!
    @IBOutlet weak var titleLabel: UILabel!

    // MARK: - Life Cycle
    
    func initVars() {
        self.clipsToBounds = true
    }
    
    func initBackgroundView() {
        self.baseView.backgroundColor = .white
    }
    
    func initImageView() {
        self.thumbImageView.layer.cornerRadius = 4.0
        self.thumbImageView.clipsToBounds = true
        self.thumbImageView.backgroundColor = .lightGray
    }
    
    func initLabel() {
        self.titleLabel.textColor = .black
        self.titleLabel.font = UIFont.systemFont(ofSize: 14.0, weight: UIFont.Weight.regular)
        self.titleLabel.text = nil
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initVars()
        self.initBackgroundView()
        self.initImageView()
        self.initLabel()
    }
    
}

// MARK: - Bind

extension HomeWebtoonCell {
    
    func bind(_ webtoonItem: WebtoonItem) {
        self.titleLabel.text = webtoonItem.title
        
        self.badgeView.bind(webtoonItem.type)
    }
    
}
