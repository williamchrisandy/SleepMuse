//
//  HomeViewController.swift
//  SleepMuse
//
//  Created by William Chrisandy on 07/04/22.
//  PIC: William Chrisandy
//

import UIKit

class HomeViewController: UIViewController
{
    @IBOutlet weak var labelDayStatus: UILabel!
    @IBOutlet weak var labelNickName: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
//        labelNickName.text = UserDefaults.standard.string(forKey: keyNickname)
        self.navigationController?.visibleViewController?.navigationItem.title = "XYZ Commerce"
    }
    
    @IBAction func openSetting(_ sender: UIButton)
    {
        let app = UIApplication.shared
        let url = URL(string: UIApplication.openSettingsURLString)!
        
        if app.canOpenURL(url)
        {
            app.open(url, completionHandler: nil)
        }
    }
}
