//
//  SceneDelegate.swift
//  Telegram
//
//  Created by Кирилл on 17.11.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        setupGlobalAppearance(for: windowScene.traitCollection)
        let loginVC = LoginViewController()
        let navController = UINavigationController(rootViewController: loginVC)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
    
    func setupGlobalAppearance(for traits: UITraitCollection) {
        let isDark = traits.userInterfaceStyle == .dark
        let tint: UIColor = isDark ? .white : .systemBlue
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor: tint]
        appearance.titleTextAttributes = [.foregroundColor: tint]
        appearance.buttonAppearance.normal.titleTextAttributes = [.foregroundColor: tint]
        appearance.doneButtonAppearance.normal.titleTextAttributes = [.foregroundColor: tint]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        
        UINavigationBar.appearance().tintColor = tint
        UITabBar.appearance().tintColor = tint
        
    }

    func windowScene(_ windowScene: UIWindowScene, didUpdate previousCoordinateSpace: any UICoordinateSpace, interfaceOrientation previousInterfaceOrientation: UIInterfaceOrientation, traitCollection previousTraitCollection: UITraitCollection) {
        if previousTraitCollection.userInterfaceStyle != windowScene.traitCollection.userInterfaceStyle {
            setupGlobalAppearance(for: windowScene.traitCollection)
            
            if let nav = window?.rootViewController as? UINavigationController {
                nav.navigationBar.standardAppearance = UINavigationBar.appearance().standardAppearance
                nav.navigationBar.scrollEdgeAppearance = UINavigationBar.appearance().scrollEdgeAppearance
            }
            
            window?.rootViewController?.view.setNeedsLayout()
            window?.rootViewController?.view.layoutIfNeeded()
        }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {

    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

