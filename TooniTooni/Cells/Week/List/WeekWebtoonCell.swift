//
//  WeekWebtoonCell.swift
//  TooniTooni
//
//  Created by GENETORY on 2021/04/27.
//

import UIKit

let kWeekWebtoonCellID =                                            "WeekWebtoonCell"

class WeekWebtoonCell: UICollectionViewCell {
    
    // MARK: - Vars
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var badgeView: GeneralBadgeView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
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
    
    func initLabels() {
        self.titleLabel.textColor = .black
        self.titleLabel.font = UIFont.systemFont(ofSize: 12.0, weight: UIFont.Weight.bold)
        self.titleLabel.text = nil
        
        self.authorLabel.textColor = .black
        self.authorLabel.font = UIFont.systemFont(ofSize: 12.0, weight: UIFont.Weight.regular)
        self.authorLabel.text = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initVars()
        self.initBackgroundView()
        self.initImageView()
        self.initLabels()
    }
    
}

// MARK: - Bind

extension WeekWebtoonCell {
    
    func bind(_ webtoonItem: WebtoonItem) {
        self.titleLabel.text = webtoonItem.title
        self.authorLabel.text = webtoonItem.authors?.joined(separator: "/")
        
        self.badgeView.bind(webtoonItem.type)
    }
    
}
