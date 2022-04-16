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
    var arraySessionDaily: [SessionSection] = []
    var arraySessionWeekly: [SessionSection] = []
    var lastSession: Session?
    var context: NSManagedObjectContext?
    let calendar = Calendar.current
    
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
        arraySessionDaily = []
        arraySessionWeekly = []
        let currentDay = calendar.startOfDay(for: Date())
        
        var dayOfWeekComponent = DateComponents()
        dayOfWeekComponent.day = ((5 + calendar.component(.weekday, from: currentDay))%7) * -1
        let startofWeek = calendar.date(byAdding: dayOfWeekComponent, to: currentDay)!
        
        let startDate = calendar.date(byAdding: .weekOfYear, value: -7, to: startofWeek)!
        
        var day = calendar.date(byAdding: .day, value: -6, to: currentDay)!
        for i in 1...7
        {
            arraySessionDaily.append(SessionSection(startDate: day))
            day = calendar.date(byAdding: .day, value: 1, to: day)!
            
            let weekStartDate = calendar.date(byAdding: .weekOfYear, value: i, to: startDate)!
            arraySessionWeekly.append(SessionSection(startDate: weekStartDate))
        }
        
        do
        {
            let fetchRequest: NSFetchRequest<Session> = Session.fetchRequest(since: startDate)
            let result = try context?.fetch(fetchRequest)
            
            if result != nil || result?.isEmpty == false
            {
                labelRecentMusic.text = result![0].with?.title
                labelRecentDuration.text = StaticFunction.createDurationString((result![0].duration))
                labelRecentStartTime.text = StaticFunction.dateToTimeString((result![0].startTime)!)
                
                var dayIndex = 6, weekIndex = 6
                for session in result!
                {
                    while session.startTime! < arraySessionDaily[dayIndex].startDate
                    {
                        dayIndex -= 1
                    }
                    var targetData = arraySessionDaily[dayIndex]
                    targetData.dataCount += 1
                    targetData.totalDuration += session.duration
                    targetData.startTime[Int(StaticFunction.dateToHourString(session.startTime!))!] += 1;
                    
                    
                    while session.startTime! < arraySessionWeekly[weekIndex].startDate
                    {
                        weekIndex -= 1
                    }
                    targetData = arraySessionWeekly[weekIndex]
                    targetData.dataCount += 1
                    targetData.totalDuration += session.duration
                    targetData.startTime[Int(StaticFunction.dateToHourString(session.startTime!))!] += 1;
                }
                
                pageControlDaily.numberOfPages = arraySessionDaily.count
                pageControlWeekly.numberOfPages = arraySessionWeekly.count
                
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
        return collectionView == collectionViewDaily ? arraySessionDaily.count : arraySessionWeekly.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionView == collectionViewDaily ? "collectionViewDailyCell" : "collectionViewWeeklyCell", for: indexPath) as! HistoryCollectionViewCell
        
        var targetData: SessionSection?
        
        if collectionView == collectionViewDaily
        {
            targetData = arraySessionDaily[indexPath.item]
            
            let nameOfDay = StaticFunction.dateToNameOfDay(targetData!.startDate)
            cell.imageViewDaySymbol.image = UIImage(named: nameOfDay.prefix(1) + " Digit Selected")
            cell.labelTitle.text = targetData!.startDate == calendar.startOfDay(for: Date()) ? "Today" : "\(nameOfDay)"
        }
        else if collectionView == collectionViewWeekly
        {
            targetData = arraySessionWeekly[indexPath.item]
            
            var endOfWeekComponent = DateComponents()
            endOfWeekComponent.weekOfYear = 1
            endOfWeekComponent.second = -1
            let endOfWeek = calendar.date(byAdding: endOfWeekComponent, to: targetData!.startDate)!
            
            cell.labelTitle.text = "\(StaticFunction.dateToDayAndMonthString(targetData!.startDate)) - \(StaticFunction.dateToDayAndMonthString(endOfWeek))"
        }
        
        if targetData == nil || targetData?.dataCount == 0
        {
            cell.labelAverageDuration.text = "No Data"
            cell.labelAverageStartTime.text = "No Data"
            cell.labelChanges.text = ""
            cell.imageViewUpDown.image = nil
        }
        else
        {
            let averageDuration = targetData!.totalDuration/Double(targetData!.dataCount)
            cell.labelAverageDuration.text = StaticFunction.createDurationString(averageDuration)
            var maxIndex = 0
            for i in 1...23
            {
                if targetData!.startTime[i] > targetData!.startTime[maxIndex]
                {
                    maxIndex = i
                }
            }
            let selectedHour = maxIndex < 10 ? "0\(maxIndex)" : "\(maxIndex)"
            cell.labelAverageStartTime.text = "\(selectedHour).00 - \(selectedHour).59"
            
            if indexPath.row != 0
            {
                let previousData = collectionView == collectionViewDaily ? arraySessionDaily[indexPath.item - 1] : arraySessionWeekly[indexPath.item - 1]
                if previousData.dataCount != 0
                {
                    let previousAverageDuration = previousData.totalDuration/Double(previousData.dataCount)
                    
                    if previousAverageDuration < averageDuration
                    {
                        cell.labelChanges.text = "\(Int((averageDuration - previousAverageDuration)/previousAverageDuration * 100))%"
                        cell.imageViewUpDown.image = UIImage(systemName: "arrow.up")
                    }
                    else
                    {
                        cell.labelChanges.text = "\(Int((previousAverageDuration - averageDuration)/previousAverageDuration * 100))%"
                        cell.imageViewUpDown.image = UIImage(systemName: "arrow.down")
                    }
                }
                else
                {
                    cell.labelChanges.text = ""
                    cell.imageViewUpDown.image = UIImage(systemName: "arrow.up")
                }
            }
            else
            {
                cell.labelChanges.text = ""
                cell.imageViewUpDown.image = nil
            }
        }
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.width, height: collectionView == collectionViewDaily ? 146 : 134)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let visibleRectangleDaily = CGRect(origin: collectionViewDaily.contentOffset, size: collectionViewDaily.bounds.size)
        if let visibleIndexPath = self.collectionViewDaily.indexPathForItem(at: CGPoint(x: visibleRectangleDaily.midX, y: visibleRectangleDaily.midY))
        {
            pageControlDaily.currentPage = visibleIndexPath.row
        }
        
        let visibleRectangleWeekly = CGRect(origin: collectionViewWeekly.contentOffset, size: collectionViewWeekly.bounds.size)
        if let visibleIndexPath = self.collectionViewWeekly.indexPathForItem(at: CGPoint(x: visibleRectangleWeekly.midX, y: visibleRectangleWeekly.midY))
        {
            pageControlWeekly.currentPage = visibleIndexPath.row
        }
    }
    
    @IBAction func pageControlValueChanged(_ sender: UIPageControl)
    {
        
    }
}
