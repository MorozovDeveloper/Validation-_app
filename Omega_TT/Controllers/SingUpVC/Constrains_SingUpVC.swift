//
//  Constrains.swift
//  Omega_TT
//
//  Created by Oleg on 11.02.2022.
//

import UIKit


extension SingUpVC{
    
     func setupViews() {
        title = "SingUp"
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        
        elementStackView = UIStackView(arrangedSubviews: [firstNameTextfield,
                                                          firstNameValidLabel,
                                                          secondNameTextfield,
                                                          secondNameValidLabel,
                                                          datePicker,
                                                          ageValidLabel,
                                                          phoneNumberTextfield,
                                                          phoneValidLabel,
                                                          emailTextfield,
                                                          emailValidLabel,
                                                          passwordTextfield,
                                                          passwordValidLabel],
                                       axis: .vertical,
                                       spacing: 10,
                                       distribution: .fillProportionally)
        backgroundView.addSubview(elementStackView)
        backgroundView.addSubview(loginLabel)
        backgroundView.addSubview(singUpButton)
        
    }
    
     func setConstrains() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            backgroundView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            backgroundView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            backgroundView.heightAnchor.constraint(equalTo: view.heightAnchor),
            backgroundView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            elementStackView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            elementStackView.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            elementStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 20),
            elementStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            loginLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            loginLabel.bottomAnchor.constraint(equalTo: elementStackView.topAnchor, constant: -100),
        ])
        
        NSLayoutConstraint.activate([
            singUpButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            singUpButton.topAnchor.constraint(equalTo: elementStackView.bottomAnchor, constant: 30),
            singUpButton.heightAnchor.constraint(equalToConstant: 40),
            singUpButton.widthAnchor.constraint(equalToConstant: 300)
        ])
        
    }
    
}
