//
//  SoundManager.swift
//  Bomb Bonanza
//
//  Created by Oprișor Raul-Alexandru on 11.07.2022.
//

import Foundation
import AVFoundation
import AVKit

class SoundManager {
    //    Play a sound when a special action happens in-game
    static let instance = SoundManager()
    var player: AVAudioPlayer?
    
    func playSound(nameOfSound : String) {
        guard let url = Bundle.main.url(forResource: nameOfSound, withExtension: ".mp3") else { return }
        do{
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error  playing sound. \(error.localizedDescription)")
        }
    }
}

var sound = AVAudioPlayer()
func playMP3() -> Void {
    let bundle = Bundle.main
    let url = bundle.url(forResource: "Assets/this", withExtension: "mp3")
    if let u = url {
        do {
            sound = try AVAudioPlayer(contentsOf: u, fileTypeHint: AVFileType.mp3.rawValue)
            sound.prepareToPlay()
            sound.play()
        } catch let error {
            print(error.localizedDescription)
        }
    } else {
        print("Could not find resource!")
    }
}
