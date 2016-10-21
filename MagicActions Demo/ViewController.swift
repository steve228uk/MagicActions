//
//  ViewController.swift
//  MagicActions Demo
//
//  Created by Stephen Radford on 20/10/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import UIKit
import MagicActions
import Photos
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    let imagePicker = UIImagePickerController()
    
    var imageChange: ((UIImage?) -> Void)?
    var selectedImage: UIImage? {
        didSet {
            imageChange?(selectedImage)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHeightChanged), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        imagePicker.delegate = self
        
        let imageAction = MagicAction(title: "Image", description: "Image from your library", trigger: "image") { [unowned self] completed in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
            self.imageChange = { image in
                guard let image = image else { return }
                
                let rect = AVMakeRect(aspectRatio: image.size, insideRect: CGRect(x: 0, y: 0, width: self.view.bounds.width - 0, height: 150))
                
                let attachment = NSTextAttachment()
                attachment.image = image
                attachment.bounds = rect
                completed(attachment)
            }
        }
        
        let cameraAction = MagicAction(title: "Camera", description: "Take a new photo", trigger: "camera") { [unowned self] completed in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
            self.imageChange = { image in
                
                guard let image = image else { return }
            
                let rect = AVMakeRect(aspectRatio: image.size, insideRect: CGRect(x: 0, y: 0, width: self.view.bounds.width - 0, height: 150))
              
                let attachment = NSTextAttachment()
                attachment.image = image
                attachment.bounds = rect
                completed(attachment)
                
            }
        }
        
        MagicActions.register(actions: [imageAction, cameraAction])
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        selectedImage = image
        
    }
    
}

extension ViewController {
    
    func keyboardWillDisappear(notification: NSNotification) {
        guard let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double else { return }
        
        heightConstraint.constant = view.frame.height - 44
        UIView.animate(withDuration: duration) { [unowned self] in
            self.view.layoutIfNeeded()
        }
    }
    
    func keyboardHeightChanged(notification: NSNotification) {
        guard let frame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        guard let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? Double else { return }
        
        heightConstraint.constant = view.frame.height - frame.height - 44
        UIView.animate(withDuration: duration) { [unowned self] in
            self.view.layoutIfNeeded()
        }
        
    }

}
