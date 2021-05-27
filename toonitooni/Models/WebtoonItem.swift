//
//  WebtoonItem.swift
//  TooniTooni
//
//  Created by GENETORY on 2021/04/27.
//

import Foundation

struct WeekWebtoon: Codable {
    var sites: [Site]?
    var webtoons: [Webtoon]?
}

struct Site: Codable {
    let site: String?
    let thumbnail: String?
}

struct Author: Codable {
    var id: Int?
    var name: String?
}

struct Webtoon: Codable {
    var id: Int?
    var site: String?
    var title: String?
    var authors: [Author]?
    var popularity: Int?
    var thumbnail: String?
    var backgroundColor: String?
    var genres: [String]?
    var score: Double?
    var isComplete: Bool?
}

