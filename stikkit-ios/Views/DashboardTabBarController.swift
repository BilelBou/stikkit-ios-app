//
//  DashboardTabBarController.swift
//  stikkit-ios
//
//  Created by Bilel Bouricha on 13/09/2021.
//
import MapKit
import UIKit

class DashboardTabBarController: UITabBarController {
    let defaults = UserDefaults.standard
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = Color.backgroundColor
            tabBar.standardAppearance = appearance
            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !checkLogin() {
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
        } else {
            AuthAPI.shared.getUserById(id: defaults.string(forKey: "id")!) { user in
                self.user = user
                
                DispatchQueue.main.async {
                    self.checkLocalization()
                }
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
    }

    private func checkLogin() -> Bool {
        if defaults.string(forKey: "firstName") == nil  {
            return false
        } else {
            return true
        }
    }
    
    private func presentView() {
        guard let user = user else { return }
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
    
    private func presentAuthorizationView() {
        let vc = AuthorizationController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    private func checkLocalization() {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            presentAuthorizationView()
        default:
            presentView()
        }
    }
}
