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
    @IBOutlet weak var selectReminderTimePicker: UIDatePicker!
    @IBOutlet weak var mondayButton: UIButton!
    @IBOutlet weak var tuesdayButton: UIButton!
    @IBOutlet weak var wednesdayButton: UIButton!
    @IBOutlet weak var thursdayButton: UIButton!
    @IBOutlet weak var fridayButton: UIButton!
    @IBOutlet weak var saturdayButton: UIButton!
    @IBOutlet weak var sundayButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var notificationToggle: UISwitch!
    
    var type = "First Time"
    let standardUserDefault = UserDefaults.standard
    
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
        selectReminderTimePicker.setValue(UIColor(named: "SleepMuse Primary Text Color"), forKey: "textColor")
        
        if type == "Edit"
        {
            skipButton.isHidden = true
            nextButton.isHidden = true
        }
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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH.mm"
        let dateString = standardUserDefault.string(forKey: keyNotificationTime) ?? "00.00"
        let date = dateFormatter.date(from: dateString)
        selectReminderTimePicker.setDate(date ?? Date(), animated: true)
        
        if standardUserDefault.bool(forKey: keyMondayNotification) == true
        {
            mondayValue = 1
            mondayButton.setImage(mArray[mondayValue], for: .normal)
        }
        if standardUserDefault.bool(forKey: keyTuesdayNotification) == true
        {
            tuesdayValue = 1
            tuesdayButton.setImage(tArray[tuesdayValue], for: .normal)
        }
        if standardUserDefault.bool(forKey: keyWednesdayNotification) == true
        {
            wednesdayValue = 1
            wednesdayButton.setImage(wArray[wednesdayValue], for: .normal)
        }
        if standardUserDefault.bool(forKey: keyThursdayNotification) == true
        {
            thursdayValue = 1
            thursdayButton.setImage(tArray[thursdayValue], for: .normal)
        }
        if standardUserDefault.bool(forKey: keyFridayNotification) == true
        {
            fridayValue = 1
            fridayButton.setImage(fArray[fridayValue], for: .normal)
        }
        if standardUserDefault.bool(forKey: keySaturdayNotification) == true
        {
            saturdayValue = 1
            saturdayButton.setImage(sArray[saturdayValue], for: .normal)
        }
        if standardUserDefault.bool(forKey: keySundayNotification) == true
        {
            sundayValue = 1
            sundayButton.setImage(sArray[sundayValue], for: .normal)
        }
        
        notificationToggle.isOn = standardUserDefault.bool(forKey: keyNotificationOn)
    }
    
    @IBAction func timeChanged(_ sender: UIDatePicker)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH.mm"
        standardUserDefault.set(dateFormatter.string(from:sender.date), forKey: keyNotificationTime)
    }
    
    @IBAction func mondayButtonPressed(_ sender: UIButton)
    {
        mondayValue = mondayValue == 0 ? 1 : 0
        mondayButton.setImage(mArray[mondayValue], for: .normal)
        standardUserDefault.set(mondayValue == 0 ? false : true, forKey: keyMondayNotification)
    }
    
    @IBAction func tuesdayButtonPressed(_ sender: Any)
    {
        tuesdayValue = tuesdayValue == 0 ? 1 : 0
        tuesdayButton.setImage(tArray[tuesdayValue], for: .normal)
        standardUserDefault.set(tuesdayValue == 0 ? false : true, forKey: keyTuesdayNotification)
      
    }
    
    @IBAction func wednesdayButtonPressed(_ sender: Any)
    {
        wednesdayValue = wednesdayValue == 0 ? 1 : 0
        wednesdayButton.setImage(wArray[wednesdayValue], for: .normal)
        standardUserDefault.set(wednesdayValue == 0 ? false : true, forKey: keyWednesdayNotification)
     
    }
    
    @IBAction func thursdayButtonPressed(_ sender: Any)
    {
        thursdayValue = thursdayValue == 0 ? 1 : 0
        thursdayButton.setImage(tArray[thursdayValue], for: .normal)
        standardUserDefault.set(thursdayValue == 0 ? false : true, forKey: keyThursdayNotification)
    }
    
    @IBAction func fridayButtonPressed(_ sender: Any)
    {
        fridayValue = fridayValue == 0 ? 1 : 0
        fridayButton.setImage(fArray[fridayValue], for: .normal)
        standardUserDefault.set(fridayValue == 0 ? false : true, forKey: keyFridayNotification)
    }
    
    @IBAction func saturdayButtonPressed(_ sender: Any)
    {
        saturdayValue = saturdayValue == 0 ? 1 : 0
        saturdayButton.setImage(sArray[saturdayValue], for: .normal)
        standardUserDefault.set(saturdayValue == 0 ? false : true, forKey: keySaturdayNotification)
    }
    
    @IBAction func sundayButtonPressed(_ sender: Any)
    {
        sundayValue = sundayValue == 0 ? 1 : 0
        sundayButton.setImage(sArray[sundayValue], for: .normal)
        standardUserDefault.set(sundayValue == 0 ? false : true, forKey: keySundayNotification)
    }
    
    @IBAction func notificationOnChanged(_ sender: UISwitch)
    {
        standardUserDefault.set(sender.isOn, forKey: keyNotificationOn)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "skipPageBreathingSession"
        {
            StaticFunction.setUpCompleted()
        }
    }
    
}
