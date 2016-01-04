//
//  SignupContainerTableViewController.swift
//  do
//
//  Created by Yusuke Hozumi on 10/29/15.
//  Copyright © 2015 Yusuke Hozumi. All rights reserved.
//

import UIKit

protocol SignupContainerTableViewControllerDelegate: class {
    func signUpContainerTableViewSendData(userName: String, password: String, email: String, phoneNumber: String)
    func signUpContainerTableViewSendError(error: UserEntryError)
}

class SignupContainerTableViewController: UITableViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    
    weak var delegate: SignupContainerTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor.clearColor()
        tableView.scrollEnabled = false
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        configureTextFieldWithAttributes([NSForegroundColorAttributeName: UIColor.whiteLightGreyColor()])
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath)
    {
        cell.backgroundColor = UIColor.clearColor()
    }
    
    override func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    private func configureTextFieldWithAttributes(attributes:[String: AnyObject]) {
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Enter Name", attributes: attributes)
        emailTextField.attributedPlaceholder = NSAttributedString(string: "Enter Email", attributes: attributes)
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Enter Password", attributes: attributes)
        phoneNumberTextField.attributedPlaceholder = NSAttributedString(string: "Enter Phone Number", attributes: attributes)
        passwordTextField.secureTextEntry = true
    }
    
    func parentViewControllerPressedContinue() {
        do {
            if try checkSignUpStatus() {
                delegate?.signUpContainerTableViewSendData(nameTextField.text!, password: passwordTextField.text!, email: emailTextField.text!, phoneNumber: phoneNumberTextField.text!)
            }
        } catch UserEntryError.InvalidEntry {
            delegate?.signUpContainerTableViewSendError(.InvalidEntry)
        } catch UserEntryError.InvalidEmail {
            delegate?.signUpContainerTableViewSendError(.InvalidEmail)
        } catch UserEntryError.PasswordTooShort {
            delegate?.signUpContainerTableViewSendError(.PasswordTooShort)
        } catch UserEntryError.InvalidPhoneNumber {
            delegate?.signUpContainerTableViewSendError(.InvalidPhoneNumber)
        } catch {
            print("Other errors")
        }
    }
}

extension SignupContainerTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension SignupContainerTableViewController: UserEntryValidator {
    private func checkSignUpStatus() throws -> Bool {
        guard isUserNameValid(nameTextField.text!) else { throw UserEntryError.InvalidEntry }
        guard emailTextField.text!.isEmail() else { throw UserEntryError.InvalidEmail }
        guard isPasswordValid(passwordTextField.text!) else { throw UserEntryError.PasswordTooShort }
        //include a test to check phone number
        return true
    }
}