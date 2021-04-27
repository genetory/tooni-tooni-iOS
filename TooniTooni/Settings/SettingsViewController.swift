//
//  SettingsViewController.swift
//  TooniTooni
//
//  Created by GENETORY on 2021/04/12.
//

import UIKit

class SettingsViewController: BaseViewController {

    // MARK: - Vars
    
    @IBOutlet weak var navigationView: GeneralNavigationView!
    
    // MARK: - Life Cycle
    
    func initBackgroundView() {
        self.view.backgroundColor = .white
    }
    
    func initNavigationView() {
        self.navigationView.title(self.tabItem?.title)
        self.navigationView.bigTitle(self.showBigTitle)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.initBackgroundView()
        self.initNavigationView()
    }

}

