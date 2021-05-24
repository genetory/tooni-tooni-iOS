//
//  HomeGenreCell.swift
//  TooniTooni
//
//  Created by GENETORY on 2021/04/27.
//

import UIKit

let kHomeDriveCellID =                                          "HomeDriveCell"

class HomeDriveCell: UITableViewCell {
    
    // MARK: - Vars
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var genreView: GeneralGenreView!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var badgeView: GeneralBadgeView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    // MARK: - Life Cycle
    
    func initVars() {
        self.clipsToBounds = true
    }
    
    func initBackgroundView() {
        self.backgroundView = UIView()
        self.backgroundView?.backgroundColor = kWHITE
        self.selectedBackgroundView = UIView()
        self.selectedBackgroundView?.backgroundColor = UIColor(white: 0.98, alpha: 1.0)

        self.baseView.backgroundColor = .clear
    }
    
    func initImageViews() {
        self.bgImageView.clipsToBounds = true
        self.bgImageView.contentMode = .scaleAspectFill
        self.bgImageView.layer.cornerRadius = 5.0

        self.thumbImageView.clipsToBounds = true
        self.thumbImageView.contentMode = .scaleAspectFill
    }
    
    func initLabels() {
        self.titleLabel.textColor = .black
        self.titleLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .medium)
        self.titleLabel.textAlignment = .center
        self.titleLabel.text = nil
        
        self.infoLabel.textColor = kWHITE
        self.infoLabel.font = UIFont.systemFont(ofSize: 10.0, weight: .bold)
        self.infoLabel.text = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initVars()
        self.initBackgroundView()
        self.initImageViews()
        self.initLabels()
    }
    
}

// MARK: - Bind

extension HomeDriveCell {
    
    func bind(_ webtoon: Webtoon) {
        self.titleLabel.text = webtoon.title
        
        if let image = webtoon.thumbnail {
            self.bgImageView.kf.setImage(with: URL.init(string: image),
                                           placeholder: nil,
                                           options: [.transition(.fade(0.25))], completionHandler: nil)
            
            self.thumbImageView.kf.setImage(with: URL.init(string: image),
                                           placeholder: nil,
                                           options: [.transition(.fade(0.25))], completionHandler: nil)
        }
        
        let infoString = webtoon.genres?.joined(separator: " | ")
        self.infoLabel.text = infoString

        self.badgeView.bind(webtoon)
        self.genreView.bind(webtoon)
    }
    
}
