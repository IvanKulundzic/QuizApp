import UIKit

enum Colors {

    /// Login screen
    case loginBackground

}

extension Colors {

    var color: UIColor {
        switch self {
        case .loginBackground:
            return UIColor(named: "LoginBackground")!
        }
    }

}
