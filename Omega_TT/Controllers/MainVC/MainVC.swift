//
//  ViewController.swift
//  Omega_TT
//
//  Created by Oleg on 08.02.2022.
//

import UIKit

class MainVC: UIViewController {
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var loginLabel: UILabel = {
        let label = UILabel()
        label.text = "iTunes"
        label.font = UIFont.systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var emailTF: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter email"
        textField.layer.shadowOpacity = 0.5
        textField.layer.shadowRadius = 1
        textField.layer.shadowOffset = CGSize(width: 0, height: 1)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var passwordTF: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter password"
        textField.isSecureTextEntry = true
        textField.layer.shadowOpacity = 0.5
        textField.layer.shadowRadius = 1
        textField.layer.shadowOffset = CGSize(width: 0, height: 1)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var singUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.setTitle("SingUP", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(singUpButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var singInButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemGreen
        button.setTitle("SingIn", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(singInButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var textFieldsStackView = UIStackView()
    var buttonsStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupDelegate()
        setConstrains()
        registeredKeyboardNotification()
    }
    
    deinit {
        remoteKeyboardNitification()
    }
    
    //MARK: SetupDelegate
    private func setupDelegate() {
        emailTF.delegate = self
        passwordTF.delegate = self
    }
    
    //MARK: SingUpButtonTapped
    @objc private func singUpButtonTapped() {
        let singUpViewController = SingUpVC()
        self.present(singUpViewController, animated: true)
    }
    
    //MARK: SingInButtonTapped
    @objc private func singInButtonTapped() {
        let mail = emailTF.text ?? ""
        let password = passwordTF.text ?? ""
        let user = findUserDataBase(mail: mail)
        
        if user == nil {
            loginLabel.text = "User is not found"
            loginLabel.textColor = .systemRed
        } else if user?.password == password {
            let navVC = UINavigationController(rootViewController: AlbumsTableVC())
            navVC.modalPresentationStyle = .fullScreen
            self.present(navVC, animated: true)
            
            guard let activeUser = user else {return}
            DataBase.shared.saveActiveUser(user: activeUser)
            
        } else {
            loginLabel.text = "Wrong password"
            loginLabel.textColor = .systemRed
        }
        
    }
    
    //MARK: FindUserDataBase
    private func findUserDataBase(mail: String) -> User? {
        let dataBase = DataBase.shared.users
        
        for user in dataBase {
            if user.email == mail {
                return user
            }
        }
        return nil
    }
    
}








