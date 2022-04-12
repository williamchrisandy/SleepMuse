//
//  FallAsleepDurationViewController.swift
//  SleepMuse
//
//  Created by William Chrisandy on 07/04/22.
//  PIC: Jesi
//

import UIKit

class FallAsleepDurationViewController: UIViewController, UIPickerViewDelegate
{
    
    @IBOutlet weak var fallAsleepTimePicker: UIDatePicker!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fallAsleepTimePicker.setValue(UIColor(named: "SleepMuse Primary Text Color"), forKey: "textColor")
    }
    
    @IBAction func fallAsleepTimeChosen(_ sender: Any) {
        print("Time Chosen")
        
        // add function to save it di Setting
    }
    
    
    @IBAction func nextButtonPressed(_ sender: Any) {
    
        // need to add condition that textfilenya harus diisi dlu baru bisa next

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "skipPageBreathingSession"
        {
            UserDefaults.standard.set(true, forKey: keyFirstTime)
        }
    }
}
