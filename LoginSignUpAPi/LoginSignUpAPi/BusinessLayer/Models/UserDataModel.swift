//
//  UserDataModel.swift
//  LoginSignUpAPi
//
//  Created by Saheem Hussain on 01/05/23.
//

import Foundation

struct UserDataModel: Codable {

    var firstName: String
    let lastName: String
    var age: Int
    var gender: String
    var imageUrl: Data?
    
    enum CodingKeys: String, CodingKey{
        case firstName = "first_name"
        case lastName = "last_name"
        case age
        case gender
        case imageUrl = "image"
    }
}


