//
//  SceneDelegate.swift
//  CarAppSOLID
//
//  Created by Sveta on 02.12.2021.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var mainVC: UIViewController?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let scene = scene as? UIWindowScene {
            self.window = UIWindow(windowScene: scene)
            self.mainVC = FirstScreenAssembly.build()
            guard let mainVC = self.mainVC else {
                return
            }
            
            let navVC = UINavigationController(rootViewController: mainVC)
            navVC.title = "First"
            self.window!.rootViewController = navVC
            self.window?.makeKeyAndVisible()
        }
    }
}
