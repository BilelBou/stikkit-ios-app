import UIKit
import DesignSystem

enum createType {
    case group, stickers, stickerName(stickerid: String)

    var name: String {
        switch self {
        case .group:
            return "Create group"
        case .stickers:
            return "Add Sticker"
        case .stickerName:
            return "What's your sticker name ?"
        }
    }

    var title: String {
        switch self {
        case .group:
            return "Create a groupe to share your position and your stickers with others"
        case .stickers:
            return "Scan the qr code in the back of your sticker"
        case .stickerName:
            return "Congrats you have a sticker ! Now choose a name for it !"
        }
    }

    var placeHolder: String {
        switch self {
        case .group:
            return "Groupe name"
        case .stickers:
            return "Sticker ID"
        case .stickerName:
            return "Your sticker name"
        }
    }

    var buttonText: String {
        switch self {
        case .group:
            return "Create group"
        case .stickers:
            return "SCAN MY QR CODE"
        case .stickerName:
            return "Next"
        }
    }

    var image: String {
        switch self {
        case .group:
            return "groupImage"
        case .stickers:
            return "stickerImage"
        case .stickerName:
            return "stickerImage"
        }
    }
    
    var isTextField: Bool {
        switch self {
        case .stickers: return false
        default: return true
        }
    }
}

class CreateGroupController: Controller {
    private var type: createType
    private var API: AuthAPI = AuthAPI()

    init(type: createType) {
        self.type = type
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var createGroupLabel = UILabel()..{
        $0.attributedText = type.title.typography(.title2, color: Color.white, alignment: .center)
        $0.numberOfLines = 0
    }

    private lazy var groupeNameTextField = UITextField()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = Color.fieldBackgroundColor
        $0.setIcon(icon: Icon.person.typographyIcon(font: VFont.Icon._16))
        $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
        $0.layer.cornerRadius = 12
        $0.attributedPlaceholder = type.placeHolder.typography(.text, color: Color.lightGray)
        $0.autocorrectionType = .no
        $0.textColor = Color.white
        $0.autocapitalizationType = .none
        $0.isHidden = !type.isTextField
    }

    private lazy var createGroupe = UIButton()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(didTapCreate), for: .touchUpInside)
        $0.backgroundColor = Color.buttonColor
        $0.setAttributedTitle(type.buttonText.typography(.captionStrong), for: .normal)
    }

    private lazy var groupImage = UIImageView()..{
        $0.image = UIImage(named: type.image)
        $0.tintColor = Color.white
    }

    private lazy var stackView = UIStackView()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.spacing = Margin._16
        $0.axis = .vertical
        $0.alignment = .center
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureStyleAndLayout()
        configureNavigationBar(title: type.name, titleColor: Color.white, leftType: .back)
    
        tabBarController?.tabBar.isHidden = true
    }

    private func configureStyleAndLayout() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        view.backgroundColor = Color.backgroundColor

        view.addSubview(stackView)
        stackView.addArrangedSubview(groupImage)
        stackView.addArrangedSubview(createGroupLabel)
        view.addSubview(groupeNameTextField)
        view.addSubview(createGroupe)

        NSLayoutConstraint.activate([

            groupImage.heightAnchor.constraint(equalToConstant: 150),
            groupImage.widthAnchor.constraint(equalToConstant: 150),

            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Margin._100),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin._20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin._20),

            groupeNameTextField.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: Margin._56),
            groupeNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin._20),
            groupeNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin._20),

            createGroupe.topAnchor.constraint(equalTo: groupeNameTextField.bottomAnchor, constant: Margin._56),
            createGroupe.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin._20),
            createGroupe.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin._20),

            createGroupe.heightAnchor.constraint(equalToConstant: 50),

        ])
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    override func didTapBack() {
        navigationController?.popViewController(animated: true)
    }

    @objc func didTapCreate() {
        switch type {
        case .stickers:
            let controller = ScannerViewController()
            controller.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(controller, animated: true)
        case .group:
            AuthAPI.shared.createGroupe(name: groupeNameTextField.text!) { code in
                if code == 201 {
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                } else {
                    print("error")
                }
            }
        case .stickerName(let stickerID):
            guard let stickername = groupeNameTextField.text else { return }
            AuthAPI.shared.updateSticker(id: stickerID, name: stickername)
            navigationController?.popToRootViewController(animated: true)
        }
    }
}
