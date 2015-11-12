//
//  SignUpViewController.swift
//  do
//
//  Created by Yusuke Hozumi on 10/28/15.
//  Copyright © 2015 Yusuke Hozumi. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var profileView: ProfileAvatarImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileView.delegate = self
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    @IBAction func signInButtonTapped(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    private func isUserEntryValid() -> Bool {
        //To Do. Check user entry.
        return true
    }

    @IBAction func continueButtonPressed(sender: AnyObject) {
        if isUserEntryValid() {
            // move view controller to tutorial screen
        } else {
            // clear user entry
        }
    }
    
    func goBack() {
        navigationController?.popViewControllerAnimated(true)
    }
    
    private func createCustomBackButton() -> UIBarButtonItem {
        let button = UIButton(type: .Custom)
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.addTarget(self, action: Selector("goBack"), forControlEvents: UIControlEvents.TouchUpInside)
        
        let image = UIImageView(image: UIImage(named: "back"))
        image.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.addSubview(image)
        
        let backButton = UIBarButtonItem(customView: button)
        return backButton
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "continueToTutorial" {
            if let tutorialVC = segue.destinationViewController as? TutorialScreenViewController {
                tutorialVC.title = "Sign Up"
                tutorialVC.navigationItem.leftBarButtonItem = createCustomBackButton() 
            }
        }
    }
}

extension SignUpViewController: ProfileAvatarImageDelegate, UINavigationControllerDelegate {
    func openImagePickerController() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.editing = true
        presentViewController(imagePicker, animated: true, completion: nil)
    }
}

extension SignUpViewController: UIImagePickerControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        profileView.profileImage = image
        dismissViewControllerAnimated(true, completion: nil)
    }
}