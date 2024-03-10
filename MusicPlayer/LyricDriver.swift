//
//  LyricDriver.swift
//  MusicPlayer
//
//  Created by Mao Jiacheng on 10.03.24.
//

import Foundation
import SwiftUI

struct TrackInfo {
    
    var title : String
    var artist : String
    var length : Int

    var lyrics : String
    var times : [Int]
}

struct LyricLine : Identifiable{
    
    let id = UUID()
    let seq : Int
    let text : String
    let keyTime : Int
    
}

class LyricDriver : ObservableObject{
   
    @Published var lyricLines = [LyricLine]()
    @Published var time = 0
    @Published var isPaused = false
    
    var themeColor = Color(red: 46.0/255, green: 81.0/255, blue: 140.0/255)
    
    var timer = Timer()
        
    let trackInfo : TrackInfo
    
    init(track: TrackInfo){
        
        self.trackInfo = track
        self.convertToLyricLine()
      
    }
    
    @objc private func fireTimer(){
        
        // Called each time the 1-second Timer fires (so each second) - progress time if song isn't finsihed or paused
         
        if !isPaused && time <= self.trackInfo.length{
            time += 1
        }
        
    }
    
    func pause_unpause(){
        isPaused.toggle()
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    
    private func convertToLyricLine(){
        
        let parts = self.trackInfo.lyrics.split(separator: "\n")
        
        var seq = 0
        for line in parts{
            
            self.lyricLines.append(LyricLine(seq: seq, text: String(line), keyTime: trackInfo.times[seq]))
            
            seq += 1
        }
        
    }
}
