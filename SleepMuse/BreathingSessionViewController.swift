//
//  BreathingSessionViewController.swift
//  SleepMuse
//
//  Created by William Chrisandy on 07/04/22.
//  PIC: Qhanza
//

import UIKit
import AVFoundation

class BreathingSessionViewController: UIViewController
{
    var musicPlayer = ModelAudioPlayer()
    var instructorVoicePlayer = ModelAudioPlayer()
    var musicData: MusicData?
    var pickedMusicData: PickedMusic?
    
    // Outlets
    @IBOutlet weak var pauseBreathingButton: UIButton!
    @IBOutlet weak var muteMusicButton: UIButton!
    @IBOutlet weak var muteInstructorButton: UIButton!
    
    @IBOutlet weak var breatheProgressBar: UIProgressView!
    @IBOutlet weak var currentProgressLabel: UILabel!
    
    
    // For Playing The Audio
    var player: AVAudioPlayer?
    
    // Boolean for the Buttons
    var currentPlayAudio = true // For pausing the breathing session and music
    var currentMuteMusic = false // For mute or unmute the music
    var currentMuteInstructor = false // For mute or unmute the instructor voice
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Unwrapping Optional Passed Data from the StartBreathingViewController with Coalescing Operator
        let theMusicAudio = pickedMusicData?.chosenMusicAudio ?? "No Music Audio is Detected"
        let theMusicTimer = pickedMusicData?.chosenMusicTimer ?? 0.0
        let theMusicRepeat = pickedMusicData?.chosenMusicRepeat ?? 0.0
        
        print("This is the Picked Music Audio: \(theMusicAudio)")
        print("This is the Picked Music Timer: \(theMusicTimer)")
        print("This is the Picked Music Repeat: \(theMusicRepeat)")
        
        // USE THIS FUNCTION TO PLAY THE MUSIC AUDIO (WORKS)
        musicPlayer.playAudio(musicAudio: theMusicAudio, totalMusicRepeat: Int(theMusicRepeat))
        
        // USE THIS FUNCTION TO PLAY THE INSTRUCTOR AUDIO (WORKS)
        let instructorVoiceOpening = "Opening"
        print("instructorVoiceOpening : \(instructorVoiceOpening)")
        instructorVoicePlayer.playAudio(musicAudio: instructorVoiceOpening, totalMusicRepeat: 1)
        
        let instructorVoiceBreathe = "Breathe"
        print("instructorVoiceBreathe : \(instructorVoiceBreathe)")
        instructorVoicePlayer.playAudio(musicAudio: instructorVoiceBreathe, totalMusicRepeat: 87)
        
        breatheProgressBar.setProgress(0.0, animated: false)
        currentProgressLabel.text = "00:00"
        
