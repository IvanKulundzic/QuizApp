import UIKit

enum Fonts {

    case sourceSansProRegular16
    case sourceSansProRegular32
    case sourceSansProBold16
    case sourceSansProBold32
    case sourceSansProSemiBold16

}

extension Fonts {

    var font: UIFont {
        switch self {
        case .sourceSansProRegular16:
            return UIFont(name: "SourceSansPro-Regular", size: 16)!
        case .sourceSansProRegular32:
            return UIFont(name: "SourceSansPro-Regular", size: 32)!
        case .sourceSansProBold16:
            return UIFont(name: "SourceSansPro-Bold", size: 16)!
        case .sourceSansProBold32:
            return UIFont(name: "SourceSansPro-Bold", size: 32)!
        case .sourceSansProSemiBold16:
            return UIFont(name: "SourceSansPro-SemiBold", size: 16)!
        }
    }

}
