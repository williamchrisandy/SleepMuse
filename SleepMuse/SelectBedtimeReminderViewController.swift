//
//  SelectBedtimeReminderViewController.swift
//  SleepMuse
//
//  Created by William Chrisandy on 07/04/22.
//  PIC: Jesi
//

import UIKit

class SelectBedtimeReminderViewController: UIViewController
{
    
    @IBOutlet weak var selectReminderTimePIcker: UIDatePicker!
    
    @IBOutlet weak var mondayButton: UIButton!
    
    @IBOutlet weak var tuesdayButton: UIButton!
    
    @IBOutlet weak var wednesdayButton: UIButton!
    
    @IBOutlet weak var thursdayButton: UIButton!
    
    @IBOutlet weak var fridayButton: UIButton!
    
    
    @IBOutlet weak var saturdayButton: UIButton!
    
    @IBOutlet weak var sundayButton: UIButton!
  
    let mArray = [UIImage(named: "M Digit"), UIImage(named: "M Digit Selected")]
    let tArray = [UIImage(named: "T Digit"), UIImage(named: "T Digit Selected")]
    let wArray = [UIImage(named: "W Digit"), UIImage(named: "W Digit Selected")]
    let fArray = [UIImage(named: "F Digit"), UIImage(named: "F Digit Selected")]
    let sArray = [UIImage(named: "S Digit"), UIImage(named: "S Digit Selected")]
    
    var mondayValue = 0
    var tuesdayValue = 0
    var wednesdayValue = 0
    var thursdayValue = 0
    var fridayValue = 0
    var saturdayValue = 0
    var sundayValue = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        selectReminderTimePIcker.setValue(UIColor(named: "SleepMuse Primary Text Color"), forKey: "textColor")
        
    }

    
    @IBAction func mondayButtonPressed(_ sender: UIButton) {
        mondayValue = mondayValue == 0 ? 1 : 0
        mondayButton.setImage(mArray[mondayValue], for: .normal)
        UserDefaults.standard.set(mondayValue == 0 ? false : true, forKey: keyMondayNotification)
    }
    
    @IBAction func tuesdayButtonPressed(_ sender: Any) {
        tuesdayValue = tuesdayValue == 0 ? 1 : 0
        tuesdayButton.setImage(tArray[tuesdayValue], for: .normal)
        UserDefaults.standard.set(tuesdayValue == 0 ? false : true, forKey: "tuesdayNotification")
      
    }
    
    @IBAction func wednesdayButtonPressed(_ sender: Any) {
        wednesdayValue = wednesdayValue == 0 ? 1 : 0
        wednesdayButton.setImage(wArray[wednesdayValue], for: .normal)
        UserDefaults.standard.set(wednesdayValue == 0 ? false : true, forKey: "wednesdayNotification")
     
    }
    
    @IBAction func thursdayButtonPressed(_ sender: Any) {
        thursdayValue = thursdayValue == 0 ? 1 : 0
        thursdayButton.setImage(tArray[thursdayValue], for: .normal)
        UserDefaults.standard.set(thursdayValue == 0 ? false : true, forKey: "thursdayNotification")
    }
    
    @IBAction func fridayButtonPressed(_ sender: Any) {
        fridayValue = fridayValue == 0 ? 1 : 0
        fridayButton.setImage(fArray[fridayValue], for: .normal)
        UserDefaults.standard.set(fridayValue == 0 ? false : true, forKey: "fridayNotification")
    }
    
    @IBAction func saturdayButtonPressed(_ sender: Any) {
        saturdayValue = saturdayValue == 0 ? 1 : 0
        saturdayButton.setImage(sArray[saturdayValue], for: .normal)
        UserDefaults.standard.set(saturdayValue == 0 ? false : true, forKey: "saturdayNotification")
    }
    
    @IBAction func sundayButtonPressed(_ sender: Any) {
        sundayValue = sundayValue == 0 ? 1 : 0
        sundayButton.setImage(sArray[sundayValue], for: .normal)
        UserDefaults.standard.set(sundayValue == 0 ? false : true, forKey: "sundayNotification")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "skipPageBreathingSession"
        {
            UserDefaults.standard.set(true, forKey: keyFirstTime)
        }
    }
    
}
