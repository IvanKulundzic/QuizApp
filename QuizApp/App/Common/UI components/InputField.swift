import UIKit

final class InputField: UITextField {

    private var showPasswordButton: UIButton!

    enum InputFieldType {

        case email
        case password

    }

    enum PaddingSpace {

        case left(CGFloat)
        case right(CGFloat)
        case equalSpacing(CGFloat)

    }

    var type: InputFieldType = .email {
        didSet {
            style()
        }
    }

    var isActive: Bool = false {
        didSet {
            updateBorders()
        }
    }

    init(type: InputFieldType) {
        super.init(frame: .zero)
        self.type = type
        style()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Private methods
private extension InputField {

    func style() {
        backgroundColor = .white.withAlphaComponent(0.3)
        layer.cornerRadius = 20

        textColor = .white
        tintColor = .white.withAlphaComponent(0.6)
        font = Fonts.sourceSansProSemiBold16.font
        autocapitalizationType = .none
        isSecureTextEntry = type == .password ? true : false

        let titleString = type == .password ? "Password" : "Email"
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.6),
            NSAttributedString.Key.font: Fonts.sourceSansProRegular16.font
        ]
        let attributedPlaceholderString = NSAttributedString(string: titleString, attributes: attributes)
        attributedPlaceholder = attributedPlaceholderString

        addPadding(padding: .left(21))
        addPadding(padding: .right(45))

        addShowPasswordButton()
    }

    func addShowPasswordButton() {
        showPasswordButton = UIButton()
        addSubview(showPasswordButton)
        showPasswordButton.setImage(UIImage.showPassword, for: .normal)
        showPasswordButton.contentMode = .scaleToFill

        showPasswordButton.snp.makeConstraints {
            $0.trailing.equalTo(safeAreaLayoutGuide).inset(20)
            $0.centerY.equalTo(safeAreaLayoutGuide)
            $0.width.height.equalTo(30)
        }

        showPasswordButton.isHidden = type == .password ? false : true
    }

    func updateBorders() {
        layer.borderWidth = isActive ? 1 : 0
        layer.borderColor = isActive ? UIColor.white.cgColor : UIColor.white.withAlphaComponent(0.3).cgColor
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
            rightView = rightPaddingView
            rightViewMode = .always
        case .equalSpacing(let spacing):
            let equalPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: frame.height))
            leftView = equalPaddingView
            leftViewMode = .always
            rightView = equalPaddingView
            rightViewMode = .always
        }
    }

}
