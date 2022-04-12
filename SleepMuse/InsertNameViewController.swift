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
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var errorMessage: UILabel!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        errorMessage.isHidden = true
        
    }
    
    @IBAction func insertNameFieldUsed(_ sender: Any) {
        }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        
        if insertNameField.text?.count != 0
        {
            errorMessage.isHidden = true
            performSegue(withIdentifier: "nextPageFallAsleepDuration", sender: self)
        }
        else
        {
            errorMessage.isHidden = false
            errorMessage.text = "Required"
        }
        
    }

    @IBAction func skipButtonPressed(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "skipPageBreathingSession"
        {
            UserDefaults.standard.set(true, forKey: keyFirstTime)
        }
    }
}
