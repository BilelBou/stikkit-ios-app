import UIKit

struct RegularExpression {
    static let username: NSRegularExpression = NSRegularExpression("[a-z0-9]+[ \\-_.]?[a-z0-9]*", options: .caseInsensitive)
    static let email: NSRegularExpression = NSRegularExpression("[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,64}", options: .caseInsensitive)
}

extension NSRegularExpression {
    convenience init(_ pattern: String, options: NSRegularExpression.Options) {
        do {
            try self.init(pattern: pattern, options: options)
        } catch {
            preconditionFailure("Illegal regular expression: \(pattern).")
        }
    }
}
