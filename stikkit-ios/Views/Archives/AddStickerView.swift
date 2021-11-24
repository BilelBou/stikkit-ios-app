import UIKit
import MHLoadingButton

import DesignSystem

class AddStickerView: UIView {
    let APICalls = AuthAPI()

    private lazy var title: UILabel = UILabel()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.attributedText = "Enter the code in the back of your new sticker!".typography(.button, color: Color.white)
        $0.numberOfLines = 2
    }
    
    lazy var linkButton: LoadingButton = LoadingButton(frame: .zero, text:"Link!", textColor: Color.white, bgColor: Color.buttonColor)..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.cornerRadius = 15
        $0.isLoading = false
        $0.indicator = BallPulseSyncIndicator(color: Color.white)
    }
    
    private lazy var containerView: UIView = UIView()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = Color.containerColor
        $0.layer.cornerRadius = 20
    }
    
    lazy var textFieldCode: UITextField = UITextField()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setIcon(icon: Icon.plus.unicode.typographyIcon(font: VFont.Icon._16))
        $0.backgroundColor = Color.fieldBackgroundColor
        $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
        $0.layer.cornerRadius = 12
        $0.attributedPlaceholder = "Your sticker code!".typography(.caption, color: Color.lightGray)
        $0.autocorrectionType = .no
        $0.textColor = Color.white
        $0.autocapitalizationType = .none
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        configureGesture()
        fadeIn()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.backgroundColor = Color.backgroundColor.withAlphaComponent(0.7)
        self.frame = UIScreen.main.bounds
        
        self.addSubview(containerView)
        containerView.addSubview(title)
        containerView.addSubview(textFieldCode)
        containerView.addSubview(linkButton)
        
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7),
            containerView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6),
            containerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            title.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin._10),
            title.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Margin._10),
            title.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Margin._20),
            
            textFieldCode.topAnchor.constraint(equalTo: title.bottomAnchor, constant: Margin._20),
            textFieldCode.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Margin._20),
            textFieldCode.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin._20),
            
            linkButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Margin._30),
            linkButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Margin._30),
            linkButton.topAnchor.constraint(equalTo: textFieldCode.bottomAnchor, constant: Margin._20),
            
        ])
    }
    
    private func configureGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        self.addGestureRecognizer(tap)
    }
    
    @objc func didTapView() {
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn) {
            self.containerView.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
            self.alpha = 0
        } completion: { (complete) in
            if complete {
                self.removeFromSuperview()
            }
        }
    }
    
    @objc func didTapLink() {
        APICalls.linkSticker(stickerId: textFieldCode.text!) { (statusCode) in
            if statusCode == 201 {
                DispatchQueue.main.async {
                    self.didTapView()
                }
            } else {
                print("error")
            }
        }
    }
    
    func fadeIn() {
        self.containerView.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
        self.alpha = 0
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn) {
            self.containerView.transform = .identity
            self.alpha = 1
        }
    }
}
