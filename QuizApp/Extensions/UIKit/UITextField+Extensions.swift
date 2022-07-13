import UIKit

extension UITextField {

    enum PaddingSpace {
        case left(CGFloat)
        case right(CGFloat)
        case equalSpacing(CGFloat)
    }

    func addPadding(padding: PaddingSpace) {
        leftViewMode = .always
        layer.masksToBounds = true

        switch padding {
        case .left(let spacing):
            let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: frame.height))
            leftView = leftPaddingView
            leftViewMode = .always
        case .right(let spacing):
            let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: frame.height))
            leftView = rightPaddingView
            rightViewMode = .always
        case .equalSpacing(let spacing):
            let equalPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: frame.height))
            leftView = equalPaddingView
            leftViewMode = .always
            rightView = equalPaddingView
            rightViewMode = .always
        }
    }

    func style() {
        backgroundColor = .white.withAlphaComponent(0.3)
        layer.cornerRadius = 20
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1

        textColor = .white
        tintColor = .white.withAlphaComponent(0.6)
        font = Fonts.sourceSansProSemiBold16.font


        let titleString = "Email"
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.6),
            NSAttributedString.Key.font: Fonts.sourceSansProRegular16.font
        ]
        let attributedPlaceholderString = NSAttributedString(string: titleString, attributes: attributes)
        attributedPlaceholder = attributedPlaceholderString
    }

}
