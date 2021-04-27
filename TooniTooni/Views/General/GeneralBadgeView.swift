//
//  GeneralBadgeView.swift
//  TooniTooni
//
//  Created by GENETORY on 2021/04/27.
//

import UIKit

class GeneralBadgeView: BaseCustomView {
    
    // MARK: - Vars
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Life Cycle
    
    func initVars() {
        self.clipsToBounds = true
    }
    
    func initBackgroundView() {
        self.baseView.backgroundColor = .darkGray
        self.baseView.layer.cornerRadius = 2.0
        self.baseView.clipsToBounds = true
    }
    
    func initLabel() {
        self.titleLabel.textColor = .lightGray
        self.titleLabel.font = UIFont.systemFont(ofSize: 10.0, weight: UIFont.Weight.heavy)
        self.titleLabel.textAlignment = .center
        self.titleLabel.text = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initVars()
        self.initBackgroundView()
        self.initLabel()
    }
    
}

// MARK: - Bind

extension GeneralBadgeView {
    
    func bind(_ type: WebtoonType) {
        switch type {
        case .naver:
            self.titleLabel.text = "N"
        case .daum:
            self.titleLabel.text = "D"
        }
    }
    
}
