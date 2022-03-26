//
//  UserInfoViewController.swift
//  Omega_TT
//
//  Created by Oleg on 08.02.2022.
//

import UIKit


class UserInfoVC: UIViewController {
    
     var firstNameLabel: UILabel = {
        let label = UILabel()
        label.text = "First Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     var secondNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Second Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     var ageLabel: UILabel = {
        let label = UILabel()
        label.text = "Age"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     var phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Phone"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     var stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
        setModel()
    }
    
    //MARK: SetModel
    private func setModel() {
        guard let activeUser = DataBase.shared.activeUsers else {return}
        
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "dd.MM.yyyy"
        let dateString = dataFormatter.string(from: activeUser.age)
        
        firstNameLabel.text = activeUser.firstName
        secondNameLabel.text = activeUser.secondName
        phoneLabel.text = activeUser.phone
        emailLabel.text = activeUser.email
        passwordLabel.text = activeUser.password
        ageLabel.text = dateString
        
    }
    
}


