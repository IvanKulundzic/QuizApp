import UIKit

extension UIImageView {

    func style(with image: String?, contentMode: ContentMode, radius: CGFloat) {
        self.image = UIImage(named: image ?? "")
        self.contentMode = contentMode
        self.layer.cornerRadius = radius
    }

}
