//
//  WebtoonDetailCommentCell.swift
//  TooniTooni
//
//  Created by GENETORY on 2021/05/30.
//

import UIKit

let kWebtoonDetailCommentCellID =                                       "WebtoonDetailCommentCell"

enum WebtoonDetailCommentMenuType: Int {
    case report
    case delete
}

protocol WebtoonDetailCommentCellDelegate: AnyObject {
    func didMenuWebtoonDetailCommentCell(cell: WebtoonDetailCommentCell, type: WebtoonDetailCommentMenuType)
}

class WebtoonDetailCommentCell: UITableViewCell {
    
    // MARK: - Vars
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var reportLabel: UILabel!
    @IBOutlet weak var reportButton: UIButton!
    @IBOutlet weak var dotView: UIImageView!
    @IBOutlet weak var deleteLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    weak var delegate: WebtoonDetailCommentCellDelegate?
    
    // MARK: - Life Cycle
    
    func initVars() {
        self.clipsToBounds = true
    }
    
    func initBackgroundView() {
        self.backgroundView = UIView()
        self.backgroundView?.backgroundColor = kWHITE
        self.selectedBackgroundView = UIView()
        self.selectedBackgroundView?.backgroundColor = kWHITE_HIGHLIGHT
        
        self.baseView.backgroundColor = kCLEAR
    }
    
    func initLabels() {
        self.nameLabel.font = kCAPTION1_MEDIUM
        self.nameLabel.textColor = kGRAY_90
        self.nameLabel.text = "찌니찌니승찌니"
        
        self.dateLabel.font = kCAPTION1_REGULAR
        self.dateLabel.textColor = kGRAY_30
        self.dateLabel.textAlignment = .right
        self.dateLabel.text = "2021.04.23"
        
        self.contentLabel.font = kBODY2_REGULAR
        self.contentLabel.textColor = kGRAY_90
        self.contentLabel.numberOfLines = 0
        self.contentLabel.text = "정말 킹받는 스토리네요... 스토리에 3점 드립니다. 작가님도 대단하네 독자들이 허구한날 이래도 ㅈㄹ 저래도 ㅈㄹ하면 스트레스ㅈㄹ받을건데 역시 버티는 힘은 전선욱님인가"
        
        self.reportLabel.font = kCAPTION1_REGULAR
        self.reportLabel.textColor = kGRAY_50
        self.reportLabel.text = "신고"
        
        self.deleteLabel.font = kCAPTION1_REGULAR
        self.deleteLabel.textColor = kGRAY_50
        self.deleteLabel.text = "삭제"
    }
    
    func initImageView() {
        self.dotView.image = UIImage.imageFromColor(kGRAY_50)
        self.dotView.layer.cornerRadius = 2.0
        self.dotView.clipsToBounds = true
    }
    
    func initButtons() {
        self.reportButton.addTarget(self, action: #selector(doReport), for: .touchUpInside)
        self.deleteButton.addTarget(self, action: #selector(doDelete), for: .touchUpInside)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initVars()
        self.initBackgroundView()
        self.initLabels()
        self.initImageView()
        self.initButtons()
    }
    
}

// MARK: - Event

extension WebtoonDetailCommentCell {
    
    @objc
    func doReport() {
        self.delegate?.didMenuWebtoonDetailCommentCell(cell: self, type: .report)
    }
    
    @objc
    func doDelete() {
        self.delegate?.didMenuWebtoonDetailCommentCell(cell: self, type: .delete)
    }
    
}

// MARK: - Bind

extension WebtoonDetailCommentCell {
    
    func bind(_ commentItem: Comment) {
        if let nickname = commentItem.account?.nickname {
            self.nameLabel.text = nickname
        }
        
        if let content = commentItem.content {
            self.contentLabel.attributedText = content.style(changeText: content,
                                                             lineSpacing: 3.0)
        }
    }
    
}
