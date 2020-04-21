//
//  SoundManager.swift
//  Flipit
//
//  Created by Mohamed Sayyaf on 19/04/20.
//  Copyright © 2020 Mohamed Sayyaf. All rights reserved.
//

import Foundation
import AVFoundation

// class for interacting and impplementing sounds
class SoundManager{
    
    static var audioPlayer: AVAudioPlayer? //class inside the avfoundation framework
    
    enum SoundEffect {
        case flip
        case match
        case nomatch
        case shuffle
    }
    
    static func playSound(_ effect: SoundEffect) {
        
        var soundFilename = ""
        
        // Determine which sound effect we want to play and settind he correct filename
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
        
        // Get the path to the sound file inside the bundle
        let bundlePath = Bundle.main.path(forResource: soundFilename, ofType: "wav")
        
        guard bundlePath != nil else {
            print("Couldn't fine sound file \(soundFilename) in the bundle")
            return
        }
        
        // Create a URL Object from this string path
        let soundURL = URL(fileURLWithPath: bundlePath!)
        
        do{
        // Create audio player object
        
        audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
        
            audioPlayer?.play() // for playing the sound
        }
        // same liketry catch exception
            
        catch{
            print("Couldnt create audio player object for \(soundFilename)")
        }
    }
    
}
