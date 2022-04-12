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
  
    let mArray = [UIImage(named: "M Digit Selected"), UIImage(named: "M Digit")]
    let tArray = [UIImage(named: "T Digit Selected"), UIImage(named: "T Digit")]
    let wArray = [UIImage(named: "W Digit Selected"), UIImage(named: "W Digit")]
    let fArray = [UIImage(named: "F Digit Selected"), UIImage(named: "F Digit")]
    let sArray = [UIImage(named: "S Digit Selected"), UIImage(named: "S Digit")]
    
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
    }
    
    @IBAction func tuesdayButtonPressed(_ sender: Any) {
        tuesdayValue = tuesdayValue == 0 ? 1 : 0
        tuesdayButton.setImage(tArray[tuesdayValue], for: .normal)
      
    }
    
    @IBAction func wednesdayButtonPressed(_ sender: Any) {
        wednesdayValue = wednesdayValue == 0 ? 1 : 0
        wednesdayButton.setImage(wArray[wednesdayValue], for: .normal)
     
    }
    
    @IBAction func thursdayButtonPressed(_ sender: Any) {
        thursdayValue = thursdayValue == 0 ? 1 : 0
        thursdayButton.setImage(tArray[thursdayValue], for: .normal)
    }
    
    @IBAction func fridayButtonPressed(_ sender: Any) {
        fridayValue = fridayValue == 0 ? 1 : 0
        fridayButton.setImage(fArray[fridayValue], for: .normal)
       
    }
    
    @IBAction func saturdayButtonPressed(_ sender: Any) {
        saturdayValue = saturdayValue == 0 ? 1 : 0
        saturdayButton.setImage(sArray[saturdayValue], for: .normal)
    }
    
    @IBAction func sundayButtonPressed(_ sender: Any) {
        sundayValue = sundayValue == 0 ? 1 : 0
        sundayButton.setImage(sArray[sundayValue], for: .normal)
    }
}
