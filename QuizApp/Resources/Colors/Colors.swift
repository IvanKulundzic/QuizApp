//
//  Colors.swift
//  QuizApp
//
//  Created by Ivan Kulundžić on 12.07.2022..
//

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
