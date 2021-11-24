import UIKit

import DesignSystem

class IconButton: UIView {
    private let icon: String
    private let title: String

    private lazy var iconLabel = UILabel()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.attributedText = icon.typographyIcon(font: VFont.Icon._20)
    }

    private lazy var titleLabel = UILabel()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.attributedText = title.typography(.button)
    }

    init(icon: String, title: String) {
        self.icon = icon
        self.title = title
        super.init(frame: .zero)
        configureStyleAndLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureStyleAndLayout() {
        backgroundColor = Color.buttonColor
        addSubview(iconLabel)
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            iconLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin._10),
            iconLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            titleLabel.leadingAnchor.constraint(equalTo: iconLabel.trailingAnchor, constant: Margin._10),
            titleLabel.centerYAnchor.constraint(equalTo: iconLabel.centerYAnchor),
        ])
    }

}
