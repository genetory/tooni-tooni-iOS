//
//  HomeAuthorCell.swift
//  TooniTooni
//
//  Created by GENETORY on 2021/04/27.
//

import UIKit

let kHomeAuthorCellID =                                     "HomeAuthorCell"

class HomeAuthorCell: UICollectionViewCell {
    
    // MARK: - Vars
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!

    // MARK: - Life Cycle
    
    func initVars() {
        self.clipsToBounds = true
    }
    
    func initBackgroundView() {
        self.baseView.backgroundColor = kWHITE
    }
    
    func initImageView() {
        self.thumbImageView.layer.cornerRadius = 26.0
        self.thumbImageView.clipsToBounds = true
        self.thumbImageView.backgroundColor = kGRAY_10
        self.thumbImageView.contentMode = .scaleAspectFill
    }
    
    func initLabel() {
        self.authorLabel.textColor = .black
        self.authorLabel.font = UIFont.systemFont(ofSize: 12.0, weight: UIFont.Weight.regular)
        self.authorLabel.textAlignment = .center
        self.authorLabel.text = nil
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

extension HomeAuthorCell {
    
    func bind(_ author: Author) {
        self.authorLabel.text = author.name
    }
    
}
