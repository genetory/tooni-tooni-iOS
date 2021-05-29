//
//  GeneralTitleHeaderView.swift
//  TooniTooni
//
//  Created by GENETORY on 2021/04/27.
//

import UIKit

let kGeneralTitleHeaderViewID =                                     "GeneralTitleHeaderView"

class GeneralTitleHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Vars
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Life Cycle
    
    func initVars() {
        self.clipsToBounds = true
    }
    
    func initBackgroundView() {
        self.baseView.backgroundColor = kWHITE
    }
    
    func initLabel() {
        self.titleLabel.textColor = kGRAY_90
        self.titleLabel.font = kHEADING3_BOLD
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

extension GeneralTitleHeaderView {
    
    func bind(_ title: String?) {
        self.titleLabel.text = title
    }
    
}
