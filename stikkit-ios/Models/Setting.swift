enum Setting {

    case language
    case editUsername
    case logout

    var icon: String {
        switch self {
        case .language: return Icon.App.zoomOut
        case .editUsername: return Icon.App.user
        case .logout: return Icon.App.home
        }
    }

    var title: String {
        switch self {
        case .language: return "Language"
        case .editUsername: return "Edit username"
        case .logout: return "Log out"
        }
    }

    var actionTitle: String? {
        self == .language ? "coming soon" : nil
    }
}


enum SettingsSection: CaseIterable {

    case preferences
    case account

    var title: String {
        switch self {
        case .preferences: return "Preferences"
        case .account: return "Account"
        }
    }

    var settings: [Setting] {
        switch self {
        case .preferences: return [.language]
        case .account: return [.editUsername, .logout]
        }
    }
}
