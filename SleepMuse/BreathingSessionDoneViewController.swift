//
//  BreathingSessionDoneViewController.swift
//  SleepMuse
//
//  Created by William Chrisandy on 07/04/22.
//

import UIKit
import AVFoundation

class BreathingSessionDoneViewController: UIViewController
{
    var musicPlayer = ModelAudioPlayer()
    var musicData: MusicData?
    var pickedMusicData: PickedMusic?
    
    // For Playing The Audio
    var player: AVAudioPlayer?
    
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        musicPlayer.player?.stop()
        dismiss(animated: true, completion: nil)
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
