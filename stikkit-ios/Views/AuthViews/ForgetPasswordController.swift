//
//  ViewController.swift
//  stikkit-ios
//
//  Created by Bilel Bouricha on 12/04/2021.
//

import UIKit
import MHLoadingButton

import DesignSystem

class ForgetPasswordController: Controller {
    
    private lazy var containerView: UIView = UIView()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = Color.containerColor
        $0.layer.cornerRadius = 12
    }
    
    private lazy var emailField: UITextField = UITextField()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setIcon(icon: Icon.person.typographyIcon(font: VFont.Icon._16))
        $0.backgroundColor = Color.fieldBackgroundColor
        $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
        $0.layer.cornerRadius = 12
        $0.attributedPlaceholder = "Email".typography(.caption, color: Color.lightGray)
        $0.autocorrectionType = .no
        $0.textColor = Color.white
        $0.autocapitalizationType = .none
    }
    
    private lazy var sendEmailButton: LoadingButton = LoadingButton(frame: .zero, text:"Send email", textColor: Color.white, bgColor: Color.buttonColor)..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.cornerRadius = 20
        $0.isLoading = false
        $0.indicator = BallPulseSyncIndicator(color: Color.white)
        $0.addTarget(self, action: #selector(didTapSendEmail), for: .touchUpInside)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTapGesture()
        configureNavigationBar(title: "Forgot password", titleColor: VColor.white, leftType: .back)
        configureStyleAndLayout()
    }
    
    private func configureStyleAndLayout() {
        self.view.backgroundColor = Color.backgroundColor
        self.view.addSubview(containerView)
        containerView.addSubview(emailField)
        containerView.addSubview(sendEmailButton)
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 260),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin._20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin._20),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            emailField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            emailField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin._20),
            emailField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Margin._20),
            
            sendEmailButton.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Margin._20),
            sendEmailButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            sendEmailButton.widthAnchor.constraint(equalToConstant: 200),
            sendEmailButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    @objc private func didTapSendEmail(_ sender: LoadingButton) {
        if sender.isLoading {
            sender.hideLoader()
        } else {
            sender.showLoader(userInteraction: true)
        }
        guard let email = emailField.text else { return }
        AuthAPI.shared.sendEmailPassword(email: email) { state in
            sender.hideLoader()
            if state {
                // OK
                print("ok")
            } else {
                //NOT OK
                print("not ok")
            }
        }
    }
    
    @objc func didTapView(_ sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    private func configureTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
    }
    
    override func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
}
