//
//  WebtoonDetailCommentView.swift
//  TooniTooni
//
//  Created by GENETORY on 2021/06/05.
//

import UIKit

class WebtoonDetailCommentView: BaseCustomView {
    
    // MARK: - Vars
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var mainTableView: UITableView!
    
    var commentList: [Comment]?
    
    // MARK: - Life Cycle
    
    func initVars() {
        self.clipsToBounds = true
    }
    
    func initBackgroundView() {
        self.baseView.backgroundColor = kWHITE
    }
    
    func initTableView() {
        let commentCell = UINib.init(nibName: kWebtoonDetailCommentCellID, bundle: nil)
        self.mainTableView.register(commentCell, forCellReuseIdentifier: kWebtoonDetailCommentCellID)

        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        self.mainTableView.separatorStyle = .none
        self.mainTableView.backgroundColor = kWHITE
        self.mainTableView.rowHeight = UITableView.automaticDimension
        self.mainTableView.estimatedRowHeight = 200.0
        self.mainTableView.sectionHeaderHeight = UITableView.automaticDimension
        self.mainTableView.estimatedSectionHeaderHeight = 40.0
        self.mainTableView.sectionFooterHeight = UITableView.automaticDimension
        self.mainTableView.estimatedSectionFooterHeight = 16.0
        self.mainTableView.showsVerticalScrollIndicator = false
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initVars()
        self.initBackgroundView()
    }
    
}

// MARK: - UITableView

extension WebtoonDetailCommentView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let commentList = self.commentList, commentList.count > 0 {
            return commentList.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let commentList = self.commentList, commentList.count > 0,
           let cell = tableView.dequeueReusableCell(withIdentifier: kWebtoonDetailCommentCellID, for: indexPath) as? WebtoonDetailCommentCell {
            let commentItem = commentList[indexPath.row]
            cell.bind(commentItem)
            
            return cell
        }
        
        return .init()
    }
    
}
