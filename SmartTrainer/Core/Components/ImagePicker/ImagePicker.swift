//
//  ImagePicker.swift
//  SmartTrainer
//
//  Created by Jack O'Meara on 08/02/2024.
//

//import Foundation
//import SwiftUI
//
//struct ImagePicker: UIViewControllerRepresentable {
//    @Binding var selectedImage: Image?
//    
//    func makeUIViewController(context: Context) -> UIImagePickerController {
//            let imagePicker = UIImagePickerController()
//            imagePicker.delegate = context.coordinator
//            imagePicker.sourceType = .photoLibrary
//            return imagePicker
//        }
//
//        func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
//
//        func makeCoordinator() -> Coordinator {
//            Coordinator(parent: self)
//        }
//
//        class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//            let parent: ImagePicker
//
//            init(parent: ImagePicker) {
//                self.parent = parent
//            }
//
//            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//                if let uiImage = info[.originalImage] as? UIImage {
//                    parent.selectedImage = Image(uiImage: uiImage)
//                }
//                picker.dismiss(animated: true, completion: nil)
//            }
//
//            func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//                picker.dismiss(animated: true, completion: nil)
//            }
//        }
//}
