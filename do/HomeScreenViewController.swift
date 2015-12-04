//
//  HomeScreenViewController.swift
//  do
//
//  Created by Yusuke Hozumi on 11/30/15.
//  Copyright © 2015 Yusuke Hozumi. All rights reserved.
//

import UIKit

protocol HomeScreenViewControllerDelegate: class {
    func homeScreenViewControllerDidPressMenuButton()
}

class HomeScreenViewController: UIViewController {
    weak var delegate: HomeScreenViewControllerDelegate?
    
    
}
