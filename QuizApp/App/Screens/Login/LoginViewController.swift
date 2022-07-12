//
//  ViewController.swift
//  QuizApp
//
//  Created by Ivan Kulundžić on 12.07.2022..
//

import UIKit

final class LoginViewController: UIViewController {

    private lazy var loginView = LoginView()

    override func loadView() {
        view = loginView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
