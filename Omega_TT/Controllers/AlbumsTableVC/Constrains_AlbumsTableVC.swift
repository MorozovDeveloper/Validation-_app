//
//  Constrains_SingUpVC.swift
//  Omega_TT
//
//  Created by Oleg on 11.02.2022.
//

import UIKit


extension AlbumsTableVC{
    
     func setConstrains() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
}
