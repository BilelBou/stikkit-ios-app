//
//  DashboardTabBarController.swift
//  stikkit-ios
//
//  Created by Bilel Bouricha on 13/09/2021.
//

import UIKit

class DashboardTabBarController: UITabBarController {
    let defaults = UserDefaults.standard
    var user: Welcome?

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = Color.backgroundColor
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
        //checkLogin()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AuthAPI.shared.getUserById(id: defaults.string(forKey: "id")!) { user in
            self.user = user

            DispatchQueue.main.async {
                let item1 = MapViewController(user: user)
                item1.navigationController?.setNavigationBarHidden(true, animated: false)
                let icon1 = UITabBarItem(title: "Stickers", image: UIImage(systemName: "map"), selectedImage: UIImage(systemName: "map.fill"))
                icon1.badgeColor = Color.buttonColor
                item1.tabBarItem = icon1


                let item2 = UINavigationController(rootViewController: MyProfileViewController(user: user))
                let icon2 = UITabBarItem(title: "Me", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
                icon2.badgeColor = Color.buttonColor
                item2.tabBarItem = icon2

                let controllers = [item1, item2]
                self.viewControllers = controllers
            }
        }
    }

    private func checkLogin() {
        if defaults.string(forKey: "firstName") == nil  {
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
        }
    }
}
