//
//  GeneralHelper.swift
//  TooniTooni
//
//  Created by GENETORY on 2021/04/12.
//

import UIKit
import AudioToolbox

let kFAVORITE_WEBTOON_LIST =                                    "FAVORITE_WEBTOON_LIST"
let kRECENT_WEBTOON_LIST =                                      "RECENT_WEBTOON_LIST"

class GeneralHelper {

    // MARK: - Vars
    
    var tabList: [TabItem] = []
    
    var recentItem = RecentItem()
    var favoriteItem = FavoriteItem()
        
    static let sharedInstance = GeneralHelper()
    
    // MARK: - Life Cycle
    
    func setup() {
        self.initTabList()
        self.fetchRecentWebtoons()
        self.fetchFavoriteWebtoons()
    }

}

// MARK: - Recent

extension GeneralHelper {
    
    func addRecentWebtoon(_ webtoon: Webtoon) {
        if let idx = self.recentItem.webtoons.firstIndex(where: { $0.id == webtoon.id }) {
            let webtoon = self.recentItem.webtoons[idx]
            self.recentItem.webtoons.remove(at: idx)
            self.recentItem.webtoons.insert(webtoon, at: 0)
        }
        else {
            self.recentItem.webtoons.insert(webtoon, at: 0)
        }
        
        self.saveRecentWebtoons()
    }
    
    func removeRecentWebtoon(_ webtoon: Webtoon) {
        if let idx = self.recentItem.webtoons.firstIndex(where: { $0.id == webtoon.id }) {
            self.recentItem.webtoons.remove(at: idx)
        }
        
        self.saveRecentWebtoons()
    }

    func fetchRecentWebtoons() {
        if let data = UserDefaults.standard.object(forKey: kRECENT_WEBTOON_LIST) as? Data,
           let recentItem = try? JSONDecoder.init().decode(RecentItem.self, from: data) {
            self.recentItem = recentItem
        }
        else {
            self.recentItem = RecentItem()
        }
        
        print("fetchRecentWebtoons: \( self.recentItem)")
    }
    
    func saveRecentWebtoons() {
        if let encodedData = try? JSONEncoder().encode(self.recentItem) {
            self.saveUserDefault(item: encodedData, key: kRECENT_WEBTOON_LIST)
        }

        self.fetchRecentWebtoons()
    }
    
}

// MARK: - Favorite

extension GeneralHelper {
    
    func addFavoriteWebtoon(_ webtoon: Webtoon) {
        if let idx = self.favoriteItem.webtoons.firstIndex(where: { $0.id == webtoon.id }) {
            let webtoon = self.favoriteItem.webtoons[idx]
            self.favoriteItem.webtoons.remove(at: idx)
            self.favoriteItem.webtoons.insert(webtoon, at: 0)
        }
        else {
            self.favoriteItem.webtoons.insert(webtoon, at: 0)
        }
        
        self.saveFavoriteWebtoons()
    }
    
    func removeFavoriteWebtoon(_ webtoon: Webtoon) {
        if let idx = self.favoriteItem.webtoons.firstIndex(where: { $0.id == webtoon.id }) {
            self.favoriteItem.webtoons.remove(at: idx)
        }
        
        self.saveFavoriteWebtoons()
    }
    
    func fetchFavoriteWebtoons() {
        if let data = UserDefaults.standard.object(forKey: kFAVORITE_WEBTOON_LIST) as? Data,
           let favoriteItem = try? JSONDecoder.init().decode(FavoriteItem.self, from: data) {
            self.favoriteItem = favoriteItem
        }
        else {
            self.favoriteItem = FavoriteItem()
        }
        
        print("fetchFavoriteWebtoons: \( self.favoriteItem)")
    }
    
    func saveFavoriteWebtoons() {
        if let encodedData = try? JSONEncoder().encode(self.favoriteItem) {
            self.saveUserDefault(item: encodedData, key: kFAVORITE_WEBTOON_LIST)
        }

        self.fetchFavoriteWebtoons()
    }
    
}

// MARK: - User Default

extension GeneralHelper {
    
    func saveUserDefault(item: Any?, key: String) {
        UserDefaults.standard.set(item, forKey: key)
        UserDefaults.standard.synchronize()
    }

}

// MARK: - Tab

extension GeneralHelper {

    func initTabList() {
        let homeItem = TabItem.init(storyBoard: "Home",
                                    viewController: "HomeViewController",
                                    title: "홈",
                                    type: .home)
        let weekdayItem = TabItem.init(storyBoard: "Week",
                                       viewController: "WeekViewController",
                                       title: "요일별",
                                       type: .weekday)
        let favoriteItem = TabItem.init(storyBoard: "Favorite",
                                       viewController: "FavoriteViewController",
                                       title: "즐겨찾기",
                                       type: .favorite)
        let settingsItem = TabItem.init(storyBoard: "Settings",
                                       viewController: "SettingsViewController",
                                       title: "설정",
                                       type: .settings)

        self.tabList = [homeItem, weekdayItem, favoriteItem, settingsItem]
    }

}

// MARK: - Make ViewController

extension GeneralHelper {

    func makeVC(_ storyBoard: String, _ viewController: String) -> BaseViewController {
        let sb = UIStoryboard.init(name: storyBoard, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: viewController) as! BaseViewController
        
        return vc
    }
        
    func makePageVC(_ storyBoard: String, _ viewController: String) -> UIPageViewController {
        let sb = UIStoryboard.init(name: storyBoard, bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: viewController) as! UIPageViewController
        
        return vc
    }

    func makeTabBarVC(_ storyBoard: String, _ viewController: String) -> UITabBarController {
        let sb: UIStoryboard = UIStoryboard.init(name: storyBoard, bundle: nil)
        let vc: BaseTabBarViewController = sb.instantiateViewController(withIdentifier: viewController) as! BaseTabBarViewController
        
        return vc
    }

}
