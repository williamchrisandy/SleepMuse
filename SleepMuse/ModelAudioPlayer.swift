//
//  ModelAudioPlayer.swift
//  SleepMuse
//
//  Created by Qhansa D. Bayu on 12/04/22.
//

import Foundation
import AVFoundation

struct ModelAudioPlayer
{
    
    var musicAudio: String?
    var musicRepeat: Int?
    
    // For Playing The Audio
    var player: AVAudioPlayer?
    
    mutating func playAudio(musicAudio: String)
    {
        // Play the Audio File v2 with Music Duration (Works)
        if let player = player, player.isPlaying
        {
            // Stop playback
            player.stop()
        }
        
        // Set up the Audio
        let urlString = Bundle.main.path(forResource: "\(musicAudio)", ofType: "mp3")
        
        // Play the audio
        do
        {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let urlString = urlString
            else
            {
                return
            }
            
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
            
            guard let player = player
            else
            {
                return
            }
            player.play()
            player.numberOfLoops = 0
            player.setVolume(2.0, fadeDuration: 0)
            
        }
        catch
        {
            print("Something went wrong")
        }
    }
}
