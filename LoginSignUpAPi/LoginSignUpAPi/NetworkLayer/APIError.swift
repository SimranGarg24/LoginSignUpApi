//
//  Enumerations.swift
//  LoginSignUpAPi
//
//  Created by Saheem Hussain on 02/05/23.
//

import Foundation

enum APIError: LocalizedError {
    case badURL
    case badResponse(Int)
    case url(URLError?)
    case parsing
    case unknown
    
    
    var errorDescription: String?{
        switch self {
            
        case .badURL:
            return Key.String.specifyUrl
            
        case .badResponse(let statusCode):
            if statusCode == 404{
                return Key.String.userNotFound
            }
            else if statusCode == 500{
                return Key.String.serverError
            }
            else if statusCode == 422{
                return Key.String.userExists
            }
            else if statusCode == 401{
                return Key.String.invalidCredentials
            }
            else{
                return Key.String.badResponse
            }
            
        case .url(let error):
            return error?.localizedDescription ?? Key.String.sessionError
        case .parsing:
            return Key.String.parsingError
        case .unknown:
            return Key.String.unknownError
        }
    }
}
