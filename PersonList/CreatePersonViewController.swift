//
//  CreatePersonViewController.swift
//  PersonList
//
//  Created by Nam Le on 5/22/20.
//  Copyright © 2020 Nam Le. All rights reserved.
//

import UIKit

class CreatePersonViewController: UIViewController {
    @IBOutlet weak var nameTF: UITextField!
    var personCurrent: Person?
    var passData: ((Person) -> ())?
    var imagePicker: UIImagePickerController!
    var manager: ManagerImagePicker!
    @IBOutlet weak var PhoneTF: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Tao person"
        let saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveData))
        navigationItem.leftBarButtonItem = saveButton
        imagePicker = UIImagePickerController()
        manager = ManagerImagePicker(imagePicker, self)
        imagePicker.delegate = self
        photoImageView.layer.cornerRadius = photoImageView.frame.height / 2
        photoImageView.layer.masksToBounds = true
        if let personCurrent = personCurrent {
            nameTF.text = personCurrent.name
            PhoneTF.text = personCurrent.phone
            photoImageView.image = personCurrent.avatarImage
        }
    }
    
    @objc func saveData() {
        guard let name = nameTF.text, let phone = PhoneTF.text else {
            return
        }
        guard let avatar = photoImageView.image else { return}
        let person = Person(name: name, phone: phone, avatarImage: avatar)
        passData?(person)
        navigationController?.popViewController(animated: true)
    }
    @IBAction func onSelectPhoto(_ sender: Any) {
        let alert = UIAlertController(title: "App", message: "Chọn ảnh từ", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Huỷ", style: .cancel, handler: nil)
        let camera = UIAlertAction(title: "Máy ảnh", style: .default, handler: { (_) in
            print("Chọn ảnh từ máy ảnh")
            self.manager.fromCamera()
        })
        let libray = UIAlertAction(title: "Thư viện", style: .default, handler: { (_) in
            print("Chọn ảnh từ thư viện")
            self.manager.fromLibrary()
        })
        
        alert.addAction(camera)
        alert.addAction(libray)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    

}

extension CreatePersonViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        photoImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
        
    }
    
}
