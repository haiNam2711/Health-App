
//  SceneDelegate.swift
//  HealthApp
//
//  Created by Hai Nam on 30/11/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let userDefault = UserDefault()
        let navController : UINavigationController
        if userDefault.loadUser() != nil {
            navController = UINavigationController(rootViewController: HomeViewController())
        } else {
            navController = UINavigationController(rootViewController: IntroViewController())
        }
        if let font = GetFont.nunitoBold(18) {
            navController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font]
        }
        window.rootViewController = navController
        window.makeKeyAndVisible()
        self.window = window
    }
}

