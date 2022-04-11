//
//  HistoryViewController.swift
//  SleepMuse
//
//  Created by William Chrisandy on 07/04/22.
//  PIC: William Chrisandy
//

import UIKit

class HistoryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    @IBOutlet weak var viewRecent: UIView!
    @IBOutlet weak var collectionViewDaily: UICollectionView!
    @IBOutlet weak var collectionViewWeekly: UICollectionView!
    
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
            titleTextAttributes[NSAttributedString.Key.foregroundColor] = UIColor(named: "SleepMuse Primary Text Color")!
            self.navigationController?.navigationBar.titleTextAttributes = titleTextAttributes
        }
        else
        {
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "SleepMuse Primary Text Color")!]
        }
        
        let settingsButton = UIBarButtonItem.init(image: UIImage(systemName: "gearshape.fill"), style: .done, target: self, action: #selector(self.openSetting(_:)))
        settingsButton.tintColor = UIColor.white
        let notificationButton = UIBarButtonItem.init(image: UIImage(systemName: "gearshape"), style: .done, target: self, action: #selector(self.openSetting(_:)))
        settingsButton.tintColor = UIColor.white
//        self.navigationController?.visibleViewController?.navigationItem.setRightBarButton(settingsButton, animated: false)
        self.navigationController?.visibleViewController?.navigationItem.setRightBarButtonItems([settingsButton,notificationButton], animated: false)
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
            return 3
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
//        collectionView == collectionViewDaily ? "collectionViewDailyCell" : "collectionViewWeeklyCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionView == collectionViewDaily ? "collectionViewDailyCell" : "collectionViewWeeklyCell", for: indexPath) as! HistoryCollectionViewCell
//        cell.imageViewDaySymbol.isHidden = true
            return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.width, height: collectionView == collectionViewDaily ? 146 : 134)
    }
    
}
