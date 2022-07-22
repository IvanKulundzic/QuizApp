import UIKit

enum Fonts {

    case sourceSansProRegular16
    case sourceSansProRegular32
    case sourceSansProBold16
    case sourceSansProBold20
    case sourceSansProBold24
    case sourceSansProBold28
    case sourceSansProBold32
    case sourceSansProSemiBold12
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
        case .sourceSansProBold20:
            return UIFont(name: "SourceSansPro-Bold", size: 20)!
        case .sourceSansProBold24:
            return UIFont(name: "SourceSansPro-Bold", size: 24)!
        case .sourceSansProBold28:
            return UIFont(name: "SourceSansPro-Bold", size: 28)!
        case .sourceSansProBold32:
            return UIFont(name: "SourceSansPro-Bold", size: 32)!
        case .sourceSansProSemiBold12:
            return UIFont(name: "SourceSansPro-SemiBold", size: 12)!
        case .sourceSansProSemiBold16:
            return UIFont(name: "SourceSansPro-SemiBold", size: 16)!
        }
    }

}
