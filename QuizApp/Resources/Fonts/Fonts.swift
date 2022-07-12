//
//  Fonts.swift
//  QuizApp
//
//  Created by Ivan Kulundžić on 12.07.2022..
//

import UIKit

enum Fonts {
    case sourceSansProRegular32
    case sourceSansProBold32
}

extension Fonts {
    var font: UIFont {
        switch self {
        case .sourceSansProRegular32:
            return UIFont(name: "SourceSansPro-Regular", size: 32)!
        case .sourceSansProBold32:
            return UIFont(name: "SourceSansPro-Bold", size: 32)!
        }
    }
}
