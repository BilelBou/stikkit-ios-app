import UIKit

extension UITableViewCell: ReusableView { }

extension UITableView {
    
    func registerHeader(_ type: UITableViewHeaderFooterView.Type) {
        register(type, forHeaderFooterViewReuseIdentifier: String(describing: type))
    }
    
    func dequeueHeader<T: UITableViewHeaderFooterView>() -> T {
        let cell = dequeueReusableHeaderFooterView(withIdentifier: String(describing: T.self))
        return cell as! T
    }
    
    func register(_ type: UITableViewCell.Type) {
        register(type, forCellReuseIdentifier: type.reuseIdentifier)
    }
    
    func dequeue<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath)
        return cell as! T
    }
    
    func registerFooter(_ type: UITableViewHeaderFooterView.Type) {
        register(type, forHeaderFooterViewReuseIdentifier: String(describing: type))
    }
    
    func dequeueFooter<T: UITableViewHeaderFooterView>() -> T {
        let cell = dequeueReusableHeaderFooterView(withIdentifier: String(describing: T.self))
        return cell as! T
    }
}
