//
//  LoginViewController.swift
//  do
//
//  Created by Yusuke Hozumi on 10/28/15.
//  Copyright © 2015 Yusuke Hozumi. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logoTopLayout: NSLayoutConstraint!
    
    private let lightGreyColor = UIColor(red: 142/255.0, green: 144/255.0, blue: 150/250.0, alpha: 0.8)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFieldsWithAttributes([NSForegroundColorAttributeName: lightGreyColor])
        self.setupTransparentNavigation()
    }
    
    private func setupTransparentNavigation() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
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
    
    private func configureTextFieldsWithAttributes(attributes: [String: AnyObject]) {
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Enter Name", attributes: attributes)
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Enter Password", attributes: attributes)
        passwordTextField.secureTextEntry = true
    }
    
    func goBack() {
        navigationController?.popViewControllerAnimated(true)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        logoTopLayout.constant = -(self.view.bounds.height / 6)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowSignUp" {
            if let signupVC = segue.destinationViewController as? SignUpViewController {
                signupVC.title = "Sign up"
                signupVC.navigationItem.leftBarButtonItem = createCustomBackButton()
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    private func isUserEntryValid() -> Bool{
        //To do. Check if the user entry is valid.
        return true
    }
    
    @IBAction func signInTapped(sender: UIButton) {
        if isUserEntryValid() {
            //move to home screen view controller
        } else {
            //clear user input and display a message
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension UINavigationController {
    public override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}
