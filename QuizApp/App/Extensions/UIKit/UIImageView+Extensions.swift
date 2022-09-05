import UIKit

extension UIImageView {

    func style(with image: String? = nil, contentMode: ContentMode, radius: CGFloat) {
        if let image = image {
            self.image = UIImage(named: image)
        }
        self.contentMode = contentMode
        self.layer.cornerRadius = radius
    }

}
