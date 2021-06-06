//
//  HomeItem.swift
//  TooniTooni
//
//  Created by GENETORY on 2021/05/24.
//

import Foundation

struct Home: Codable {
    var topBanner: [HomeBanner]?
    var weekdayList: [Webtoon]?
    var trendingList: [Webtoon]?
    var genreList: [Webtoon]?
    var bingeList: [Webtoon]?
    
    enum CodingKeys: String, CodingKey {
        case topBanner = "mainBanner"
        case weekdayList = "weekdayWebtoons"
        case trendingList = "trendingWebtoons"
        case genreList = "genreWebtoons"
        case bingeList = "bingeWatchableWebtoons"
    }
}

struct HomeBanner: Codable {
    var webtoon: Webtoon?
    var caption: String?
}
