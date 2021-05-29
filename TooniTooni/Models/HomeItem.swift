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
        case topBanner = "topBanner"
        case weekdayList = "weekdayWebtoons"
        case trendingList = "trendingWebttons"
        case genreList = "genreWebtoons"
        case bingeList = "bingeWatchableWebtoons"
    }
}

struct HomeBanner: Codable {
    var webtoon: Webtoon?
    var caption: String?
}
