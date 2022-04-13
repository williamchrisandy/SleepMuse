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
    
    let standardUserDefault = UserDefaults.standard
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        errorMessage.isHidden = true
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
        insertNameField.text = standardUserDefault.string(forKey: keyNickname)
        insertNameFieldUsed(insertNameField!)
    }
    
    @objc func dismissKeyboard()
    {
        self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        dismissKeyboard()
    }
    
    @IBAction func textFieldDidEndOnExit(_ sender: UITextField)
    {
        dismissKeyboard()
    }
    
    @IBAction func insertNameFieldUsed(_ sender: Any)
    {
        if insertNameField.text?.count != 0
        {
            errorMessage.isHidden = true
        }
        else
        {
            errorMessage.isHidden = false
            errorMessage.text = "Required"
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        if insertNameField.text?.count != 0
        {
            UserDefaults.standard.set(insertNameField.text!, forKey: keyNickname)
            performSegue(withIdentifier: "nextPageFallAsleepDuration", sender: self)
        }
    }

    @IBAction func skipButtonPressed(_ sender: Any)
    {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "skipPageBreathingSession"
        {
            StaticFunction.setUpCompleted()
        }
    }
}
