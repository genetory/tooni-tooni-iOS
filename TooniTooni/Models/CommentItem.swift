//
//  CommentItem.swift
//  TooniTooni
//
//  Created by GENETORY on 2021/05/30.
//

import Foundation

struct CommentInfoItem: Codable {
    var commentInfo: CommentItem?
    var isLastComment: Bool?
    var lastCommentId: Int?
}

struct CommentItem: Codable {
    var id: Int?
    var content: String?
    var nickname: String?
    var writeDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "commentId"
        case content
        case nickname
        case writeDate
    }

}
