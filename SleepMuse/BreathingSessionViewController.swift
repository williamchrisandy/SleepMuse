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
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet var moonGlowView: UIImageView!
    
    // Boolean for the Buttons
    var currentPlayAudio = true // For pausing the breathing session and music
    var currentMuteMusic = false // For mute or unmute the music
    var currentMuteInstructor = false // For mute or unmute the instructor voice
    var moonGlowSizeSmall = true // For animating the moon glow size to bigger and smaller
    
    // Initializers
    var currentProgress = 0
    var currentBreatheTime = 0
    var time = 0

    func playAndCheck(second: Double)
    {
        time = Int(second)
        
        let endSecond = pickedMusicData?.chosenMusicTimer ?? 0
        guard second < endSecond
        else
        {
            self.performSegue(withIdentifier: "goToBreathingSessionDone", sender: self)
            return
        }
        
        if second == 0          { breatheLabel.text = "Get settled" }
        else if second == 1.5   { breatheLabel.text = "into a comfortable" }
        else if second == 2.5   { breatheLabel.text = "position on your bed" }
        else if second == 6.5   { breatheLabel.text = "Let go of any tension" }
        else if second == 9     { breatheLabel.text = "you might be holding" }
        else if second == 12    { breatheLabel.text = "Feel your head" }
        else if second == 13.5  { breatheLabel.text = "sink deeper" }
        else if second == 16    { breatheLabel.text = "into your pillow" }
        else if second == 18.5  { breatheLabel.text = "Close your Eyes" }
        else if second == 21.5  { breatheLabel.text = "And now," }
        else if second == 23.5    { breatheLabel.text = "Let's begin" }
        else if second >= 30 && second == Double(Int(second))
        {
            let baseSecond = Int(second) - 30
            
            if baseSecond % 10 == 0
            {
                instructorVoicePlayer.playAudio(musicAudio: "Breathe")
                breatheLabel.text = "Breathe In"
                UIView.animate(
                    withDuration: 3,
                    delay: 0,
                    options: .curveEaseIn,
                    animations:
                        {
                            [weak self] in
                            self?.moonGlowView.alpha = 1
                            self?.breatheLabel.alpha = 1
                        }
                )
            }
            else if baseSecond % 5 == 0
            {
                UIView.transition(
                    with: self.breatheLabel,
                    duration: 1,
                    options: .transitionFlipFromBottom,
                    animations:
                        {
                            [weak self] in
                            self?.breatheLabel.text = "Breathe Out"
                        },
                    completion: nil
                )
                UIView.animate(
                    withDuration: 3,
                    delay: 1,
                    options: .curveEaseOut,
                    animations:
                        {
                            [weak self] in
                            self?.moonGlowView.alpha = 0
                            self?.breatheLabel.alpha = 0
                        }
                )
            }
        }
        
        if second == Double(Int(second))
        {
            breatheProgressBar.setProgress(Float(second/endSecond), animated: true)
            currentProgressLabel.text = StaticFunction.secondToHHMMSS(Int(second))
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5)
        {
            [weak self] in
            self?.playAndCheck(second: self?.currentPlayAudio == false ? second : second + 0.5)
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Unwrapping Optional Passed Data from the StartBreathingViewController with Coalescing Operator
        let theMusicAudio = pickedMusicData?.chosenMusicAudio ?? "No Music Audio is Detected"
        let theMusicTimer = pickedMusicData?.chosenMusicTimer ?? 0.0
        let theMusicRepeat = pickedMusicData?.chosenMusicRepeat ?? 0.0
        
        // USE THIS FUNCTION TO PLAY ALL OF THE AUDIO FILES V2: THE MUSIC COMES SINCE IN THE BEGINNING WITH THE OPENING + CHANGING THE BREATHE LABEL
        twoAudioPlayer.playAudio(musicAudio: theMusicAudio, totalMusicRepeat: Int(theMusicRepeat))
        
        moonGlowView.alpha = 0
        totalTimeLabel.text = StaticFunction.secondToHHMMSS(Int(pickedMusicData?.chosenMusicTimer ?? 0))
        playAndCheck(second: 0)
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
            twoAudioPlayer.musicPlayer?.pause()
            if time < 30 { twoAudioPlayer.voicePlayer?.pause() }
            else { instructorVoicePlayer.player?.pause() }
            pauseBreathingButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            currentPlayAudio = false
        } else {
            twoAudioPlayer.musicPlayer?.play()
            if time < 30 { twoAudioPlayer.voicePlayer?.play() }
            else { instructorVoicePlayer.player?.play() }
            pauseBreathingButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            currentPlayAudio = true
        }
    }
    
    @IBAction func muteMusicButtonPressed(_ sender: UIButton) {
        if currentMuteMusic {
            twoAudioPlayer.musicPlayer?.setVolume(0.5, fadeDuration: 0)
            self.muteMusicButton.setImage(UIImage(named: "Mute Music"), for: .normal)
            self.currentMuteMusic = false
            
        } else {
            twoAudioPlayer.musicPlayer?.setVolume(0.0, fadeDuration: 0)
            self.muteMusicButton.setImage(UIImage(named: "Unmute Music"), for: .normal)
            self.currentMuteMusic = true
        }
    }
    
    @IBAction func muteInstructorButtonPressed(_ sender: UIButton) {
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
