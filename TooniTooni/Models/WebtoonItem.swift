//
//  WebtoonItem.swift
//  TooniTooni
//
//  Created by GENETORY on 2021/04/27.
//

import Foundation

enum WebtoonType: Int {
    case naver
    case daum
}

struct WebtoonItem {
    var title: String!
    var authors: [String]!
    var tags: [String]!
    var type: WebtoonType!
    
    init(title: String, authors: [String], tags: [String], type: WebtoonType) {
        self.title = title
        self.authors = authors
        self.tags = tags
        self.type = type
    }
    
}
