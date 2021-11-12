//
//  RegisterViewController.swift
//  stikkit-ios
//
//  Created by Bilel Bouricha on 21/04/2021.
//

import UIKit
import Hero
import MHLoadingButton


class RegisterViewController: UIViewController {
    let APICalls = AuthAPI()

    private lazy var containerView: UIView = UIView()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = Color.containerColor
        $0.layer.cornerRadius = 12
    }
    
    private lazy var emailField: UITextField = UITextField()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setIcon(icon: Icon.App.user.typographyIcon(font: Font.Icon._16))
        $0.backgroundColor = Color.fieldBackgroundColor
        $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
        $0.layer.cornerRadius = 12
        $0.attributedPlaceholder = "Email".typography(.caption, color: Color.lightGray)
        $0.autocorrectionType = .no
        $0.textColor = Color.white
        $0.autocapitalizationType = .none
    }
    
    private lazy var passwordField: UITextField = UITextField()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = Color.fieldBackgroundColor
        $0.setIcon(icon: Icon.App.bell.typographyIcon(font: Font.Icon._16))
        $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
        $0.layer.cornerRadius = 12
        $0.attributedPlaceholder = "Password".typography(.caption, color: Color.lightGray)
        $0.leftViewMode = .always
        $0.autocorrectionType = .no
        $0.textColor = Color.white
        $0.autocapitalizationType = .none
        $0.isSecureTextEntry = true
    }
    
    private lazy var firstNameField: UITextField = UITextField()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setIcon(icon: Icon.App.user.typographyIcon(font: Font.Icon._16))
        $0.backgroundColor = Color.fieldBackgroundColor
        $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
        $0.layer.cornerRadius = 12
        $0.attributedPlaceholder = "First Name".typography(.caption, color: Color.lightGray)
        $0.autocorrectionType = .no
        $0.textColor = Color.white
        $0.autocapitalizationType = .none
    }
    
    private lazy var lastNameField: UITextField = UITextField()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setIcon(icon: Icon.App.user.typographyIcon(font: Font.Icon._16))
        $0.backgroundColor = Color.fieldBackgroundColor
        $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
        $0.layer.cornerRadius = 12
        $0.attributedPlaceholder = "Last Name".typography(.caption, color: Color.lightGray)
        $0.autocorrectionType = .no
        $0.textColor = Color.white
        $0.autocapitalizationType = .none
    }

    
    private lazy var selectionIndicator: UILabel = UILabel()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = Color.white
    }
    
    private lazy var loginChooseButton: UIButton = UIButton()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = Color.containerColor
        $0.setAttributedTitle("LOG IN".typography(.text, color: Color.white.withAlphaComponent(0.5)), for: .normal)
        $0.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
    }
    
    private lazy var registerChooseButton: UIButton = UIButton()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = Color.containerColor
        $0.setAttributedTitle("SIGN UP".typography(.textStrong, color: Color.white), for: .normal)
    }
    
    private lazy var registerButton: LoadingButton = LoadingButton(frame: .zero, text:"Sign Up", textColor: Color.white, bgColor: Color.buttonColor)..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.cornerRadius = 20
        $0.isLoading = false
        $0.indicator = BallPulseSyncIndicator(color: Color.white)
        $0.addTarget(self, action: #selector(didTryToRegister), for: .touchUpInside)
    }
    
    private lazy var errorLabel: UILabel = UILabel()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isHidden = true
        $0.attributedText = "This email is already used!".typography(.caption, color: Color.red)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTapGesture()
        hero.isEnabled = true
        containerView.hero.id = "containerView"
        registerButton.hero.id = "button"
        selectionIndicator.hero.id = "selection"
        emailField.hero.id = "emailField"
        passwordField.hero.id = "passwordField"
        configureStyleAndLayout()
    }
    
    private func configureStyleAndLayout() {
        self.view.backgroundColor = Color.backgroundColor
        self.view.addSubview(containerView)
        
        containerView.addSubview(emailField)
        containerView.addSubview(passwordField)
        containerView.addSubview(registerButton)
        containerView.addSubview(loginChooseButton)
        containerView.addSubview(registerChooseButton)
        containerView.addSubview(firstNameField)
        containerView.addSubview(lastNameField)
        containerView.addSubview(errorLabel)
        registerChooseButton.addSubview(selectionIndicator)

        

        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 350),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin._20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin._20),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            loginChooseButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Margin._10),
            loginChooseButton.bottomAnchor.constraint(equalTo: firstNameField.topAnchor, constant: -Margin._20),
            loginChooseButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin._20),

            registerChooseButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Margin._10),
            registerChooseButton.bottomAnchor.constraint(equalTo: firstNameField.topAnchor, constant: -Margin._20),
            registerChooseButton.leadingAnchor.constraint(equalTo: loginChooseButton.trailingAnchor, constant: Margin._10),
            
            selectionIndicator.leadingAnchor.constraint(equalTo: registerChooseButton.leadingAnchor),
            selectionIndicator.trailingAnchor.constraint(equalTo: registerChooseButton.trailingAnchor),
            selectionIndicator.bottomAnchor.constraint(equalTo: registerChooseButton.bottomAnchor),
            selectionIndicator.heightAnchor.constraint(equalToConstant: 2),

            firstNameField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin._20),
            firstNameField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Margin._20),
            
            lastNameField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin._20),
            lastNameField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Margin._20),
            lastNameField.topAnchor.constraint(equalTo: firstNameField.bottomAnchor, constant: Margin._20),
            
            emailField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin._20),
            emailField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Margin._20),
            emailField.topAnchor.constraint(equalTo: lastNameField.bottomAnchor, constant: Margin._20),

            passwordField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin._20),
            passwordField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Margin._20),
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: Margin._20),
            
            errorLabel.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: Margin._10),
            errorLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            registerButton.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Margin._20),
            registerButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            registerButton.widthAnchor.constraint(equalToConstant: 200),
            registerButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    @objc private func didTryToRegister(_ sender: LoadingButton) {
        if sender.isLoading {
            sender.hideLoader()
        } else {
            sender.showLoader(userInteraction: true)
        }
        APICalls.register(firstName: firstNameField.text!, lastName: lastNameField.text!, email: emailField.text!, password: passwordField.text!) { (statusCode) in
            if statusCode == 201 {
                print("Register ok")
                sender.hideLoader()
                DispatchQueue.main.async {
                    let loginVC = LoginViewController()
                    loginVC.modalPresentationStyle = .fullScreen
                    loginVC.heroModalAnimationType = HeroDefaultAnimationType.fade
                    self.present(loginVC, animated: true, completion: nil)
                }
            } else {
                print("Register Failed")
                DispatchQueue.main.async {
                    self.errorLabel.isHidden = false
                }
                sender.hideLoader()
            }
        }
    }
    
    private func configureTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tap)
    }
    
    @objc func didTapView(_ sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc private func didTapLogin() {
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .fullScreen
        loginVC.heroModalAnimationType = HeroDefaultAnimationType.fade
        present(loginVC, animated: true, completion: nil)
    }
}
