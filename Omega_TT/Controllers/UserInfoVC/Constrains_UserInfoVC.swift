//
//  Constrains_AlbumsTableVC.swift
//  Omega_TT
//
//  Created by Oleg on 11.02.2022.
//

import UIKit


extension UserInfoVC {
    
     func setupViews() {
        title = "Active User"
        view.backgroundColor = .white
        
        stackView = UIStackView(arrangedSubviews: [firstNameLabel,
                                                   secondNameLabel,
                                                   ageLabel,
                                                   phoneLabel,
                                                   emailLabel,
                                                   passwordLabel],
                                axis: .vertical,
                                spacing: 10,
                                distribution: .fillProportionally)
        view.addSubview(stackView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
        ])
    }
}
