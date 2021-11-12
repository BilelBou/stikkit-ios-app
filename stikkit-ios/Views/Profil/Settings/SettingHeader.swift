import UIKit

final class SettingHeader: UICollectionReusableView {

    static let height: CGFloat = 56

    private lazy var titleLabel = UILabel()..{
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
        addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }

    func configure(_ title: String) {
        titleLabel.attributedText = title.typography(.textStrong, color: Color.buttonColor)
    }
}
