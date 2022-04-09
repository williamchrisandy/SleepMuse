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
    func fallAsleepTimePicker.font
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func fallAsleepTimeChosen(_ sender: Any) {
        print("Time Chosen")
        // add function to save it di Setting
    }
    
    @IBAction func skipButtonPressed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "other") as! SelectBedtimeReminderViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc,animated: true)
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "other") as! SelectBedtimeReminderViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc,animated: true)
        // need to add condition that textfilenya harus diisi dlu baru bisa next

}

