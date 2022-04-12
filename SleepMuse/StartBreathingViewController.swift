//
//  StartBreathingViewController.swift
//  SleepMuse
//
//  Created by William Chrisandy on 07/04/22.
//  PIC: Qhanza
//

import UIKit
import AVFoundation

class StartBreathingViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var modelAudioPlayer = ModelAudioPlayer()
    
    // Outlets
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initializing the musicPicker IBOutlet
        musicPicker.dataSource = self
        musicPicker.delegate = self
        
        // Customizing the Music Timer Date Picker IBOutlet
        musicTimerDatePicker.setValue(sleepmuseWhiteColor, forKeyPath: "textColor")
        musicTimerDatePicker.datePickerMode = .countDownTimer
        musicTimerDatePicker.minuteInterval = 15
        
        self.musicTimerDatePicker.addTarget(self, action: #selector(datePickedValueChanged), for: .valueChanged)
        musicTimerDatePicker.countDownDuration = 2
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
//        performSegue(withIdentifier: "goToBreathingSession", sender: self)
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
        if (self.musicTimerDatePicker.countDownDuration > 7200) { //5400 seconds = 1h30min
            self.musicTimerDatePicker.countDownDuration = 900.0; //Defaults to 1 minute
        }
        print("Test DatePickedValueChanged")
    }


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "goToBreathingSession"
        {
            let destination = segue.destination as! BreathingSessionViewController
            destination.pickedMusicData = pickedMusic
        }
    }

}
