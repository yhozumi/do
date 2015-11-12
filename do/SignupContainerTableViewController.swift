//
//  SignupContainerTableViewController.swift
//  do
//
//  Created by Yusuke Hozumi on 10/29/15.
//  Copyright © 2015 Yusuke Hozumi. All rights reserved.
//

import UIKit

class SignupContainerTableViewController: UITableViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!

    private let lightGreyColor = UIColor(red: 189/255.0, green: 191/255.0, blue: 198/250.0, alpha: 0.8)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = UIColor.clearColor()
        tableView.scrollEnabled = false
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        configureTextFieldWithAttributes([NSForegroundColorAttributeName: lightGreyColor])
        
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
}

extension SignupContainerTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
