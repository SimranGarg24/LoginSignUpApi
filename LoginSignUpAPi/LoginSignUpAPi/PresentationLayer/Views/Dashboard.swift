//
//  Dashboard.swift
//  LoginSignUpAPi
//
//  Created by Saheem Hussain on 02/05/23.
//

import SwiftUI

struct Dashboard: View {
    
    @StateObject var vm: ContentViewModel
    
    var body: some View {
        VStack{
            
            Text(Key.String.dashboard)
                .padding(10)
                .font(.title)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .background(Color.accentColor)
            
            Text("\(Key.String.welcome) \(vm.userData.firstName)")
                .font(.title2)
                .bold()
                .padding(.vertical, 20)
            
            //MARK: Image
            if let imageData = vm.userData.imageUrl{
                if let uiImage = UIImage(data: imageData){
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width:150, height: 150)
                        .clipShape(Circle())
                        .padding(.top, 15)
                }
            }
            
            //MARK: Details
            VStack(alignment: .leading){
                Text("\(Key.String.firstName) : \(vm.userData.firstName)")
                Divider()
                Text("\(Key.String.lastName) : \(vm.userData.lastName)")
                
                Divider()
                Text("\(Key.String.age) : \(vm.userData.age)")
                
                Divider()
                Text("\(Key.String.gender) : \(vm.userData.gender)")
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            
            //MARK: LogOut Button
            Button{
                vm.signOut()
            }label:{
                Text(Key.String.logOut)
            }
            //MARK: Alert
            .alert(Key.String.error, isPresented: $vm.showAlert, actions: {
                Button(role: .cancel, action: {}, label: {
                    Text(Key.String.ok)
                })
            }, message: {
                Text(vm.errorMessage)
            })
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            Dashboard(vm: ContentViewModel())
        }
    }
}
