//
//  MusicControl.swift
//  MusicPlayer
//
//  Created by Mao Jiacheng on 10.03.24.
//

import SwiftUI

struct MusicControl: View {
    
    @ObservedObject var driver : LyricDriver
    @State var progess_size : CGSize = .zero
    @State var lastTranslation : CGSize = .zero
    
    var progress_x_pos : CGFloat{
        
        // Calculates the width of the elapsed time bar using the scaler and the max width of the progress bar from the geometry reader
   
        progess_size.width * progress_scaler
        
    }
   
    init(driver: LyricDriver){
        self.driver = driver
    }
     
    // Proportion of the 'song' that has elapsed....
    
    var progress_scaler : Double{ Double(driver.time) / Double(driver.trackInfo.length) }
   
    // Properties/functions to help display the track timings...
    
    func timeDisplayFormat(time: Int) -> String{
        
        var mins : Int = 0
        var secs : Int = 0
        
        if time >= 60{
            
            mins = time / 60
            secs = time % 60
            
        } else{
            mins = 0
            secs = time
        }
        
        return String(mins) + ":" + secs.twoDigStr
    }
    
    var timeleftDisplay : String{
        
        self.timeDisplayFormat(time: driver.trackInfo.length - driver.time)

    }
    
    var timeDisplay : String{
        
        self.timeDisplayFormat(time: self.driver.time)

    }

    var body: some View {
        
        VStack{
            HStack{
                Text(timeDisplay)
                    .frame(width: 40)
                    .bold()
                
                ZStack{
                    
                    // This is the background scrubber background bar...
                    Rectangle()
                        .frame(height: 2)
                    GeometryReader { proxy in
                        
                        HStack {}
                        // This empty HStack will be the same width as the scrubber bar
                            .onAppear {
                                self.progess_size = proxy.size
                                
                            }
                    }
                    
                    //This is the progress bar to show the time elapsed against the total time
                    
                    Rectangle()
                        .frame(height: 2)
                        .scaleEffect(x: self.progress_scaler, anchor: .leading)
                        .foregroundColor(.green)
                        .animation(.default, value: progress_scaler)
                    
                    // This Circle is at the end of the progress bar and will detect drag gestures for scrubbing
                    
                    Circle()
                        .frame(width: 12, height: 12)
                        .foregroundColor(.green)
                        .position(CGPoint(x: self.progress_x_pos, y: self.progess_size.height/2 ))
                        .animation(.default, value: self.progress_x_pos)
                        .gesture(
                            DragGesture()
                                .onChanged({
                                    
                                    let delta = $0.translation.width - self.lastTranslation.width
                                    var newSize = self.progress_x_pos + delta
                                    driver.time = Int((newSize/self.progess_size.width) * Double(driver.trackInfo.length))
                                    self.lastTranslation = $0.translation
                                    
                                })
                                .onEnded{_ in
                                    self.lastTranslation = .zero
                                }
                        )
                }
                
                Text(timeleftDisplay)
                    .frame(width: 40)
                    .bold()
                
            }
            .padding(.horizontal, 20)
      
            HStack{
                Spacer()
                Image(systemName: driver.isPaused ? "play.circle.fill" :  "pause.circle.fill")
                    .font(.system(size: 70))
                    .onTapGesture {
                        driver.pause_unpause()
                    }
                Spacer()
            }
        }
            .frame(height: 100)
           .background(
                Rectangle()
                    .foregroundColor(driver.themeColor)
                    .blur(radius: 5)
            )
    }
}

extension Int{
    
    // Returns string version of Int with prefix of '0' if under 10
    
    var twoDigStr : String{
        let intStr = String(self)
        if intStr.count == 1{
            return "0" + intStr
        } else {
            return intStr
        }
    }
}

#Preview {
    MusicControl(driver: LyricDriver(track: TrackInfo(title: "Lyrics That Flow", artist: "The SwiftUI Band", length: 45, lyrics: test_lyrics, times: test_times)))
}
