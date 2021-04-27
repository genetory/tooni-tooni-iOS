//
//  HomeGenreCell.swift
//  TooniTooni
//
//  Created by GENETORY on 2021/04/27.
//

import UIKit

let kHomeGenreCellID =                                          "HomeGenreCell"

class HomeGenreCell: UITableViewCell {
    
    // MARK: - Vars
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var genreView: GeneralGenreView!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
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
    
    func initLabel() {
        self.titleLabel.textColor = .black
        self.titleLabel.font = UIFont.systemFont(ofSize: 14.0, weight: UIFont.Weight.regular)
        self.titleLabel.textAlignment = .center
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

extension HomeGenreCell {
    
    func bind(_ webtoonItem: WebtoonItem) {
        self.titleLabel.text = webtoonItem.title
        
        self.genreView.bind(webtoonItem)
    }
    
}
