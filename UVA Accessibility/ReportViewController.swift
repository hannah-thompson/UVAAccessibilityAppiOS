//
//  ReportViewController.swift
//  UVA Accessibility
//
//  Created by Hannah Marie Thompson on 11/11/18.
//  Copyright © 2018 Hannah Marie Thompson. All rights reserved.
//

import UIKit
import MobileCoreServices

class ReportViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    

    @IBOutlet weak var desctextview: UITextView!
    
    @IBOutlet weak var imageView: UIImageView!
    var newMedia: Bool?
    
    // CAMERA FUNCTIONS
    @IBAction func useCamera(_ sender: AnyObject) {
        // Add your code here
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.camera) {
            
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType =
                UIImagePickerController.SourceType.camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true,
                         completion: nil)
            
            newMedia = true
        }
    }
    
    
    @IBAction func useImageLibrary(_ sender: AnyObject) {
        // Add your code here
        
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.savedPhotosAlbum) {
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType =
                UIImagePickerController.SourceType.photoLibrary
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true,
                         completion: nil)
            newMedia = false
        }
        
    }
    
    // You can add more functions here if needed
    
    
    // used to display the image
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let selectedImage = info[.originalImage] as? UIImage{
            self.imageView.image = selectedImage
        } else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // border around description field
        desctextview.layer.cornerRadius = 5
        desctextview.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        desctextview.layer.borderWidth = 0.5
        desctextview.clipsToBounds = true
        
      
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
