//
//  ViewController.swift
//  SleepMuse
//
//  Created by William Chrisandy on 07/04/22.
//

import UIKit

class ViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
//        Buat Qhanza: Uncomment buat nampilin TabBar. Buat Jesi: Line di bawah ini bisa dipake kalo set uo completed terakhir udah diklik ok.
//        UserDefaults.standard.set(true, forKey: keyFirstTime)
        
        performSegue(withIdentifier: UserDefaults.standard.bool(forKey: keyFirstTime) ? "openHomeSegue" : "openGetStartedSegue", sender: self)
    }
}
