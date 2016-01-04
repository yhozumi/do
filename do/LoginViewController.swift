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
    
    @IBAction func signInTapped(sender: UIButton) {
        let fetchRequest = NSFetchRequest(entityName: "User")
        do {
            let users = try coreDataStack?.managedObjectContext.executeFetchRequest(fetchRequest) as! [User]
            
            do {
                guard try checkLoginStatus(nameTextField.text!, password: passwordTextField.text!, users: users) else { return }
                print("success")
            } catch UserEntryError.InvalidEntry {
                UserEntryError.displayErrorMessageToUser(UserEntryError.InvalidEntry, errorMessageLabel: self.errorMessageLabel!)
            } catch UserEntryError.PasswordTooShort {
                UserEntryError.displayErrorMessageToUser(UserEntryError.PasswordTooShort, errorMessageLabel: self.errorMessageLabel!)
            } catch UserEntryError.UserInvalid {
                UserEntryError.displayErrorMessageToUser(UserEntryError.UserInvalid, errorMessageLabel: self.errorMessageLabel!)
            } catch UserEntryError.PasswordNotMatching {
                UserEntryError.displayErrorMessageToUser(UserEntryError.PasswordNotMatching, errorMessageLabel: self.errorMessageLabel!)
            }
        } catch {
            print("Fetch request error")
        }
    }
}

extension LoginViewController: UserEntryValidator {
    private func checkLoginStatus(userName: String, password: String, users: [User]) throws -> Bool {
        guard isUserNameValid(userName) else { throw UserEntryError.InvalidEntry }
        guard isUserExisiting(userName, password: password, users: users) else { throw UserEntryError.UserInvalid }
        guard isPasswordValid(password) else { throw UserEntryError.PasswordTooShort }
        guard isUserPasswordMatching(userName, password: password, users: users) else { throw UserEntryError.PasswordNotMatching }
        return true
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
