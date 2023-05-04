//
//  ContentViewModel.swift
//  LoginSignUpAPi
//
//  Created by Saheem Hussain on 01/05/23.
//

import Foundation

class ContentViewModel: ObservableObject{
    
    let network = NetworkManager.shared
    @Published var errorMessage = String()
    @Published var showAlert: Bool = false
    @Published var userData = UserDataModel(firstName: "", lastName: "", age: 0, gender: "")
    
    
    /// To callApi to signUp user
    /// - Parameters:
    ///   - email: String
    ///   - password: String
    func signUp(email: String, password: String){
        network.data = SignUpDetails(user: Details(email: email, password: password))
        
        network.postMethod(type: Key.String.signUp){ result in
            
            DispatchQueue.main.async{
                switch result{
                    //In case of error
                case .failure(let error):
                    //Property to indicate when Alert will be shown to the user to inidicate error showing errorMessage
                    self.showAlert = true
                    self.errorMessage = error.localizedDescription
                    
                    //In case of success
                case .success(_):
                    Router.navigationVM.push(.B)
                }
            }
        }
    }
    
    /// To callApi to signIn user
    /// - Parameters:
    ///   - email: String
    ///   - password: String
    func signIn(email: String, password: String){
        network.data = SignUpDetails(user: Details(email: email, password: password))
        
        network.postMethod(type: Key.String.signIn){ result in
            DispatchQueue.main.async{
                switch result{
                    //In case of error
                case .failure(let error):
                    //Property to indicate when Alert will be shown to the user to inidicate error showing errorMessage
                    self.showAlert = true
                    self.errorMessage = error.localizedDescription
                    
                    //In case of success
                case .success(_):
                    Router.navigationVM.push(.C)
                }
            }
        }
    }
    
    
    /// To Put details entered by user in the API
    /// - Parameters:
    ///   - firstName: String
    ///   - lastName: String
    ///   - age: String
    ///   - gender: String
    ///   - imageUrl: image as Data
    func enterDetails(firstName: String, lastName: String, age: String, gender: String, imageUrl: Data?){
        
        self.userData = UserDataModel(firstName: firstName, lastName: lastName, age: Int(age) ?? 0, gender: gender, imageUrl: imageUrl)
        network.userData = self.userData
        
        network.putMethod(){result in
            DispatchQueue.main.async{
                switch result{
                    //In case of error
                case .failure(let error):
                    //Property to indicate when Alert will be shown to the user to inidicate error showing errorMessage
                    self.showAlert = true
                    self.errorMessage = error.localizedDescription
                    
                    //In case of success
                case .success(let response):
                    Router.navigationVM.push(.C)
                    print(response)
                }
            }
            
        }
    }
    
    
    /// To make user signout
    func signOut(){
        network.deleteMethod(){result in
            DispatchQueue.main.async{
                switch result{
                    //In case of error
                case .failure(let error):
                    //Property to indicate when Alert will be shown to the user to inidicate error showing errorMessage
                    self.showAlert = true
                    self.errorMessage = error.localizedDescription
                    
                    //In case of success
                case .success(_):
                    Router.navigationVM.pop2()
                    Router.navigationVM.push(.D)
                }
            }
            
        }
    }
}
