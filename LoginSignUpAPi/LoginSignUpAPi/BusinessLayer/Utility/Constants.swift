//
//  Constants.swift
//  LoginSignUpAPi
//
//  Created by Saheem Hussain on 01/05/23.
//

import Foundation

struct Key{
    
    struct String{
        static let baseUrl = "https://7ebd-112-196-113-2.ngrok-free.app/"
        static let signUpEndPoint = "users"
        static let signInEndPoint = "users/sign_in"
        static let signOutEndPoint = "users/sign_out"
        static let editEndPoint = "edit"
        static let signUp = "SignUp"
        static let errors = "errors"
        static let userMessage = "User already exists"
        static let signIn = "signIn"
        static let firstName = "First Name"
        static let lastName = "Last Name"
        static let image_Url = "image_url"
        static let editPhoto = "Edit Photo"
        static let addPhoto = "Add Photo"
        static let email = "Email"
        static let emailMessage = "Please enter valid email"
        static let password = "Password"
        static let weakPassword = "Weak Password"
        static let infoMssg = "Must contain at least one number, one uppercase, one lowercase letter and one special character, and at least 8 or more characters"
        static let strongPassword = "Strong Password"
        static let confirmPassword = "Confirm Password"
        static let confirmMssg = "Password doesn't match"
        static let error = "Error"
        static let ok = "OK"
        static let createAccount = "Create Account"
        static let male = "Male"
        static let female = "Female"
        static let other = "Other"
        static let age = "Age"
        static let gender = "Gender"
        static let done = "Done"
        static let accountDetails = "Account Details"
        static let dashboard = "DashBoard"
        static let welcome = "Welcome"
        static let logOut = "LogOut"
        static let logIn = "Login"
        static let alreadyMember = "Already a member? Login"
        static let notMember = "Not a member? Sign Up"
        static let specifyUrl = "Please specify URL"
        static let userNotFound = "User Not found"
        static let serverError = "Internal Server Error"
        static let userExists = "User already exists"
        static let invalidCredentials = "Invalid email or Password"
        static let badResponse = "Please enter valid email and password"
        static let sessionError = "URL session error"
        static let parsingError = "Error: Trying to convert model to JSON data"
        static let unknownError = "Sorry, something went wrong."
        
    }
    
    struct ApiKeys{
        static let firstName = "first_name"
        static let lastName = "last_name"
        static let age = "age"
        static let gender = "gender"
        static let image = "image"
    }
    
    struct Images{
        static let eyeSlash = "eye.slash"
        static let eye = "eye"
        static let person = "person.circle.fill"
        static let infoCircle = "info.circle"
    }
}
