//
//  AuthorizationController.swift
//  stikkit-ios
//
//  Created by Bilel Bouricha on 16/11/2021.
//
import MapKit
import UIKit
import Lottie

class AuthorizationController: UIViewController {
    fileprivate let locationManager: CLLocationManager = CLLocationManager()
    
    private lazy var label = UILabel()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.attributedText = "Stikkit need to acces to your position to access the map !".typography(.title3, color: Color.white)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    private lazy var button = UIButton()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setAttributedTitle("OK".typography(.button), for: .normal)
        $0.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        $0.backgroundColor = Color.buttonColor
        $0.layer.cornerRadius = 20
    }
    
    private lazy var animationView = AnimationView(name: "route")..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.loopMode = .loop
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        configureStyleAndLayout()
    }
    
    private func configureStyleAndLayout() {
        view.addSubview(label)
        view.addSubview(button)
        view.addSubview(animationView)
        view.backgroundColor = Color.backgroundColor
        
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -Margin._20),
            animationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Margin._20),
            
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin._16),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin._16),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Margin._16),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin._16),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin._16),
            button.heightAnchor.constraint(equalToConstant: 45)
            
        ])
        
        animationView.play()
    }
    
    @objc func didTapButton() {
        locationManager.requestWhenInUseAuthorization()
    }
}

extension AuthorizationController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .notDetermined {
            dismiss(animated: true)
        }
    }
}
