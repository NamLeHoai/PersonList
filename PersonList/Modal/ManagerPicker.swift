//
//  ManagerPicker.swift
//  PersonList
//
//  Created by Nam Le on 5/22/20.
//  Copyright © 2020 Nam Le. All rights reserved.
//

import Foundation
import UIKit
import Photos

class ManagerImagePicker {
    var imagePicker: UIImagePickerController!
    var viewController: UIViewController!
    
    init(_ imagePicker: UIImagePickerController, _ viewController: UIViewController) {
        self.imagePicker = imagePicker
        self.viewController = viewController
    }
    
    func confirm(message: String, viewController: UIViewController?, success: @escaping () -> Void){
            let alert = UIAlertController(title: "Person App", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(action)
            
            viewController?.present(alert, animated: true, completion: nil)
        }
        
        func setting(){
            let message = "App cần truy cập máy ảnh và thư viện của bạn. Ảnh của bạn sẽ không được chia sẻ khi chưa được phép của bạn."
            confirm(message: message, viewController: viewController) {
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.openURL(settingsUrl)
                    } else {
                        UIApplication.shared.openURL(settingsUrl)
                    }
                }
            }
        }
        
        func fromLibrary(){
            func choosePhoto(){
                self.imagePicker.allowsEditing = false
                self.imagePicker.sourceType = .photoLibrary
                self.imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
                self.imagePicker.modalPresentationStyle = .popover
                DispatchQueue.main.async {
                    self.viewController.present(self.imagePicker, animated: true, completion: nil)
                }
            }
            
            // khai báo biến để lấy quyền truy cập
            let status = PHPhotoLibrary.authorizationStatus()
            if (status == PHAuthorizationStatus.authorized) {
                // quyền truy cập đã được cấp
                choosePhoto()
            }else if (status == PHAuthorizationStatus.denied) {
                // quyền truy cập bị từ chối
                setting()
            }else if (status == PHAuthorizationStatus.notDetermined) {
                // quyền truy cập chưa được xác nhận
                PHPhotoLibrary.requestAuthorization({ (newStatus) in
                    if (newStatus == PHAuthorizationStatus.authorized) {
                        choosePhoto()
                    }else {
                        print("Không được cho phép truy cập vào thư viện ảnh")
                        self.setting()
                    }
                })
            }else if (status == PHAuthorizationStatus.restricted) {
                // Truy cập bị hạn chế, thông thường sẽ không xảy ra
                print("Restricted access")
                setting()
            }
        }
        
        func fromCamera(){
            func takePhoto(){
                if UIImagePickerController.isSourceTypeAvailable(.camera){
                    self.imagePicker.allowsEditing = false
                    self.imagePicker.sourceType = UIImagePickerController.SourceType.camera
                    self.imagePicker.cameraCaptureMode = .photo
    self.imagePicker.cameraDevice = .front
                    self.imagePicker.modalPresentationStyle = .fullScreen
                    DispatchQueue.main.async {
                        self.viewController.present(self.imagePicker, animated: true,completion: nil)
                    }
                }else{
                    print("abc")
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Thông báo", message: "Không tìm thấy máy ảnh", preferredStyle: .alert)
                        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
                        alert.addAction(ok)
                        self.viewController.present(alert, animated: true, completion: nil)
                    }
                }
            }
            //Camera
            AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
                if response {
                    takePhoto()
                } else {
                    print("camera denied")
                    self.setting()
                }
            }
        }
}


