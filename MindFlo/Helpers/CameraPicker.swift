//
//  CameraPicker.swift
//  MindFlo
//
//  Created by Adit Gupta on 06/08/20.
//  Copyright © 2020 Adit Gupta. All rights reserved.
//

import UIKit
import SwiftUI

struct CameraImagePicker: UIViewControllerRepresentable {
    
    var sourceType: UIImagePickerController.SourceType = .camera
    
    @Binding var selectedImage: UIImage
    @Environment(\.presentationMode) private var presentationMode

    func makeUIViewController(context: UIViewControllerRepresentableContext<CameraImagePicker>) -> UIImagePickerController {
        
        let imagePickerController =  UIImagePickerController()
        imagePickerController.sourceType = UIImagePickerController.SourceType.camera
        imagePickerController.cameraCaptureMode = UIImagePickerController.CameraCaptureMode.photo
        imagePickerController.cameraDevice = .rear
        imagePickerController.showsCameraControls = true
        imagePickerController.isNavigationBarHidden = true
        imagePickerController.isToolbarHidden = true
        imagePickerController.delegate = context.coordinator
        imagePickerController.navigationBar.isTranslucent = false
        return imagePickerController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<CameraImagePicker>) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: CameraImagePicker
        
        init(_ parent: CameraImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

