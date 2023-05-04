//
//  PhotoPickerViewModel.swift
//  LoginSignUpAPi
//
//  Created by Saheem Hussain on 02/05/23.
//

import SwiftUI
import PhotosUI

@MainActor
class PhotosPickerViewModel: ObservableObject{
    
    //MARK: Properties
    @Published var image: Image?
    @Published var data: Data?
    @Published var imageSelection: PhotosPickerItem?{
        didSet{
            if let imageSelection{
                Task{
                    try await loadTransferable(from: imageSelection)
                }
            }
        }
    }
    
    //MARK: Methods
    
    /// to load selected Image and change it into Image type and save into image variable
    /// - Parameter imageSelection: PhotosPickerItem which picks the image from the gallery
    func loadTransferable(from imageSelection: PhotosPickerItem?) async throws {
        do{
            if let data = try await imageSelection?.loadTransferable(type: Data.self) {
                self.data = data
                if let uiImage = UIImage(data: data){
                    self.image = Image(uiImage: uiImage)
                }
            }
        }catch{
            print(error.localizedDescription)
            image = nil
        }
    }
}
