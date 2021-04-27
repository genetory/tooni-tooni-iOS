//
//  GeneralGenreView.swift
//  TooniTooni
//
//  Created by GENETORY on 2021/04/27.
//

import UIKit

class GeneralGenreView: BaseCustomView {
    
    // MARK: - Vars
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Life Cycle
    
    func initVars() {
        self.clipsToBounds = true
    }
    
    func initBackgroundView() {
        self.baseView.backgroundColor = .gray
        self.baseView.layer.cornerRadius = 4.0
        self.baseView.clipsToBounds = true
    }
    
    func initLabel() {
        self.titleLabel.textColor = .white
        self.titleLabel.font = UIFont.systemFont(ofSize: 10.0, weight: UIFont.Weight.regular)
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

extension GeneralGenreView {
    
    func bind(_ webtoonItem: WebtoonItem) {
        self.titleLabel.text = webtoonItem.tags.first
    }
    
}
