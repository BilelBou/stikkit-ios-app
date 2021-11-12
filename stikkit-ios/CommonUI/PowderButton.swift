import UIKit

enum PowderButtonType {
    case small
    case large
    
    var height: CGFloat {
        switch self {
        case .small:
            return 36
        case .large:
            return 42
        }
    }
    
    var contentEdgeInsets: UIEdgeInsets {
        switch self {
        case .small:
            return UIEdgeInsets(top: 0, left: Margin._24, bottom: 0, right: Margin._24)
        case .large:
            return UIEdgeInsets(top: 0, left: Margin._32, bottom: 0, right: Margin._32)
        }
    }
}

final class PowderButton: UIButton {
    
    init(type: PowderButtonType) {
        super.init(frame: .zero)
        layer.cornerRadius = type.height / 2
        contentEdgeInsets = type.contentEdgeInsets
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: PowderButtonType.large.height)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reset() {
        backgroundColor = nil
        setAttributedTitle(nil, for: .normal)
        self.isEnabled = true
    }
    
    func configure(title: String, isEnabled: Bool = true) {
        backgroundColor = isEnabled ? Color.lightPurple : Color.gray
        setAttributedTitle(title.typography(.button), for: .normal)
        self.isEnabled = isEnabled
    }
}
