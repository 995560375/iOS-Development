//
//  DetailViewController.swift
//  Quiz
//
//  Created by sunny on 2022/11/26.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var answerField: UITextField!
    @IBOutlet var selectionField: UITextField!
    @IBOutlet var questionField: UITextField!
    
    @IBOutlet var imageView: UIImageView!
    var imageStore: ImageStore!
    @IBAction func choosePhotoSource(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.modalPresentationStyle = .popover
        alertController.popoverPresentationController?.barButtonItem = sender
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
                print("Present camera")
                let imagePicker = self.imagePicker(for: .camera)
                self.present(imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(cameraAction)
        }
        
        
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) { _ in
            print("Present photo library")
            let imagePicker = self.imagePicker(for: .photoLibrary)
            imagePicker.modalPresentationStyle = .popover
            imagePicker.popoverPresentationController?.barButtonItem = sender
            self.present(imagePicker, animated: true, completion: nil)
        }
        alertController.addAction(photoLibraryAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    var item: Item!
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        answerField.resignFirstResponder();
        selectionField.resignFirstResponder();
        questionField.resignFirstResponder();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        questionField.text = item.question;
        selectionField.text = item.selection;
        answerField.text = item.answer;
        dateLabel.text = "\(item.dateCreated)"
        
        let key = item.itemKey
        // If there is an associated image with the item, display it on the image view
        let imageToDisplay = imageStore.image(forKey: key)
        imageView.image = imageToDisplay
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        item.question = questionField.text ?? ""
        item.selection = selectionField.text ?? ""
        item.answer = answerField.text ?? ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    func imagePicker(for sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = self
        return imagePicker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        imageStore.setImage(image, forKey: item.itemKey)
        imageView.image = image
        dismiss(animated: true, completion: nil)
        print("photo was saved")
        print(imageView)
    }
}
