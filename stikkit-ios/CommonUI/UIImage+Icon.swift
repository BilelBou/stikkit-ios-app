import UIKit

extension UIImage {
    
    func imageFromIcon(icon: String, color: UIColor = Color.white, fontSize: CGFloat) -> UIImage {
        return UIGraphicsImageRenderer(size: CGSize(width: fontSize, height: fontSize)).image { _ in
            let attributedString = NSAttributedString(string: icon, attributes: [.foregroundColor: color, .font: Font.Icon.custom(with: fontSize)])
            attributedString.draw(at: .zero)
        }
    }
}
