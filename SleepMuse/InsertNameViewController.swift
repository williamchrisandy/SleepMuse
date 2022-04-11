//
//  InsertNameViewController.swift
//  SleepMuse
//
//  Created by William Chrisandy on 07/04/22.
//  PIC: Jesi
//

import UIKit

class InsertNameViewController: UIViewController
{
    
  
    @IBOutlet weak var insertNameField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func nextButtonPressed(_ sender: Any) {
performSegue(withIdentifier: "nextPageFallAsleepDuration", sender: self)
        // need to add condition that textfilenya harus diisi dlu baru bisa next
    }
}
