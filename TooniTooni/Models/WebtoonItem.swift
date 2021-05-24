//
//  WebtoonItem.swift
//  TooniTooni
//
//  Created by GENETORY on 2021/04/27.
//

import Foundation

struct WeekWebtoon: Codable {
    var sites: [Site] = []
    var webtoonList: [Webtoon] = []
}

struct Site: Codable {
    let site: String
    let thumbnail: String
}

struct Webtoon {
    var id: Int?
    var site: String?
    var title: String?
    var author: [String]?
    var popularity: Int?
    var thumbnail: String?
}

struct Author: Codable {
    var name: String?
}
