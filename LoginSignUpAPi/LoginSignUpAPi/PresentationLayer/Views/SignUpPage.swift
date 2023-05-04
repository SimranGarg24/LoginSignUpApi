//
//  SignUpPage.swift
//  LoginSignUpAPi
//
//  Created by Saheem Hussain on 03/05/23.
//

import SwiftUI

struct SignUpPage: View {
    
    @StateObject var router: Router
    @StateObject var vm : ContentViewModel
    var validation = Validations()
    
    @State private var email = String()
    @State private var password = String()
    @State private var confirmPassword = String()
    
    @State private var emailPrompt = false
    @State private var passwordPrompt = false
    @State private var confirmPassPrompt = false
    
    
    
    var body: some View {
        VStack{
            
            //MARK: Email
            VStack(alignment: .leading){
                
                Text(Key.String.email)
                    .font(.subheadline)
                    .bold()
                
                TextField(Key.String.email, text: $email, onEditingChanged: {_ in
                    emailPrompt = true
                })
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .keyboardType(.emailAddress)
                
                //Shows email if user enters invalid email
                if emailPrompt{
                    if !validation.isvalidEmail(email){
                        Text(Key.String.emailMessage)
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
            }
            .padding(.vertical, 20)
            
            //MARK: Password
            VStack(alignment: .leading){
                
                Text(Key.String.password)
                    .font(.subheadline)
                    .bold()
                
                SecureInputView(Key.String.password, text: $password)
                    .onTapGesture {
                        passwordPrompt = true
                    }
                //Shows weak or strong password as user enters password
                if passwordPrompt{
                    if !validation.isvalidPassword(password){
                        Text(Key.String.weakPassword)
                            .font(.caption)
                            .foregroundColor(.red)
                        
                        HStack{
                            Image(systemName: Key.Images.infoCircle)
                                .font(.caption)
                                .foregroundColor(.accentColor)
                            Text(Key.String.infoMssg)
                                .font(.caption)
                        }
                        .padding(.top, 20)
                    }else{
                        Text(Key.String.strongPassword)
                            .font(.caption)
                            .foregroundColor(.green)
                    }
                }
            }
            .padding(.bottom, 20)
            
            //MARK: Confirm Password
            VStack(alignment: .leading){
                
                Text(Key.String.confirmPassword)
                    .font(.subheadline)
                    .bold()
                SecureInputView(Key.String.confirmPassword, text: $confirmPassword)
                    .onTapGesture {
                        confirmPassPrompt = true
                    }
                //Shows whether confirmPassword matches with password
                if confirmPassPrompt{
                    if confirmPassword != password{
                        Text(Key.String.confirmMssg)
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                }
            }
            .padding(.bottom, 50)
            
            //MARK: SignUp Button
            Button(action: {
                vm.signUp(email: email, password: password)
            }, label: {
                Text(Key.String.signUp)
                    .font(.headline)
                    .padding(.vertical, 15)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .cornerRadius(20)
                
            })
            .opacity(!validation.isvalidPassword(password) || !validation.isvalidEmail(email) || confirmPassword != password ? 0.4: 1)
            .disabled(!validation.isvalidPassword(password) || !validation.isvalidEmail(email) || confirmPassword != password)
            //MARK: Alert
            .alert(Key.String.error, isPresented: $vm.showAlert, actions: {
                Button(role: .cancel, action: {vm.showAlert = false}, label: {
                    Text(Key.String.ok)
                })
            }, message: {
                Text(vm.errorMessage)
            })
            
            //MARK: Login Button
            Button(action: {
                router.push(.D)
            }, label: {
                Text(Key.String.alreadyMember)
            })
            .padding(.top, 20)
            
            Spacer()
        }
        .onAppear{
            email = String()
            password = String()
            confirmPassword = String()
            emailPrompt = false
            passwordPrompt = false
            confirmPassPrompt = false
        }
        .navigationTitle(Key.String.createAccount)
        .padding()
    }
}


struct SignUpPage_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SignUpPage(router: Router(), vm: ContentViewModel())
        }
    }
}
