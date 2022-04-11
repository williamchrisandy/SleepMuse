//
//  FallAsleepDurationViewController.swift
//  SleepMuse
//
//  Created by William Chrisandy on 07/04/22.
//  PIC: Jesi
//

import UIKit

class FallAsleepDurationViewController: UIViewController
{
    
    @IBOutlet weak var fallAsleepTimePicker: UIDatePicker!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func fallAsleepTimeChosen(_ sender: Any) {
        print("Time Chosen")
        // add function to save it di Setting
    }
    
    
    @IBAction func nextButtonPressed(_ sender: Any) {
    
        // need to add condition that textfilenya harus diisi dlu baru bisa next

    }

}
