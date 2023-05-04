//
//  PhotosPickerView.swift
//  LoginSignUpAPi
//
//  Created by Saheem Hussain on 02/05/23.
//

import SwiftUI
import PhotosUI

struct PhotoPickerView: View {
    
    //MARK: Properties
    @StateObject var imagePicker = PhotosPickerViewModel()
    @Binding var profilePic: Data?
    
    var body: some View {
        
        //MARK: Photo Picker
        PhotosPicker(
            selection: $imagePicker.imageSelection,
            matching: .images
        ){
            if let image = imagePicker.image {
                VStack{
                    image
                        .resizable()
                        .frame(width:150, height: 150)
                        .clipShape(Circle())
                        .padding(.top, 15)
                    
                    Text(Key.String.editPhoto)
                }
                
            }else{
                VStack{
                    Image(systemName: Key.Images.person)
                        .resizable()
                        .frame(width:150, height: 150)
                        .foregroundColor(.gray)
                        .padding(.top, 15)
                    
                    Text(Key.String.addPhoto)
                }
            }
        }
        .onChange(of: imagePicker.image, perform: { _ in
            if let data = imagePicker.data{
                profilePic = data
            }
        })
    }
    
}


struct PhotoPicker_Previews: PreviewProvider {
    static var previews: some View {
        PhotoPickerView(profilePic: Binding.constant(Data()))
    }
}

