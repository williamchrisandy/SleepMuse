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
        print((insertNameField.text) as Any)
        let vc = storyboard?.instantiateViewController(withIdentifier: "other") as! FallAsleepDurationViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc,animated: true)
        // need to add condition that textfilenya harus diisi dlu baru bisa next
    }
}
