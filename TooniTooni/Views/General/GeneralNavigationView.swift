//
//  GeneralNavigationView.swift
//  TooniTooni
//
//  Created by GENETORY on 2021/04/12.
//

import UIKit

class GeneralNavigationView: BaseCustomView {
    
    // MARK: - Vars
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var bigTitleLabel: UILabel!

    // MARK: - Life Cycle
    
    func initVars() {
        self.clipsToBounds = true
    }
    
    func initBackgroundView() {
        self.baseView.backgroundColor = .clear
    }
    
    func initButtons() {
        self.leftButton.isHidden = true
        self.subButton.isHidden = true
        self.rightButton.isHidden = true
    }
    
    func initLabels() {
        self.titleLabel.font = UIFont.systemFont(ofSize: 16.0, weight: UIFont.Weight.bold)
        self.titleLabel.textColor = .black
        self.titleLabel.textAlignment = .center
        self.titleLabel.text = nil

        self.bigTitleLabel.font = UIFont.systemFont(ofSize: 26.0, weight: UIFont.Weight.heavy)
        self.bigTitleLabel.textColor = .black
        self.bigTitleLabel.text = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initVars()
        self.initBackgroundView()
        self.initButtons()
        self.initLabels()
    }
    
}

// MARK: -

extension GeneralNavigationView {
    
    func title(_ title: String?) {
        self.titleLabel.text = title
        self.bigTitleLabel.text = title
    }
    
    func bgColor(_ color: UIColor) {
        self.topView.backgroundColor = color
        self.baseView.backgroundColor = color
    }
    
    func bigTitle(_ bigTitle: Bool) {
        self.titleLabel.alpha = bigTitle ? 0.0 : 1.0
        self.bigTitleLabel.alpha = bigTitle ? 1.0 : 0.0
    }
    
}
