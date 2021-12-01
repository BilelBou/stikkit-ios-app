import UIKit

import DesignSystem

final class EditUsernameController: Controller {
    let defaults = UserDefaults.standard

    private lazy var usernameTextField = UITextField()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.delegate = self
        $0.attributedPlaceholder = "username".typography(.text, color: Color.gray)
        $0.attributedText = username.typography(.text)
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.returnKeyType = .done
        $0.becomeFirstResponder()
        $0.addTarget(self, action: #selector(didChangeText), for: .editingChanged)
    }

    private var username: String
    private let id: String
    
    init(username: String, id: String) {
        self.username = username
        self.id = id
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureStyleAndLayout()

        configureNavigationBar(title: "Edit username", leftType: .back, rightType: .done, rightColor: Color.buttonColor)
    }
    
    private func configureStyleAndLayout() {
        view.backgroundColor = Color.backgroundColor
        view.addSubview(usernameTextField)
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Margin._32),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin._16),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Margin._16),
        ])
    }
    
    override func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
    
    override func didTapDone() {
        guard let text: String = usernameTextField.text else { return }
        AuthAPI.shared.updateUsername(id: id, username: text)
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func didChangeText() {
        guard let text: String = usernameTextField.text else { return }
        if text.count < 6 {
            configureNavigationBar(title: "Edit username", leftType: .back, rightType: .done, rightColor: Color.lightGray)
        }
    }
}

extension EditUsernameController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        didTapDone()
        return true
    }
}
