//
//  SetUpCompleteViewController.swift
//  SleepMuse
//
//  Created by William Chrisandy on 07/04/22.
//  PIC: Jesi
//

import UIKit

class SetUpCompleteViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        StaticFunction.setUpCompleted()
        self.navigationController?.isNavigationBarHidden = true
    }
}
