//
//  MainTabBarController.swift
//  Telegram
//
//  Created by Кирилл on 21.11.2025.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }

    private func setupTabs() {
        let contactsVC = UINavigationController(rootViewController: UIViewController())
        contactsVC.tabBarItem = UITabBarItem(title: "Contacts", image: UIImage(systemName: "person"), tag: 0)
        
        let callsVC = UINavigationController(rootViewController: UIViewController())
        callsVC.tabBarItem = UITabBarItem(title: "Calls", image: UIImage(systemName: "phone.fill"), tag: 1)
        
        let chatsVC = UINavigationController(rootViewController: ChatsViewController())
        chatsVC.tabBarItem = UITabBarItem(title: "Chats", image: UIImage(systemName: "message.fill"), tag: 2)
        
        let settingsVC = UINavigationController(rootViewController: UIViewController())
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 3)
        
        viewControllers = [contactsVC, callsVC, chatsVC, settingsVC]
        
        tabBar.tintColor = .label
        tabBar.backgroundColor = .systemBackground
    }

}
