//
//  HistoryViewController.swift
//  SleepMuse
//
//  Created by William Chrisandy on 07/04/22.
//  PIC: William Chrisandy
//

import UIKit
import CoreData

class HistoryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    @IBOutlet weak var viewRecent: UIView!
    @IBOutlet weak var labelRecentMusic: UILabel!
    @IBOutlet weak var labelRecentDuration: UILabel!
    @IBOutlet weak var labelRecentStartTime: UILabel!
    @IBOutlet weak var collectionViewDaily: UICollectionView!
    @IBOutlet weak var collectionViewWeekly: UICollectionView!
    @IBOutlet weak var pageControlDaily: UIPageControl!
    @IBOutlet weak var pageControlWeekly: UIPageControl!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var arraySessionDaily: [Session] = []
    var arraySessionWeekly: [Session] = []
    var lastSession: Session?
    var context: NSManagedObjectContext?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        viewRecent.layer.cornerRadius = 20
        collectionViewDaily.layer.cornerRadius = 20
        collectionViewWeekly.layer.cornerRadius = 20

        context = appDelegate.persistentContainer.viewContext
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
        self.navigationController?.visibleViewController?.navigationItem.setRightBarButton(settingsButton, animated: false)
        
        getSessionData()
    }
    
    func getSessionData()
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH.mm"
        let dateString = UserDefaults.standard.string(forKey: keyNotificationTime) ?? "00.00"
        let date = dateFormatter.date(from: dateString)
        
        
        do
        {
            let fetchRequest: NSFetchRequest<Session> = Session.fetchRequest(since: date!)
            let result = try context?.fetch(fetchRequest)
            
            if result?.isEmpty == false
            {
                labelRecentMusic.text = result?[0].with?.title
                labelRecentDuration.text = StaticFunction.createDurationString((result?[0].duration)!)
                labelRecentStartTime.text = StaticFunction.dateToTimeString((result?[0].startTime)!)
                
                
                
                pageControlDaily.numberOfPages = 3//arraySessionDaily.count
                pageControlWeekly.numberOfPages = 3//arraySessionWeekly.count
                
                collectionViewDaily.reloadData()
                collectionViewWeekly.reloadData()
            }
        }
        catch let error
        {
            print(error.localizedDescription)
        }
    }
    
    @IBAction func openSetting(_ sender: UIButton)
    {
        performSegue(withIdentifier: "goToReminderSegue", sender: self)
        /*
        // To Settings
        let app = UIApplication.shared
        let url = URL(string: UIApplication.openSettingsURLString)!

        if app.canOpenURL(url)
        {
            app.open(url, completionHandler: nil)
        }
         */
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
            return 3
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionView == collectionViewDaily ? "collectionViewDailyCell" : "collectionViewWeeklyCell", for: indexPath) as! HistoryCollectionViewCell
        if collectionView == collectionViewDaily
        {
            
        }
        else if collectionView == collectionViewWeekly
        {
            
        }
            return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.width, height: collectionView == collectionViewDaily ? 146 : 134)
    }
    
    @IBAction func pageControlValueChanged(_ sender: UIPageControl)
    {
        
    }
}
