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
        whiteView.backgroundColor = kGRAY_10
        whiteView.frame = CGRect.init(origin: CGPoint.zero, size: CGSize.init(width: kDEVICE_WIDTH, height: kDEVICE_HEIGHT))
        self.tabBar.addSubview(whiteView)

        UITabBar.appearance().tintColor = kGRAY_10
        UITabBar.appearance().backgroundImage = UIImage.imageFromColor(kWHITE)
        UITabBar.appearance().shadowImage = UIImage.imageFromColor(UIColor(white: 0.9, alpha: 0.0))
        UITabBar.appearance().selectionIndicatorImage = UIImage.imageFromColor(.clear)

        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: kGRAY_10, NSAttributedString.Key.font:UIFont.systemFont(ofSize: 9.0)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: kWHITE, NSAttributedString.Key.font:UIFont.systemFont(ofSize: 9.0)], for: .disabled)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: kWHITE, NSAttributedString.Key.font:UIFont.systemFont(ofSize: 9.0)], for: .selected)

        if let tabBarItems = self.tabBar.items {
            for (index, tabItem) in GeneralHelper.sharedInstance.tabList.enumerated() {
                tabBarItem.tag = index

                let tabBarItem = tabBarItems[index]
                tabBarItem.title = tabItem.title
                tabBarItem.tag = index
            }
        }
    }
    
//    func initTabBar() {
//        self.floatingTabbar = (Bundle.main.loadNibNamed("GeneralFloatingTabbar", owner: self, options: nil)?[0] as! GeneralFloatingTabbar)
//        self.floatingTabbar?.frame = CGRect.init(origin: CGPoint.init(x: (kDEVICE_WIDTH - 224.0) / 2.0, y: kDEVICE_HEIGHT - 70.0 - self.view.safeAreaInsets.bottom), size: CGSize.init(width: 224.0, height: 44.0))
//        self.floatingTabbar?.delegate = self
//        self.view.addSubview(self.floatingTabbar!)
//
//        if let tabBarItems = self.tabBar.items {
//            for (index, tabItem) in GeneralHelper.sharedInstance.tabList.enumerated() {
//                tabBarItem.tag = index
//
//                let tabBarItem: UITabBarItem = tabBarItems[index]
//                tabBarItem.title = tabItem.title
//            }
//        }
//    }
    
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
     
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//
//        self.tabBar.isHidden = true
//        self.tabBar.invalidateIntrinsicContentSize()
//
//        self.floatingTabbar?.frame = CGRect.init(origin: CGPoint.init(x: 20.0, y: kDEVICE_HEIGHT - 56.0 - self.view.safeAreaInsets.bottom), size: CGSize.init(width: kDEVICE_WIDTH - 40.0, height: 56.0))
//    }

}

