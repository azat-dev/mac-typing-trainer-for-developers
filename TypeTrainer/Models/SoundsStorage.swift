//
//  SoundsStorage.swift
//  TypeTrainer
//
//  Created by Azat Kaiumov on 08.05.2020.
//  Copyright © 2020 Azat Kaiumov. All rights reserved.
//
import AVFoundation

class SoundsStorage {
    private var urls = [String: URL]()
    private var currentPlayers = [AVPlayer]()
    
    init(fileNames: [String]) {
        for fileName in fileNames {
            loadSound(fileName: fileName)
        }
    }
    
    private func loadSound(fileName: String) {
        let url = Bundle.main.url(forResource: fileName, withExtension: nil)
        urls[fileName] = url
    }
    
    func playSound(_ fileName: String) {
        let url = urls[fileName]
        
        
        let soundEffect = AVPlayer(url: url!)
        currentPlayers.append(soundEffect)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(playerItemDidReachEnd),
            name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
            object: nil
        ) // Add observer

        soundEffect.play()
    }
    
    @objc func playerItemDidReachEnd(notification: NSNotification) {
        let playerItem: AVPlayerItem = notification.object as! AVPlayerItem
        currentPlayers.removeAll { $0.currentItem == playerItem }
    }
}
