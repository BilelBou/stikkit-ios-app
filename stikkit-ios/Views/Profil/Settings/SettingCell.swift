import UIKit
import DesignSystem

final class SettingCell: UICollectionViewCell {

    static let height: CGFloat = 56

    private lazy var settingIcon = UILabel()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private lazy var settingLabel = UILabel()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private lazy var actionLabel = UILabel()..{
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStyleAndLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureStyleAndLayout() {
        backgroundColor = Color.backgroundColor
        contentView.addSubview(settingIcon)
        contentView.addSubview(settingLabel)
        contentView.addSubview(actionLabel)
        NSLayoutConstraint.activate([
            settingIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            settingIcon.leadingAnchor.constraint(equalTo: leadingAnchor),

            settingLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            settingLabel.leadingAnchor.constraint(equalTo: settingIcon.trailingAnchor, constant: Margin._12),

            actionLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            actionLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    func configure(_ setting: Setting) {
        settingIcon.attributedText = setting.icon.typographyIcon(font: VFont.Icon._24)
        settingLabel.attributedText = setting.title.typography(.text)
        actionLabel.attributedText = setting.actionTitle?.typography(.text, color: Color.buttonColor.withAlphaComponent(0.5))
    }
}
