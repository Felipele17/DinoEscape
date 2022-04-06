//
//  Music.swift
//  DinoEscape
//
//  Created by Raphael Alkamim on 23/03/22.
//

import Foundation
import AVFAudio

class MusicService {
    static let shared = MusicService()
    
    private var audioPlayer: [String: AVAudioPlayer] = [:]

    func toggleMusic() {
        switch self.updateUserDefaults() {
        case true:
            self.soundManager(with: .gameMusic, action: .play)
            
        case false:
            self.soundManager(with: .gameMusic, action: .pause)
        }
    }
    
    func playGameMusic() {
        if getUserDefaultsStatus() == true {
            soundManager(with: .otherScenes, action: .pause)
            soundManager(with: .gameMusic, action: .play)
        } else {
            soundManager(with: .gameMusic, action: .pause)
        }
    }
    
    func playLoungeMusic() {
        if getUserDefaultsStatus() == true {
            soundManager(with: .gameMusic, action: .pause)
            soundManager(with: .otherScenes, action: .play)
        } else {
            soundManager(with: .otherScenes, action: .pause)
        }
    }
    
    func getUserDefaultsStatus() -> Bool {
        return UserDefaults.standard.bool(forKey: "music")
    }
    
    func updateUserDefaults() -> Bool {
        var music = UserDefaults.standard.bool(forKey: "music")
        music.toggle()
        UserDefaults.standard.setValue(music, forKey: "music")
        return self.getUserDefaultsStatus()
    }
    
    func soundManager(with music: MusicType, action: SoundAction ) {
        let audio = self.getMusic(musicType: music)
        
        if let audio = audio {
            switch action {
            case .play:
                if UserDefaults.standard.bool(forKey: "music") {
                    audio.play()
                }
            case .pause:
                audio.stop()
            }
        }
    }
    
    func getMusic(musicType: MusicType) -> AVAudioPlayer? {
        if let music = self.audioPlayer[musicType.rawValue] {
            return music
        }
        
        if let musicFile = Bundle.main.path(forResource: musicType.rawValue, ofType: "mp3") {
            do {
                let music = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: musicFile))
                music.numberOfLoops = -1
                music.play()
                
                switch musicType {
                case.gameMusic:
                    music.volume = 0.1
                case.otherScenes:
                    music.volume = 0.1
                }
                self.audioPlayer[musicType.rawValue] = music
                return music
                
            } catch {
                print(error)
                return nil
            }
            
        }
        return nil
    }
}
