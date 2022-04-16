//
//  StartBreathingViewController.swift
//  SleepMuse
//
//  Created by William Chrisandy on 07/04/22.
//  PIC: Qhanza
//

import UIKit
import AVFoundation
import CoreData

class StartBreathingViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var modelAudioPlayer = ModelAudioPlayer()
    
    // Outlets
    @IBOutlet weak var labelGreeting: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var musicPicker: UIPickerView!
    @IBOutlet weak var musicTimerDatePicker: UIDatePicker!
    @IBOutlet weak var startBreathingButton: UIButton!
    
    // Color Constants
    let sleepmuseWhiteColor = UIColor(named: "SleepMuse Gradient Text Color")
    
    // The Selected Picker View Rows
    var selectedMusicRow = 0
    
    // For Playing The Audio
    var player: AVAudioPlayer?
    
    // Passing the Data with Segue
    var pickedMusic: PickedMusic?
    
    // Passing The Data from Viewer Controller One to the Next
    public var passMusicAudio: String?
    public var passTotalMusicRepeat: Int?
    
    let standardUserDefault = UserDefaults.standard
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initializing the musicPicker IBOutlet
        musicPicker.dataSource = self
        musicPicker.delegate = self
        
        // Customizing the Music Timer Date Picker IBOutlet
        musicTimerDatePicker.setValue(sleepmuseWhiteColor, forKeyPath: "textColor")
        musicTimerDatePicker.datePickerMode = .countDownTimer
        musicTimerDatePicker.minuteInterval = 15
        
        self.musicTimerDatePicker?.addTarget(self, action: #selector(datePickedValueChanged), for: .valueChanged)
        musicPicker.selectRow(standardUserDefault.integer(forKey: keyLastMusicRow), inComponent: 0, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.visibleViewController?.navigationItem.title = ""
        
        let settingsButton = UIBarButtonItem.init(image: UIImage(systemName: "gearshape.fill"), style: .done, target: self, action: #selector(self.openSetting(_:)))
        settingsButton.tintColor = UIColor.white
        self.navigationController?.visibleViewController?.navigationItem.setRightBarButton(settingsButton, animated: false)
        
        updateViews()
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillEnterForeground(_:)), name: UIApplication.willEnterForegroundNotification, object: UIApplication.shared)
    }
    
    @objc func applicationWillEnterForeground(_ notification: NSNotification)
    {
        updateViews()
    }
    
    func updateViews()
    {
        labelGreeting.text = "Good \(StaticFunction.dateToPartOfDayString(Date()))"
        labelName.text = standardUserDefault.string(forKey: keyNickname)
        musicTimerDatePicker.countDownDuration = standardUserDefault.double(forKey: keyFallAsleepDuration)
    }
    
    @IBAction func openSetting(_ sender: UIButton)
    {
        performSegue(withIdentifier: "goToReminderSegue", sender: self)
    }
    
    @IBAction func startBreathingButtonPressed(_ sender: UIButton) {
        // Selected Music
        self.selectedMusicRow = musicPicker.selectedRow(inComponent: 0)
        let musicName = musicDataArray[self.selectedMusicRow].musicName
        let musicAudio = musicDataArray[self.selectedMusicRow].musicAudio
        print("The Music Name : \(musicName)")
        print("The Music Audio : \(musicAudio)")
        
        // Selected Music Timer (Using Date Picker - Count Down Timer)
        let selectedMusicTimer = musicTimerDatePicker.countDownDuration
        print("selectedMusicTimer : \(selectedMusicTimer)")
        
        // Calculate the Repeat of the Music
        let totalMusicRepeat = selectedMusicTimer / 60
        print("Total Music Repeat : \(totalMusicRepeat)")
        
        pickedMusic = PickedMusic(chosenMusicAudio: musicAudio, chosenMusicTimer: selectedMusicTimer, chosenMusicRepeat: totalMusicRepeat)
        print("pickedMusic : \(String(describing: pickedMusic))")
        
        
        // The StartBreathingViewController Changes to the BreathingSessionViewController (Using Segue)
        performSegue(withIdentifier: "goToBreathingSession", sender: self)
    }
    
    // Functions for Customizing the "Choose the Music" Picker View
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return musicDataArray.count
    }
        
    // Function for Customizing the musicPicker Text Size, Color, Alignment and Data
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.font = UIFont(name: "System", size: 17)
        label.textColor = sleepmuseWhiteColor
        label.text = musicDataArray[row].musicName // This is using Array in the MusicData Struct
        label.textAlignment = .center
        return label
    }
    
    // Contoh Kodingan untuk Membatasi Pilihan Waktu Music Timer
    @objc func datePickedValueChanged (sender: UIDatePicker) {
        if (self.musicTimerDatePicker.countDownDuration > 7200) { //7200 seconds = 2h
            self.musicTimerDatePicker.countDownDuration = 7200; //Back to 2h
        }
        print("Test DatePickedValueChanged")
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "goToBreathingSession"
        {
            self.navigationController?.isNavigationBarHidden = true
            let destination = segue.destination as! BreathingSessionViewController
            destination.pickedMusicData = pickedMusic
            
            standardUserDefault.set(musicPicker.selectedRow(inComponent: 0), forKey: keyLastMusicRow)
            standardUserDefault.set(musicTimerDatePicker.countDownDuration, forKey: keyFallAsleepDuration)
            
            let context = self.appDelegate.persistentContainer.viewContext
            do
            {
                let session = Session(context: context)
                session.duration = pickedMusic?.chosenMusicTimer ?? 3600.00
                session.startTime = Date()
                
                let music = Music(context: context)
                music.title = musicDataArray[self.selectedMusicRow].musicName
                music.fileName = musicDataArray[self.selectedMusicRow].musicAudio
                
                session.with = music
                
                context.insert(session)
                try context.save()
            }
            catch let error
            {
                print(error.localizedDescription)
            }
        }
        else if segue.identifier == "goToReminderSegue"
        {
            self.navigationController?.visibleViewController?.navigationItem.title = "Exercise"
            let destination = segue.destination as! SelectBedtimeReminderViewController
            destination.type = "Edit"
        }
    }
    
    @IBAction func returned(segue: UIStoryboardSegue)
    {
        if segue.identifier == "sessionFinishedComplete"
        {
            
        }
        else if segue.identifier == "sessionFinishedIncomplete"
        {
            
        }
    }
}
