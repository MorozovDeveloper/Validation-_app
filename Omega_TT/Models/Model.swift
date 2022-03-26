//
//  Model.swift
//  Omega_TT
//
//  Created by Oleg on 09.02.2022.
//

import Foundation


struct User: Codable {
    
    let firstName: String
    let secondName: String
    let age: Date
    let phone: String
    let email: String
    let password: String

}
