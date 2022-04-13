//
//  ModelTwoAudioPlayer.swift
//  SleepMuse
//
//  Created by Qhansa D. Bayu on 14/04/22.
//

import Foundation
import AVFoundation

struct ModelTwoAudioPlayer {
    
    var musicAudio: String?
    var musicRepeat: Int?
    var openingAudio: String = "Opening"
    
    // For Playing The Audio
    var musicPlayer: AVAudioPlayer?
    var voicePlayer: AVAudioPlayer?
    var openingPlayer: AVAudioPlayer?
    
    // For Checking If the Opening from the Voice Instructor is Done
    
    mutating func playAudio(musicAudio: String, totalMusicRepeat: Int){
        // Play the Music Audio File and the Instructor Voice in Parallel
        if let musicPlayer = musicPlayer, musicPlayer.isPlaying, let voicePlayer = voicePlayer, voicePlayer.isPlaying   {
            // Stop playback
            musicPlayer.stop()
            voicePlayer.stop()
            
        } else {
            // Set up the Audio
            let urlStringMusic = Bundle.main.path(forResource: "\(musicAudio)", ofType: "mp3")
            let urlStringVoice = Bundle.main.path(forResource: "\(openingAudio)", ofType: "mp3")
            
            
            // Play the audio
            do {
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                
                guard let urlStringMusic = urlStringMusic else {
                    return
                }
                guard let urlStringVoice = urlStringVoice else {
                    return
                }
                
                musicPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlStringMusic))
                voicePlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlStringVoice))
                
                
                guard let musicPlayer = musicPlayer else {
                    return
                }
                musicPlayer.play()
                musicPlayer.numberOfLoops = totalMusicRepeat
                musicPlayer.setVolume(0.5, fadeDuration: 0)
                
                guard let voicePlayer = voicePlayer else {
                    return
                }
                voicePlayer.play()
                voicePlayer.numberOfLoops = 0
                voicePlayer.setVolume(1.5, fadeDuration: 0)
                
            } catch {
                print("Something went wrong")
            }
        }
        
    }
}
