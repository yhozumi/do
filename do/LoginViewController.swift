//
//  LoginViewController.swift
//  do
//
//  Created by Yusuke Hozumi on 10/28/15.
//  Copyright © 2015 Yusuke Hozumi. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    private enum LoginErrors: ErrorType {
        case PasswordTooShort
        case InvalidEntry
        case PasswordNotMatching
        case UserInvalid
    }

    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logoTopLayout: NSLayoutConstraint!
    
    var coreDataStack: CoreDataStack?
    var string: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFieldsWithAttributes([NSForegroundColorAttributeName: UIColor.whiteLightGreyColor()])
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
        
        let image = UIImageView(image: UIImage(assetIdentifier: .Back))
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
                signupVC.coreDataStack = self.coreDataStack
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    private func checkLoginEntry(users: [User]) throws {
        if nameTextField.text!.isEmpty && passwordTextField.text!.isEmpty {
            throw LoginErrors.InvalidEntry
        } else if passwordTextField.text?.characters.count < 8 {
            throw LoginErrors.PasswordTooShort
        } else if checkValidUser(users) {
            throw LoginErrors.UserInvalid
        } else if checkUserPassword(users) {
            throw LoginErrors.PasswordTooShort
        }
    }
    
    private func checkUserPassword(users: [User]) -> Bool {
        let user = users.filter{ $0.name == nameTextField.text }.first
        guard let existingUser = user else { return true }
        guard existingUser.password == passwordTextField.text else { return true }
        return false
    }
    
    private func checkValidUser(users: [User]) -> Bool {
        let user = users.filter{ $0.name == nameTextField.text }.first
        guard let _ = user else { return true }
        return false
    }
    
    private func displayErrorMessageToUser(message: String) {
        errorMessageLabel.text = message
        UIView.animateWithDuration(0.5, animations: {
            self.errorMessageLabel.alpha = 1.0
            }, completion: {_ in
                UIView.animateWithDuration(0.5, delay: 5, options: [], animations: {
                    self.errorMessageLabel.alpha = 0.0
                    }, completion: nil)
        })
    }
    
    @IBAction func signInTapped(sender: UIButton) {
        let fetchRequest = NSFetchRequest(entityName: "User")
        do {
            let users = try coreDataStack?.managedObjectContext.executeFetchRequest(fetchRequest) as! [User]
            do {
                try checkLoginEntry(users)
                print("sign in successful!")
            } catch LoginErrors.InvalidEntry {
                displayErrorMessageToUser("Fields are empty")
            } catch LoginErrors.PasswordTooShort {
                displayErrorMessageToUser("Password is too short")
            } catch LoginErrors.UserInvalid {
                displayErrorMessageToUser("User name does not exist")
            } catch LoginErrors.PasswordNotMatching {
                displayErrorMessageToUser("Password is incorrect")
            }
        } catch {
            print("Fetch request error")
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
