//
//  GeneralHelper.swift
//  TooniTooni
//
//  Created by GENETORY on 2021/04/12.
//

import UIKit
import AudioToolbox

class GeneralHelper {

    // MARK: - Vars
    
    var tabList: [TabItem] = []
    
    var webtoonList: [WebtoonItem] = []
    var authorList: [AuthorItem] = []
    
    static let sharedInstance = GeneralHelper()
    
    // MARK: - Life Cycle
    
    func setup() {
        self.initTabList()
        
        self.initDummyWebtoonList()
        self.initDummyAuthorList()
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

// MARK: - Dummy

extension GeneralHelper {
    
    func initDummyAuthorList() {
        let authorItem1 = AuthorItem.init(name: "야옹이")
        let authorItem2 = AuthorItem.init(name: "류기훈")
        let authorItem3 = AuthorItem.init(name: "문정훈")
        let authorItem4 = AuthorItem.init(name: "기안84")
        let authorItem5 = AuthorItem.init(name: "모죠")
        let authorItem6 = AuthorItem.init(name: "홍끼")
        let authorItem7 = AuthorItem.init(name: "기맹기")
        
        self.authorList = [authorItem1,
                           authorItem2,
                           authorItem3,
                           authorItem4,
                           authorItem5,
                           authorItem6,
                           authorItem7]
    }
    
    func initDummyWebtoonList() {
        let webtoonItem1 = WebtoonItem.init(title: "참교육", authors: ["채용택", "한가람"], tags: ["코미디", "드라마", "학원물"], type: .naver)
        let webtoonItem2 = WebtoonItem.init(title: "뷰티풀 군바리", authors: ["설이", "윤성원"], tags: ["코미디", "드라마", "학원물"], type: .naver)
        let webtoonItem3 = WebtoonItem.init(title: "소녀의 세계", authors: ["모랑지"], tags: ["코미디", "드라마", "학원물"], type: .daum)
        let webtoonItem4 = WebtoonItem.init(title: "윈드브레이커", authors: ["조용석"], tags: ["코미디", "드라마", "학원물"], type: .naver)
        let webtoonItem5 = WebtoonItem.init(title: "파이게임", authors: ["배진수"], tags: ["코미디", "드라마", "학원물"], type: .daum)
        let webtoonItem6 = WebtoonItem.init(title: "만렙돌파", authors: ["성불예정, 홍실", "미노"], tags: ["코미디", "드라마", "학원물"], type: .naver)
        let webtoonItem7 = WebtoonItem.init(title: "삼매경", authors: ["이원식", "꿀찬"], tags: ["코미디", "드라마", "학원물"], type: .naver)
        let webtoonItem8 = WebtoonItem.init(title: "잔불의 기사", authors: ["환댕"], tags: ["코미디", "드라마", "학원물"], type: .daum)
        let webtoonItem9 = WebtoonItem.init(title: "칼가는 소녀", authors: ["오리"], tags: ["코미디", "드라마", "학원물"], type: .naver)
        let webtoonItem10 = WebtoonItem.init(title: "요리GO", authors: ["HO9"], tags: ["코미디", "드라마", "학원물"], type: .daum)
        
        self.webtoonList = [webtoonItem1,
                            webtoonItem2,
                            webtoonItem3,
                            webtoonItem4,
                            webtoonItem5,
                            webtoonItem6,
                            webtoonItem7,
                            webtoonItem8,
                            webtoonItem9,
                            webtoonItem10]
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
