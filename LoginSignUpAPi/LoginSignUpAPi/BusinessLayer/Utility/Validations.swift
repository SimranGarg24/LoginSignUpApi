//
//  ValidationViewModel.swift
//  LoginSignUpAPi
//
//  Created by Saheem Hussain on 02/05/23.
//

import Foundation

class Validations{
    
    func isvalidEmail(_ email:String)->Bool {
        // One or more characters followed by an "@",
        // then one or more characters followed by a ".",
        // and finishing with one or more characters
        let emailPattern = #"^\S+@\S+\.\S+$"#
        let result = email.range(
            of: emailPattern,
            options: .regularExpression
        )
        return result != nil
    }

    func isvalidPassword(_ password:String)->Bool{
        let passwordPattern =
            // At least 8 characters
            #"(?=.{8,})"# +

            // At least one capital letter
            #"(?=.*[A-Z])"# +
                
            // At least one lowercase letter
            #"(?=.*[a-z])"# +
                
            // At least one digit
            #"(?=.*\d)"# +
                
            // At least one special character
            #"(?=.*[ !@/#$%&?._-])"#
        
        let result = password.range(
            of: passwordPattern,
            options: .regularExpression
        )

        return result != nil
    }
}
