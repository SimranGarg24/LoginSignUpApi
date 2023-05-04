//
//  SignUpDataModel.swift
//  LoginSignUpAPi
//
//  Created by Saheem Hussain on 01/05/23.
//

import Foundation

struct SignUpDetails: Codable{
    var user: Details
}

struct Details:Codable{
    var email: String
    var password: String
}
