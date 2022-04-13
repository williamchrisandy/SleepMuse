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
    
    let standardUserDefault = UserDefaults.standard
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        fallAsleepTimePicker.setValue(UIColor(named: "SleepMuse Primary Text Color"), forKey: "textColor")
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        updateViews()
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillEnterForeground(_:)), name: UIApplication.willEnterForegroundNotification, object: UIApplication.shared)
    }
    
    @objc func applicationWillEnterForeground(_ notification: NSNotification)
    {
        updateViews()
    }
    
    func updateViews()
    {
        fallAsleepTimePicker.countDownDuration = standardUserDefault.double(forKey: keyFallAsleepDuration)
    }
    
    @IBAction func fallAsleepTimeChosen(_ sender: UIDatePicker)
    {
        if (sender.countDownDuration > 7200)
        {
            sender.countDownDuration = 7200;
        }
    }
    
    
    @IBAction func nextButtonPressed(_ sender: Any)
    {
        standardUserDefault.set(fallAsleepTimePicker.countDownDuration, forKey: keyFallAsleepDuration)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "skipPageBreathingSession"
        {
            StaticFunction.setUpCompleted()
        }
    }
}
