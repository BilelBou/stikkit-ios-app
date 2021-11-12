import UIKit

@propertyWrapper
struct UserDefault<DataType> {
    let key: String
    let defaultValue: DataType
    var wrappedValue: DataType {
        get {
            return UserDefaults.standard.object(forKey: key) as? DataType ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

struct Defaults {
    @UserDefault(key: "isFirstLauchTopPosters", defaultValue: false)
    static var isFirstLaunchTopPosters
    
    @UserDefault(key: "searchHistories", defaultValue: Data())
    static var searchHistories
}
