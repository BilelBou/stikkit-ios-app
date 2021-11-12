import UIKit

enum Direction {
    case up
    case left
    case right
    case down
    
    var icon: String {
        switch self {
        case .up:
            return Icon.App.arrowUp
        case .left:
            return Icon.App.arrowLeft
        case .right:
            return Icon.App.arrowRight
        case .down:
            return Icon.App.arrowDown
        }
    }
}

final class ArrowCircleButton: UIButton {
    
    private let size: CGSize
    
    init(direction: Direction,size: CGSize, isEnabled: Bool = false) {
        self.size = size
        super.init(frame: .zero)
        configureStyleAndLayout()
        configure(direction: direction, isEnabled: isEnabled)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureStyleAndLayout() {
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
        layer.cornerRadius = size.height / 2
    }
    
    func configure(direction: Direction, isEnabled: Bool) {
        let backgroundColor: UIColor = isEnabled ? Color.lightPurple : Color.gray
        let iconColor: UIColor = isEnabled ? Color.white : Color.lightGray
        self.isEnabled = isEnabled
        self.backgroundColor = backgroundColor
        setAttributedTitle(direction.icon.typographyIcon(iconColor, font: Font.Icon.custom(with: size.height / 1.75)), for: .normal)
    }
}
