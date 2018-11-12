//
//  ReportViewController.swift
//  UVA Accessibility
//
//  Created by Hannah Marie Thompson on 11/11/18.
//  Copyright © 2018 Hannah Marie Thompson. All rights reserved.
//

import UIKit
import MobileCoreServices
import MessageUI

class ReportViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate{
    
    // MARK: UI Elements
    @IBOutlet weak var AffiliationChoice: UISegmentedControl!
    @IBOutlet weak var BarrierChoice: UISegmentedControl!
    @IBOutlet weak var desctextview: UITextView!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var email: UITextField!
   
    // MARK: Image booleans
    var newMedia: Bool?
    var picChosen: Bool? = false

    
    // dismiss keyboard functionality
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    // function to use camera
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
    
    // function to use image library
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
    
    // used to display the image and store it
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
        
        // sets up the dismiss keyboard functionality
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ReportViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // gets all the data to send to the email function
    @IBAction func submitReport(_ sender: Any) {
        // check for data
        // affiliation data
        let affiliation = AffiliationChoice.titleForSegment(at: AffiliationChoice.selectedSegmentIndex)
        
        // barrier type data
        let barrier = BarrierChoice.titleForSegment(at: BarrierChoice.selectedSegmentIndex)
        
        // description data; will force user to include data
        var desc: String
        if((desctextview.text != nil ) && (desctextview.text != "")){
            desc = desctextview.text!
        }else{
            let alertController = UIAlertController(title: "Insufficient Info", message: "Please provide a description and resubmit.", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: { _ in return})
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true, completion:nil)
            return
        }
        
        // location data
        var loc: String
        if((location.text != nil ) && (location.text != "")){
            loc = location.text!
        }else{
            loc = "No location provided."
        }
        
        // image data
        if(imageView.image != nil){
            picChosen = true
        }
        
        // email data; will force to use valid email address
        var emailAddress: String
        if((email.text != nil ) && (email.text != "")){
            if(validateEmail(enteredEmail: email.text!)){
                emailAddress = email.text!
            }else{
                let alertController = UIAlertController(title: "Invaild Email", message: "Please provide a valid email address and resubmit.", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default, handler: { _ in return})
                alertController.addAction(OKAction)
                
                self.present(alertController, animated: true, completion:nil)
                return
            }
        }else{
            emailAddress = "none"
        }
        
        // set up text for email
        let text = "Barrier to Access Report </br>UVA Affiliation: \(String(describing: affiliation!)) </br>Barrier Type: \(String(describing: barrier!)) </br>Barrier Description: \(String(describing: desc)) </br>Barrier Location: \(String(describing: loc))"
        
        sendEmail(emailAddress, text, picChosen!)
        
    }
    
    // used to reset the UI elements in the page after the email is sent or saved
    func resetPage(){
        // reset the page
        AffiliationChoice.selectedSegmentIndex = 0
        BarrierChoice.selectedSegmentIndex = 0
        desctextview.text = ""
        location.text = ""
        imageView.image = nil
        email.text = ""
    }
    
    // send email with attachment
    func sendEmail(_ email: String, _ message: String, _ isImage: Bool) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            var recipients = ["hmt5wa@virginia.edu"]
            if(email != "none"){recipients.append(email)}
            mail.setToRecipients(recipients)
            mail.setMessageBody(message, isHTML: true)
            mail.setSubject("Barrier to Access Report")
            if(isImage == true){
                let imageData: Data = imageView.image!.pngData()!
                mail.addAttachmentData(imageData, mimeType: "image/png", fileName: "BarrierImage.png")
            }
            present(mail, animated: true)
            
        } else {
            let alertController = UIAlertController(title: "Can't Send Email", message: "No email is connected to this device.", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: { _ in return})
            alertController.addAction(OKAction)
            
            self.present(alertController, animated: true, completion:nil)
        }
    }
    
    // decides what to do if user cancels email
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            print("Mail cancelled")
        case .saved:
            print("Mail saved")
            resetPage()
        case .sent:
            print("Mail sent")
            resetPage()
        case .failed:
            print("Mail sent failure: \(error?.localizedDescription ?? "nil")")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    // used to valide that the email is the correct format
    func validateEmail(enteredEmail:String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }

}
