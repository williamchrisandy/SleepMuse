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
    var instructorVoicePlayer = ModelAudioPlayer()
    var musicData: MusicData?
    var pickedMusicData: PickedMusic?
    var twoAudioPlayer = ModelTwoAudioPlayer()
    
    // Outlets
    @IBOutlet weak var pauseBreathingButton: UIButton!
    @IBOutlet weak var muteMusicButton: UIButton!
    @IBOutlet weak var muteInstructorButton: UIButton!
    
    @IBOutlet weak var breatheProgressBar: UIProgressView!
    @IBOutlet weak var currentProgressLabel: UILabel!
    
    @IBOutlet weak var breatheLabel: UILabel!
    @IBOutlet var moonGlowView: UIImageView!
    
    // Boolean for the Buttons
    var currentPlayAudio = true // For pausing the breathing session and music
    var currentMuteMusic = false // For mute or unmute the music
    var currentMuteInstructor = false // For mute or unmute the instructor voice
    var moonGlowSizeSmall = true // For animating the moon glow size to bigger and smaller
    
    // Initializers
    var currentProgress = 0
    var currentBreatheTime = 0

    
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
        
        // USE THIS FUNCTION TO PLAY ALL OF THE AUDIO FILES V2: THE MUSIC COMES SINCE IN THE BEGINNING WITH THE OPENING + CHANGING THE BREATHE LABEL
        twoAudioPlayer.playAudio(musicAudio: theMusicAudio, totalMusicRepeat: Int(theMusicRepeat))
        
        // CHANGING THE BREATH LABEL ABOVE THE MOON
        breatheLabel.text = "Get settled"
        DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
            self.breatheLabel.text = "into a comfortable"
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+2.7) {
            self.breatheLabel.text = "position on your bed"
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+6.5) {
            self.breatheLabel.text = "Let go of any tension"
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+9) {
            self.breatheLabel.text = "you might be holding"
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+12.1) {
            self.breatheLabel.text = "Feel your head"
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+13.5) {
            self.breatheLabel.text = "sink deeper"
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+16) {
            self.breatheLabel.text = "into your pillow"
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+18.7) {
            self.breatheLabel.text = "Close your Eyes"
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+21.5) {
            self.breatheLabel.text = "And now,"
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+23.9) {
            self.breatheLabel.text = "Let's begin"
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+26) {
            UIView.animate(withDuration: 1, animations: {
                self.breatheLabel.alpha = 0.0
            })
        }
        
        // STARTING THE BREATHING EXERCISE: PLAY THE INSTRUCTOR VOICE & CHANGE THE BREATHE LABEL AUTOMATICALLY
        moonGlowView.alpha = 0.0 // Initiate the moonGlowView Opacity to 0
        
        DispatchQueue.main.asyncAfter(deadline: .now()+27) {
            print("Async after 27 seconds")
            self.breatheLabel.text = "Breathe In"
            UIView.animate(withDuration: 1, animations: {
                self.breatheLabel.alpha = 1.0
            })
            DispatchQueue.main.asyncAfter(deadline: .now()+3) {
                UIView.animate(withDuration: 1, animations: {
                    self.breatheLabel.alpha = 0.0
                })
            }
            self.instructorVoicePlayer.playAudio(musicAudio: "Breathe", totalMusicRepeat: 87)
//            self.animateMoonGlow(isGlowSizeSmall: true)
//            self.animateMoonGlowBig()
            UIView.animate(withDuration: 5, animations: {
                self.moonGlowView.alpha = 1.0
            })
            
            for currentBreatheTime in 1...870 {
                DispatchQueue.main.asyncAfter(deadline: .now()+Double(currentBreatheTime)+0.1) {
                    print("currentBreatheTime: \(currentBreatheTime)")
                    if currentBreatheTime % 5 == 0 && currentBreatheTime % 10 != 0 {
                        print("Result currentBreatheTime % 5 : \(currentBreatheTime % 5)")
                        
                        self.breatheLabel.text = "Breathe Out"
                        UIView.animate(withDuration: 1, animations: {
                            self.breatheLabel.alpha = 1.0
                        })
                        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
                            UIView.animate(withDuration: 1, animations: {
                                self.breatheLabel.alpha = 0.0
                            })
                        }
                        print("the breatheLabel.text : \(String(describing: self.breatheLabel.text))")
                        
                        UIView.animate(withDuration: 5, animations: {
                            self.moonGlowView.alpha = 0.0
                        })
//                        self.animateMoonGlowBig()
//                        self.animateMoonGlow(isGlowSizeSmall: true)
                    } else if currentBreatheTime % 10 == 0 {
                        print("Result currentBreatheTime % 10 : \(currentBreatheTime % 10)")
                        
                        self.breatheLabel.text = "Breathe In"
                        UIView.animate(withDuration: 1, animations: {
                            self.breatheLabel.alpha = 1.0
                        })
                        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
                            UIView.animate(withDuration: 1, animations: {
                                self.breatheLabel.alpha = 0.0
                            })
                        }
                        print("the breatheLabel.text : \(String(describing: self.breatheLabel.text))")
                        
                        UIView.animate(withDuration: 5, animations: {
                            self.moonGlowView.alpha = 1.0
                        })
//                        self.animateMoonGlowSmall()
//                        self.animateMoonGlow(isGlowSizeSmall: false)
                    }
                }
            }
        }
        
        breatheProgressBar.setProgress(0.0, animated: false)
        currentProgressLabel.text = "00:00"
        
        // USE THIS TO USE THE PROGRESS BAR
        for currentProgress in 1...900 {
            DispatchQueue.main.asyncAfter(deadline: .now()+Double(currentProgress), execute: {
                print("currentProgress for Bar and Label : \(currentProgress)")
                
                // Update the Progress Bar
                self.breatheProgressBar.setProgress(Float(currentProgress)/900, animated: true)
                
                // Update the Progress Label
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
                    // The BreathingSessionViewController Changes to the BreathingSessionDoneViewController (Using Segue)
                    self.performSegue(withIdentifier: "goToBreathingSessionDone", sender: self)
                }
            })
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        instructorVoicePlayer.player?.stop()
        twoAudioPlayer.musicPlayer?.stop()
        twoAudioPlayer.voicePlayer?.stop()
