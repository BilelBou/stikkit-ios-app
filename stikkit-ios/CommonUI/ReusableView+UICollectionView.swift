import UIKit

extension UICollectionReusableView: ReusableView { }

extension UICollectionView {

    func dequeueSupplementaryView<T: UICollectionReusableView>(of kind: String, for indexPath: IndexPath) -> T {
        let supplementaryView = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.reuseIdentifier, for: indexPath)
        return supplementaryView as! T
    }

    func register(_ type: UICollectionReusableView.Type, forSupplementaryViewOfKind kind: String) {
        register(type,forSupplementaryViewOfKind: kind, withReuseIdentifier: type.reuseIdentifier)
    }

    func dequeue<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath)
        return cell as! T
    }

    func register(_ type: UICollectionViewCell.Type) {
        register(type, forCellWithReuseIdentifier: type.reuseIdentifier)
    }
}
