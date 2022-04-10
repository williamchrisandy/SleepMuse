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
    // Outlets
    @IBOutlet weak var musicPicker: UIPickerView!
    @IBOutlet weak var musicTimerHourPicker: UIPickerView!
    @IBOutlet weak var musicTimerMinPicker: UIPickerView!
    
    @IBOutlet weak var startBreathingButton: UIButton!
    
    // Dictionary Data
    let dataMusic : KeyValuePairs =
                    ["Rain Thunder": "rain thunder",
                     "Mountain and Waterfall": "mountain and waterfall",
                     "Ocean Waves": "ocean waves",
                     "Fast River": "fast river",
                     "Calm River": "calm river",
                     "Rain Forest": "rain forest",
                     "Bamboo Forest": "bamboo forest"
                    ]
    
    // Array Data v2 - Based on UX and Spotify Sleep Timer
    let dataMusicTimerHour = [Int](0..<3)
    let dataMusicTimerMin = [0, 2, 15, 30, 45]
    
    // Color Constants
    let sleepmuseWhiteColor = UIColor(named: "SleepMuse Gradient Text Color")
    
    // The Selected Picker View Rows
    var selectedMusicRow = 0
    var selectedMusicTimerHourRow = 0
    var selectedMusicTimerMinRow = 0
    
    // For Playing The Audio
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initializing the musicPicker IBOutlet
        musicPicker.dataSource = self
        musicPicker.delegate = self
        
        // Initializing the musicTimerHourPicker & musicTimerMinPicker IBOutlets
        musicTimerHourPicker.dataSource = self
        musicTimerHourPicker.delegate = self
        musicTimerMinPicker.dataSource = self
        musicTimerMinPicker.delegate = self
    }
    
    @IBAction func startBreathingButtonPressed(_ sender: UIButton) {
        // Selected Music
        self.selectedMusicRow = musicPicker.selectedRow(inComponent: 0)
        let selectedMusic = Array(self.dataMusic)[self.selectedMusicRow]
        let musicName = selectedMusic.key
        let musicAudio = selectedMusic.value
        print("The Music Name : \(musicName)")
        print("The Music Audio : \(musicAudio)")
        
        // Selected Music Timer (Hour)
        self.selectedMusicTimerHourRow = musicTimerHourPicker.selectedRow(inComponent: 0)
        let selectedMusicTimerHour = Array(self.dataMusicTimerHour)[self.selectedMusicTimerHourRow]
        print("The Music Timer Hour : \(selectedMusicTimerHour)")
        
        // Selected Music Timer (Minute)
        self.selectedMusicTimerMinRow = musicTimerMinPicker.selectedRow(inComponent: 0)
        let selectedMusicTimerMin = Array(self.dataMusicTimerMin)[self.selectedMusicTimerMinRow]
        print("The Music Timer Minutes : \(selectedMusicTimerMin)")
        
        // Convert Hour and Minutes to Seconds
        let hourToSec = Double(selectedMusicTimerHour) * 3600
        print("Hour to Seconds : \(hourToSec)")
        let minToSec = Double(selectedMusicTimerMin) * 60
        print("Minutes to Seconds : \(minToSec)")
        let totalSeconds = hourToSec + minToSec
        print("Total Seconds : \(totalSeconds)")
        
        // Calculate the Repeat of the Music
        let totalMusicRepeat = totalSeconds / 60
        print("Total Music Repeat : \(totalMusicRepeat)")
        
        
        // Play the Audio File v2 with Music Duration (Works)
        if let player = player, player.isPlaying {
            // Stop playback
            player.stop()
            
        } else {
            // Set up the Audio
            let urlString = Bundle.main.path(forResource: "\(musicAudio)", ofType: "mp3")
            
            // Play the audio
            do {
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                
                guard let urlString = urlString else {
                    return
                }
                
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                
                guard let player = player else {
                    return
                }
                player.play()
                player.numberOfLoops = Int(totalMusicRepeat)
                
            } catch {
                print("Something went wrong")
            }
        }
        
        // The StartBreathingViewController Changes to the BreathingSessionViewController
        let vc = storyboard?.instantiateViewController(identifier: "breathingsessionVC") as! BreathingSessionViewController
        present(vc, animated: true)
    }
    
    // Functions for Customizing the "Choose the Music" Picker View
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == musicPicker {
            return dataMusic.count
        } else if pickerView == musicTimerHourPicker{
            return dataMusicTimerHour.count
        } else {
            return dataMusicTimerMin.count
        }
    }
        
    // Function for Customizing the musicPicker Text Size, Color, Alignment and Data
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel()
        label.font = UIFont(name: "System", size: 17)
        label.textColor = sleepmuseWhiteColor
        
        // Accessing the Picker View Data with Dictionary
        if pickerView == musicPicker {
            label.text = dataMusic[row].key
            label.textAlignment = .center
        } else if pickerView == musicTimerHourPicker{
            label.text = "\(dataMusicTimerHour[row]) hour"
            label.textAlignment = .right
        } else {
            label.text = "\(dataMusicTimerMin[row]) min"
            label.textAlignment = .left
        }
        
        return label
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
