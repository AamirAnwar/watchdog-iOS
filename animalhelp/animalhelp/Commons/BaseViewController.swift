//
//  BaseViewController.swift
//  animalhelp
//
//  Created by Aamir  on 04/01/18.
//  Copyright © 2018 AamirAnwar. All rights reserved.
//

import Foundation
import UIKit
class BaseViewController:UIViewController {

    var navBarHeight:CGFloat {
        get {
            if let navBarHeight = self.navigationController?.navigationBar.frame.size.height {
                return navBarHeight
            }
            else {
                return 0.0
            }
        }
    }
    
    var tabBarHeight:CGFloat {
        get {
            if let tabBar = self.tabBarController?.tabBar {
                return tabBar.frame.size.height
            }
            else {
                return 0.0
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    }
}
