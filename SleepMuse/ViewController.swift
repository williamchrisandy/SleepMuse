//
//  ViewController.swift
//  SleepMuse
//
//  Created by William Chrisandy on 07/04/22.
//

import UIKit

class ViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        performSegue(withIdentifier: UserDefaults.standard.bool(forKey: keyFirstTime) ? "openHomeSegue" : "openGetStartedSegue", sender: self)
    }
}
