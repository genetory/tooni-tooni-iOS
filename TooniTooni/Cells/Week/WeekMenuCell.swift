//
//  WeekMenuCell.swift
//  TooniTooni
//
//  Created by GENETORY on 2021/04/27.
//

import UIKit

let kWeekMenuCellID =                                           "WeekMenuCell"

class WeekMenuCell: UICollectionViewCell {
    
    // MARK: - Vars
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Life Cycle
    
    func initVars() {
        self.clipsToBounds = true
    }
    
    func initBackgroundView() {
        self.baseView.backgroundColor = .white
    }
    
    func initLabel() {
        self.titleLabel.font = UIFont.systemFont(ofSize: 15.0, weight: UIFont.Weight.regular)
        self.titleLabel.textColor = .lightGray
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

extension WeekMenuCell {
    
    func bind(_ title: String?) {
        self.titleLabel.text = title
    }
    
    func selected(_ selected: Bool) {
        self.titleLabel.textColor = selected ? .black : .lightGray
    }
    
}
