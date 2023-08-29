//
//  User.swift
//  iOSNFCDemo
//
//  Created by Chandra Jayaswal on 29/08/2023.
//

import Foundation

struct User {
    var userName: String
    var password: String
    
    func isValidUser() -> Bool {
        return userName == "chandra" && password == "chandra"
    }
}
