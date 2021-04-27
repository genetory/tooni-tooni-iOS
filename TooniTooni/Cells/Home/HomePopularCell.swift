//
//  HomePopularCell.swift
//  TooniTooni
//
//  Created by GENETORY on 2021/04/27.
//

import UIKit

let kHomePopularCellID =                                "HomePopularCell"

class HomePopularCell: UITableViewCell {
    
    // MARK: - Vars
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var badgeView: GeneralBadgeView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    
    // MARK: - Life Cycle
    
    func initVars() {
        self.clipsToBounds = true
    }
    
    func initBackgroundView() {
        self.backgroundView = UIView()
        self.backgroundView?.backgroundColor = .white
        self.selectedBackgroundView = UIView()
        self.selectedBackgroundView?.backgroundColor = UIColor(white: 0.98, alpha: 1.0)
        
        self.baseView.backgroundColor = .clear
    }
    
    func initImageView() {
        self.thumbImageView.layer.cornerRadius = 4.0
        self.thumbImageView.clipsToBounds = true
        self.thumbImageView.backgroundColor = .lightGray
    }
    
    func initLabels() {
        self.titleLabel.textColor = .darkGray
        self.titleLabel.font = UIFont.systemFont(ofSize: 16.0, weight: UIFont.Weight.bold)
        self.titleLabel.text = nil
        
        self.authorLabel.textColor = .darkGray
        self.authorLabel.font = UIFont.systemFont(ofSize: 12.0, weight: UIFont.Weight.regular)
        self.authorLabel.text = nil
        
        self.tagLabel.textColor = .darkGray
        self.tagLabel.font = UIFont.systemFont(ofSize: 10.0, weight: UIFont.Weight.regular)
        self.tagLabel.text = nil
    }
    
    func initButton() {
        self.heartButton.setImage(UIImage.init(named: "icon_heart"), for: .normal)
        self.heartButton.addTarget(self, action: #selector(doHeart), for: .touchUpInside)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initVars()
        self.initBackgroundView()
        self.initImageView()
        self.initLabels()
        self.initButton()
    }
    
}

// MARK: - Event

extension HomePopularCell {
    
    @objc
    func doHeart() {
        
    }
    
}

// MARK: - Bind

extension HomePopularCell {
    
    func bind(_ webtoonItem: WebtoonItem) {
        self.titleLabel.text = webtoonItem.title
        self.authorLabel.text = webtoonItem.authors?.joined(separator: "/")
        self.tagLabel.text = webtoonItem.tags?.joined(separator: " | ")

        self.badgeView.bind(webtoonItem.type)
    }
    
}
