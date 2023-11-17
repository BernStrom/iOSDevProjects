//
//  SoundManager.swift
//  Match
//
//  Created by Bern N on 11/17/23.
//

import Foundation
import AVFoundation

class SoundManager {
    
    var audioPlayer: AVAudioPlayer?
    
    enum SoundEffect {
        case flip, match, nomatch, shuffle
    }
    
    func playSound(effect: SoundEffect) {
        var soundFilename = ""
        
        switch effect {
        case .flip:
            soundFilename = "cardflip"
        case .match:
            soundFilename = "dingcorrect"
        case .nomatch:
            soundFilename = "dingwrong"
        case .shuffle:
            soundFilename = "shuffle"
        }
        
        // Get the path to the sound effects resource
        let bundlePath = Bundle.main.path(forResource: soundFilename, ofType: ".wav")
        
        // Check the sound effects bundle path isn't nill
        guard bundlePath != nil else {
            return
        }
        
        let url = URL(filePath: bundlePath!)
        
        do {
            // Create the audio player and play the sound effect
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Couldn't create an audio player")
            return
        }
    }
    
}
