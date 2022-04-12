//
//  MusicData.swift
//  SleepMuse
//
//  Created by Qhansa D. Bayu on 12/04/22.
//

import Foundation

struct MusicData {
    var musicName: String
    var musicAudio: String
}

var musicDataArray: [MusicData] = [
    MusicData.init(musicName: "Rain Thunder", musicAudio: "rain thunder"),
    MusicData.init(musicName: "Mountain and Waterfall", musicAudio: "mountain and waterfall"),
    MusicData.init(musicName: "Ocean Waves", musicAudio: "ocean waves"),
    MusicData.init(musicName: "Fast River", musicAudio: "fast river"),
    MusicData.init(musicName: "Calm River", musicAudio: "calm river"),
    MusicData.init(musicName: "Rain Forest", musicAudio: "rain forest"),
    MusicData.init(musicName: "Bamboo Forest", musicAudio: "bamboo forest")
]
