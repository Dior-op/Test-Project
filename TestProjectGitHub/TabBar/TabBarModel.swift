import SwiftUI


enum TabItem: String, CaseIterable {
    case home
    case favorites
    case profile
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .favorites: return "Favorites"
        case .profile: return "Profile"
        }
    }
    
    var icon: String {
        switch self {
        case .home: return "house"
        case .favorites: return "heart"
        case .profile: return "person"

        }
    }
}