//        dismiss(animated: true, completion: nil)
        performSegue(withIdentifier: "sessionFinishedIncomplete", sender: self)
    }
    
    @IBAction func pauseBreathingButtonPressed(_ sender: UIButton) {
        if currentPlayAudio {
            instructorVoicePlayer.player?.pause()
            twoAudioPlayer.musicPlayer?.pause()
            pauseBreathingButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            currentPlayAudio = false
        } else {
            instructorVoicePlayer.player?.play()
            twoAudioPlayer.musicPlayer?.play()
            pauseBreathingButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            currentPlayAudio = true
        }
        print("currentPlayAudio : \(currentPlayAudio)")
    }
    
    @IBAction func muteMusicButtonPressed(_ sender: UIButton) {
        print("Current Music Volume : \(String(describing: twoAudioPlayer.musicPlayer?.volume))")
        print("Current Mute Music (Before): \(currentMuteMusic)")
        
        if currentMuteMusic {
            twoAudioPlayer.musicPlayer?.setVolume(0.5, fadeDuration: 0)
            self.muteMusicButton.setImage(UIImage(named: "Mute Music"), for: .normal)
            self.currentMuteMusic = false
            
        } else {
            twoAudioPlayer.musicPlayer?.setVolume(0.0, fadeDuration: 0)
            self.muteMusicButton.setImage(UIImage(named: "Unmute Music"), for: .normal)
            self.currentMuteMusic = true
        }
        print("Current Mute Music (After): \(currentMuteMusic)")
    }
    
    @IBAction func muteInstructorButtonPressed(_ sender: UIButton) {
        print("Current Instructor Voice Volume : \(String(describing: twoAudioPlayer.voicePlayer?.volume))")
        print("Current Mute Instructor Voice (Before): \(currentMuteInstructor)")
        
        if currentMuteInstructor {
            instructorVoicePlayer.player?.setVolume(2.0, fadeDuration: 0)
            twoAudioPlayer.voicePlayer?.setVolume(1.5, fadeDuration: 0)
            self.muteInstructorButton.setImage(UIImage(named: "Mute Instructor"), for: .normal)
            currentMuteInstructor = false
        } else {
            instructorVoicePlayer.player?.setVolume(0.0, fadeDuration: 0)
            twoAudioPlayer.voicePlayer?.setVolume(0.0, fadeDuration: 0)
            self.muteInstructorButton.setImage(UIImage(named: "Unmute Instructor"), for: .normal)
            currentMuteInstructor = true
        }
        print("Current Mute Instructor Voice (After): \(currentMuteInstructor)")
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "goToBreathingSessionDone"
        {
            let destination = segue.destination as! BreathingSessionDoneViewController
            destination.pickedMusicData = pickedMusicData
        }
    }
}
