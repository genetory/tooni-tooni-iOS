//
//  HomeNoticeCell.swift
//  TooniTooni
//
//  Created by GENETORY on 2021/04/27.
//

import UIKit

let kHomeNoticeCellID =                                     "HomeNoticeCell"

class HomeNoticeCell: UITableViewCell {
    
    // MARK: - Vars
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Life Cycle
    
    func initVars() {
        self.clipsToBounds = true
    }
    
    func initBackgroundView() {
        self.baseView.backgroundColor = .darkGray
    }
    
    func initLabel() {
        self.titleLabel.textColor = .white
        self.titleLabel.font = UIFont.systemFont(ofSize: 10.0, weight: UIFont.Weight.bold)
        self.titleLabel.numberOfLines = 0
        self.titleLabel.textAlignment = .center
        self.titleLabel.text = "승진님! 세상의 모든 웹툰을 경험해보세요"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initVars()
        self.initBackgroundView()
        self.initLabel()
    }
    
}