        // USE THIS TO USE THE PROGRESS BAR
        for currentProgress in 1...900 {
            DispatchQueue.main.asyncAfter(deadline: .now()+(Double(currentProgress)+0.0001), execute: {
                print("currentProgress for Bar and Label : \(currentProgress)")
                self.breatheProgressBar.setProgress(Float(currentProgress)/900, animated: true)
                if currentProgress < 10 {
                    self.currentProgressLabel.text = "00:0\(currentProgress)"
                } else if currentProgress < 60 {
                    self.currentProgressLabel.text = "00:\(currentProgress)"
                } else if currentProgress < 70 {
                    self.currentProgressLabel.text = "01:0\(currentProgress-60)"
                } else if currentProgress < 120 {
                    self.currentProgressLabel.text = "01:\(currentProgress-60)"
                } else if currentProgress < 130 {
                    self.currentProgressLabel.text = "02:0\(currentProgress-120)"
                } else if currentProgress < 180 {
                    self.currentProgressLabel.text = "02:\(currentProgress-120)"
                } else if currentProgress < 190 {
                    self.currentProgressLabel.text = "03:0\(currentProgress-180)"
                } else if currentProgress < 240 {
                    self.currentProgressLabel.text = "03:\(currentProgress-180)"
                } else if currentProgress < 250 {
                    self.currentProgressLabel.text = "04:0\(currentProgress-240)"
                } else if currentProgress < 300 {
                    self.currentProgressLabel.text = "04:\(currentProgress-240)"
                } else if currentProgress < 310 {
                    self.currentProgressLabel.text = "05:0\(currentProgress-300)"
                } else if currentProgress < 360 {
                    self.currentProgressLabel.text = "05:\(currentProgress-300)"
                } else if currentProgress < 370 {
                    self.currentProgressLabel.text = "06:0\(currentProgress-360)"
                } else if currentProgress < 420 {
                    self.currentProgressLabel.text = "06:\(currentProgress-360)"
                } else if currentProgress < 430 {
                    self.currentProgressLabel.text = "07:0\(currentProgress-420)"
                } else if currentProgress < 480 {
                    self.currentProgressLabel.text = "07:\(currentProgress-420)"
                } else if currentProgress < 490 {
                    self.currentProgressLabel.text = "08:0\(currentProgress-480)"
                } else if currentProgress < 540 {
                    self.currentProgressLabel.text = "08:\(currentProgress-480)"
                } else if currentProgress < 550 {
                    self.currentProgressLabel.text = "09:0\(currentProgress-540)"
                } else if currentProgress < 600 {
                    self.currentProgressLabel.text = "09:\(currentProgress-540)"
                } else if currentProgress < 610 {
                    self.currentProgressLabel.text = "10:0\(currentProgress-600)"
                } else if currentProgress < 660 {
                    self.currentProgressLabel.text = "10:\(currentProgress-600)"
                } else if currentProgress < 670 {
                    self.currentProgressLabel.text = "11:0\(currentProgress-660)"
                } else if currentProgress < 720 {
                    self.currentProgressLabel.text = "11:\(currentProgress-660)"
                } else if currentProgress < 730 {
                    self.currentProgressLabel.text = "12:0\(currentProgress-720)"
                } else if currentProgress < 780 {
                    self.currentProgressLabel.text = "12:\(currentProgress-720)"
                } else if currentProgress < 790 {
                    self.currentProgressLabel.text = "13:0\(currentProgress-780)"
                } else if currentProgress < 840 {
                    self.currentProgressLabel.text = "13:\(currentProgress-780)"
                } else if currentProgress < 850 {
                    self.currentProgressLabel.text = "14:0\(currentProgress-840)"
                } else if currentProgress < 900 {
                    self.currentProgressLabel.text = "14:\(currentProgress-840)"
                } else {
                    self.currentProgressLabel.text = "15:00"
                }
            })
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        musicPlayer.player?.stop()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pauseBreathingButtonPressed(_ sender: UIButton) {
        if currentPlayAudio {
            musicPlayer.player?.pause()
            pauseBreathingButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            currentPlayAudio = false
        } else {
            musicPlayer.player?.play()
            pauseBreathingButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            currentPlayAudio = true
        }
        print("currentPlayAudio : \(currentPlayAudio)")
    }
    
    @IBAction func muteMusicButtonPressed(_ sender: UIButton) {
        print("Current Music Volume : \(String(describing: musicPlayer.player?.volume))")
        print("current Mute Music (Before): \(currentMuteMusic)")
        
        if currentMuteMusic {
            musicPlayer.player?.setVolume(1.0, fadeDuration: 0)
            self.muteMusicButton.setImage(UIImage(named: "Mute Music"), for: .normal)
            self.currentMuteMusic = false
            
        } else {
            musicPlayer.player?.setVolume(0.0, fadeDuration: 0)
            self.muteMusicButton.setImage(UIImage(named: "Unmute Music"), for: .normal)
            self.currentMuteMusic = true
        }
        print("current Mute Music (After): \(currentMuteMusic)")
    }
    
    @IBAction func muteInstructorButtonPressed(_ sender: UIButton) {
        print("Current Music Volume : \(String(describing: instructorVoicePlayer.player?.volume))")
        print("current Mute Instructor (Before): \(currentMuteInstructor)")
        
        if currentMuteInstructor {
            instructorVoicePlayer.player?.setVolume(1.0, fadeDuration: 0)
            self.muteInstructorButton.setImage(UIImage(named: "Mute Instructor"), for: .normal)
            currentMuteInstructor = false
        } else {
            instructorVoicePlayer.player?.setVolume(0.0, fadeDuration: 0)
            self.muteInstructorButton.setImage(UIImage(named: "Unmute Instructor"), for: .normal)
            currentMuteInstructor = true
        }
        print("current Mute Instructor (After): \(currentMuteInstructor)")
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "goToBreathingSessionDone"
        {
//            let previous = segue.destination as! BreathingSessionViewController
//            destination.pickedMusicData = pickedMusic
            let destination = segue.destination as! BreathingSessionDoneViewController
            destination.pickedMusicData = pickedMusicData
        }
    }
}
