//
//  SignInView.swift
//  LoginSignUpAPi
//
//  Created by Saheem Hussain on 02/05/23.
//

import SwiftUI

struct SignInView: View {
    

    @StateObject var router: Router
    @StateObject var vm: ContentViewModel
    
    var validation = Validations()
    @State private var email = String()
    @State private var password = String()
    
    @State private var showAlert = false
    var body: some View {
        
        VStack(){
            
            VStack(alignment: .leading){
                Text(Key.String.email)
                    .font(.subheadline)
                    .bold()
                
                TextField(Key.String.email, text: $email)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .keyboardType(.emailAddress)
            }
            
            VStack(alignment: .leading){
                
                Text(Key.String.password)
                    .font(.subheadline)
                    .bold()
                
                SecureInputView(Key.String.password, text: $password)
            }
            .padding(.bottom, 20)
            
            Button(action: {
                vm.signIn(email: email, password: password)
            }, label: {
                Text(Key.String.logIn)
                    .font(.headline)
                    .padding(.vertical, 15)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .cornerRadius(20)
            })
            .opacity(email.isEmpty || password.isEmpty ? 0.4: 1)
            .disabled(email.isEmpty || password.isEmpty)
            .alert(Key.String.error, isPresented: $vm.showAlert, actions: {
                Button(role: .cancel, action: {}, label: {
                    Text(Key.String.ok)
                })
            }, message: {
                Text(vm.errorMessage)
            })
            
            Button(action: {
                router.pop()
            }, label: {
                Text(Key.String.notMember)
            })
            .padding(.top, 20)
            
            Spacer()
        }
        .onAppear{
            email = String()
            password = String()
        }
        .padding()
        .navigationTitle(Key.String.logIn)
        .navigationBarBackButtonHidden(true)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            SignInView(router: Router(), vm: ContentViewModel())
        }
    }
}
