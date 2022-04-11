//
//  HistoryViewController.swift
//  SleepMuse
//
//  Created by William Chrisandy on 07/04/22.
//  PIC: William Chrisandy
//

import UIKit

class HistoryViewController: UIViewController
{
    @IBOutlet weak var viewRecent: UIView!
    @IBOutlet weak var viewDaily: UIView!
    @IBOutlet weak var collectionViewDaily: UICollectionView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        viewRecent.layer.cornerRadius = 20
        collectionViewDaily.layer.cornerRadius = 20
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.visibleViewController?.navigationItem.title = "History"
        if var titleTextAttributes = self.navigationController?.navigationBar.titleTextAttributes
        {
            print("Test")
            titleTextAttributes[NSAttributedString.Key.foregroundColor] = UIColor.red
            self.navigationController?.navigationBar.titleTextAttributes = titleTextAttributes
        }
        else
        {
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor(named: "SleepMuse Primary Text Color")!]
        }
        
        let settingsButton = UIBarButtonItem.init(image: UIImage(systemName: "gearshape.fill"), style: .done, target: self, action: #selector(self.openSetting(_:)))
        settingsButton.tintColor = UIColor.white
        self.navigationController?.visibleViewController?.navigationItem.setRightBarButton(settingsButton, animated: false)
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
