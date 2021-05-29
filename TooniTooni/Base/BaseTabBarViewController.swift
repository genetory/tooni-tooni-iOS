//
//  BaseTabBarViewController.swift
//  TooniTooni
//
//  Created by GENETORY on 2021/04/12.
//

import UIKit
import AVKit

class BaseTabBarViewController: UITabBarController {

    // MARK: - Vars
            
    // MARK: - Life Cycle
    
    func initVars() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func initNavigationView() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    func initTabBar() {
        let whiteView: UIView = UIView()
        whiteView.backgroundColor = kWHITE
        whiteView.frame = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: kDEVICE_WIDTH, height: kDEVICE_HEIGHT))
        self.tabBar.addSubview(whiteView)

        UITabBar.appearance().tintColor = kGRAY_90
        UITabBar.appearance().backgroundImage = UIImage.imageFromColor(kWHITE)
        UITabBar.appearance().shadowImage = UIImage.imageFromColor(kGRAY_90)
        UITabBar.appearance().selectionIndicatorImage = UIImage.imageFromColor(kGRAY_90)

        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: kGRAY_90, NSAttributedString.Key.font:UIFont.systemFont(ofSize: 9.0)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: kGRAY_90, NSAttributedString.Key.font:UIFont.systemFont(ofSize: 9.0)], for: .disabled)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: kGRAY_90, NSAttributedString.Key.font:UIFont.systemFont(ofSize: 9.0)], for: .selected)

        if let tabBarItems = self.tabBar.items {
            for (index, tabItem) in GeneralHelper.sharedInstance.tabList.enumerated() {
                tabBarItem.tag = index

                let tabBarItem = tabBarItems[index]
                tabBarItem.title = tabItem.title
                tabBarItem.tag = index
                tabBarItem.image = UIImage.init(named: tabItem.iconImage!)
            }
        }
    }
        
    func initViewControllers() {
        var controllers: [UINavigationController] = []
        
        for tabItem in GeneralHelper.sharedInstance.tabList {
            let vc: BaseViewController = GeneralHelper.sharedInstance.makeVC(tabItem.storyBoard, tabItem.viewController)
            vc.tabItem = tabItem
            
            let nc: UINavigationController = UINavigationController.init(rootViewController: vc)
            controllers.append(nc)
        }
        
        self.viewControllers = controllers
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        self.initVars()
        self.initViewControllers()
        self.initTabBar()
    }
     
}

