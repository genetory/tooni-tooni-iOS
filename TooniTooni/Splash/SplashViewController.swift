//
//  SplashViewController.swift
//  TooniTooni
//
//  Created by GENETORY on 2021/04/13.
//

import UIKit
import FirebaseAuth

class SplashViewController: BaseViewController {
    
    // MARK: - Vars
    
    @IBOutlet weak var activity: GeneralActivity!

    // MARK: - Life Cycle
    
    func initBackgroundView() {
        self.view.backgroundColor = kWHITE
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.initBackgroundView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.startActivity()
        self.sign()
    }
    
}

// MARK: - Auth

extension SplashViewController {
    
    func sign() {
        Auth.auth().signInAnonymously() { (authResult, error) in
            if error == nil, let loginToken = authResult?.user.uid {
                self.signIn(loginToken)
                print("loginToken: \(loginToken)")
            }
            else {
                self.failedSign()
            }
        }
    }
    
    func successSign() {
        DispatchQueue.main.async {
            self.stopActivity()
            self.startApp()
        }
    }
    
    func failedSign() {
        DispatchQueue.main.async {
            self.stopActivity()
            self.retry()
        }
    }
    
    func retry() {
        let alert = UIAlertController.init(title: "알림", message: "앱을 시작할 수 없어요\n잠시 후 다시 시도해주세요 😭", preferredStyle: .alert)
        
        let okAction = UIAlertAction.init(title: "확인", style: .default) { _  in
            self.startActivity()
            self.sign()
        }
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}

// MARK: - Sign

extension SplashViewController {
    
    func signIn(_ loginToken: String) {
        TooniNetworkService.shared.request(to: .sign(loginToken: loginToken), decoder: User.self) { [weak self] response in
            switch response.result {
            case .success:
                guard let user = response.json as? User else { return }
                
                GeneralHelper.sharedInstance.user = user
                GeneralHelper.sharedInstance.user?.loginToken = loginToken
                
                self?.successSign()
            case .failure:
                print(response)
                self?.failedSign()
            }
        }
    }

}

// MARK: - Start

extension SplashViewController {
    
    func startApp() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate
        else {
            return
        }

        sceneDelegate.createTabVC()
    }
    
}

// MARK: - Activity

extension SplashViewController {
    
    func startActivity() {
        if self.activity.isAnimating() { return }
        self.activity.start()
    }
    
    func stopActivity() {
        if !self.activity.isAnimating() { return }
        self.activity.stop()
    }
    
}

