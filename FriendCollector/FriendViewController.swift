//
//  FriendViewController.swift
//  FriendCollector
//
//  Created by Joey Newfield on 1/9/18.
//  Copyright © 2018 Joey Newfield. All rights reserved.
//

import UIKit

class FriendViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var addupdatebutton: UIButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var friendImageView: UIImageView!
    
    var imagePicker = UIImagePickerController()
    var friend : Friend? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        
        if friend != nil {
            friendImageView.image = UIImage(data: friend!.image as! Data)
            titleTextField.text = friend!.title
            
            addupdatebutton.setTitle("Update", for: .normal)
        } else {
            deleteButton.isHidden = true
        }

}

    @IBAction func photosTapped(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        friendImageView.image = image
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        imagePicker.sourceType = .camera
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
        
      
        
        
        if friend != nil {
            friend!.title = titleTextField.text
            friend!.image = UIImagePNGRepresentation(friendImageView.image!)
        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            let friend = Friend(context: context)
            friend.title = titleTextField.text
            friend.image = UIImagePNGRepresentation(friendImageView.image!)
        }
        
        
        
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
    navigationController!.popViewController(animated: true)
    }
    
    @IBAction func deleteTapped(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        context.delete(friend!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        navigationController!.popViewController(animated: true)
    }
}
