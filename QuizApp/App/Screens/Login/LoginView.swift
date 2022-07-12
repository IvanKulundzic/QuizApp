//
//  LoginView.swift
//  QuizApp
//
//  Created by Ivan Kulundžić on 12.07.2022..
//

import UIKit
import SnapKit

protocol ConstructViewsProtocol {

    func createViews()
    func styleViews()
    func defineLayoutForViews()

}

final class LoginView: UIView {

    private lazy var titleLabel = UILabel()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - ConstructViewsProtocol methods
extension LoginView: ConstructViewsProtocol {

    func setupView() {
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    func createViews() {
        addSubview(titleLabel)
    }

    func styleViews() {
        backgroundColor = Colors.loginBackground.color

        titleLabel.text = "PopQuiz"
        titleLabel.textColor = .white
        titleLabel.font = Fonts.sourceSansProRegular32.font
    }

    func defineLayoutForViews() {
        titleLabel.snp.makeConstraints {
            $0.centerX.equalTo(safeAreaLayoutGuide)
            $0.top.equalTo(safeAreaLayoutGuide).offset(80)
        }
    }

}
