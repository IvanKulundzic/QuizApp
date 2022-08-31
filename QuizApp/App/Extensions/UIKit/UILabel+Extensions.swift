import UIKit

extension UILabel {

    func style(with text: String?, color: UIColor, alignment: NSTextAlignment, font: UIFont) {
        self.text = text ?? ""
        self.textColor = color
        self.textAlignment = alignment
        self.font = font
    }

}
