//
//  DetailsView.swift
//  LoginSignUpAPi
//
//  Created by Saheem Hussain on 02/05/23.
//

import SwiftUI

struct DetailsView: View {
    
    @StateObject var vm: ContentViewModel
    @State private var firstName = String()
    @State private var lastName = String()
    @State private var age = String()
    @State private var gender = Key.String.male
    let genderType = [Key.String.male, Key.String.female, Key.String.other]
    @State private var imageUrl: Data? = Data()
    @State private var isActive = true
    
    
    var body: some View {
        
        VStack{
            
            //MARK: Image
            PhotoPickerView(profilePic: $imageUrl)
                .padding(.top, 12)
            
            VStack{
                //MARK: First Name
                TextField(Key.String.firstName, text: $firstName)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.words)
                Divider()
                
                //MARK: Last Name
                TextField(Key.String.lastName, text: $lastName)
                    .autocorrectionDisabled(true)
                    .textInputAutocapitalization(.words)
                Divider()
                
                //MARK: Age
                TextField(Key.String.age, text: $age)
                    .keyboardType(.numberPad)
                
                Divider()
                
                //MARK: Gender
                Picker(Key.String.gender, selection: $gender){
                    ForEach(genderType, id: \.self){
                        Text($0)
                            .foregroundColor(.black)
                    }
                }
                .foregroundColor(.gray.opacity(0.4))
                .pickerStyle(.navigationLink)
                
                Divider()
            }
            .padding(.top, 20)
            
            //MARK: Done Button
            Button(action: {
                vm.enterDetails(firstName: firstName, lastName: lastName, age: age, gender: gender, imageUrl: imageUrl)
            }, label: {
                Text(Key.String.done)
                    .font(.headline)
                    .padding(.vertical, 15)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(Color.accentColor)
                    .cornerRadius(20)
            })
            .opacity(firstName.isEmpty || lastName.isEmpty || age.isEmpty || gender.isEmpty ? 0.4: 1)
            .disabled(firstName.isEmpty || lastName.isEmpty || age.isEmpty || gender.isEmpty)
            
            //MARK: Alert
            .alert(Key.String.error, isPresented: $vm.showAlert, actions: {
                Button(role: .cancel, action: {}, label: {
                    Text(Key.String.ok)
                })
            }, message: {
                Text(vm.errorMessage)
            })
            .padding(.top, 50)
            
            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .navigationTitle(Key.String.accountDetails)
        .navigationBarTitleDisplayMode(.large)
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            DetailsView(vm: ContentViewModel())
        }
    }
}
