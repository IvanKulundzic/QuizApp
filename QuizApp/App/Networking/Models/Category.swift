import UIKit

struct Category {

    let type: CategoryNetworkModel

    init(from model: CategoryNetworkModel) {
        self.type = model
    }

    var color: UIColor {
        switch type {
        case .geography:
            return .white
        case .movies:
            return .orange
        case .music:
            return .red
        case .sport:
            return .blue
        }
    }

}
