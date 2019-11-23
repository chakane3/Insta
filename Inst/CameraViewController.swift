//
//  CameraViewController.swift
//  Inst
//
//  Created by Chakane Shegog on 11/16/19.
//  Copyright © 2019 Chakane Shegog. All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentField: UITextField!
    
    
    @IBAction func onSendButton(_ sender: Any) {
        let post = PFObject(className: "Posts")
        post["caption"] = commentField.text!
        post["author"] = PFUser.current()!
        
        let imageData = imageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        
        post["image"] = file
        
        post.saveInBackground{
            (success, error) in
            if success{
                self.dismiss(animated: true, completion: nil)
                print("Saved")
            } else {
                print("Error")
            }
        }
    }
    
    
    // Upon tapping on the camera button, itll show the camera
   @IBAction func onCamerabutton(_ sender: Any) {
       // Lets program know when user submitted photo
       let picker = UIImagePickerController()
       picker.delegate = self
       picker.allowsEditing = true
       
       if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
           picker.sourceType = .photoLibrary
       } else {
           picker.sourceType = .camera
       }
       present(picker, animated: true, completion: nil)
   }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageScaled(to: size)
        imageView.image = scaledImage
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    override func viewDidLoad() {
         super.viewDidLoad()

         // Do any additional setup after loading the view.
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
