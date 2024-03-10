//
//  LyricsView.swift
//  MusicPlayer
//
//  Created by Mao Jiacheng on 10.03.24.
//

import SwiftUI

import SwiftUI

var test_lyrics  = "This is my attempt\nAttempt\nAttempt...\nTo make an interactive lyric view\nJust like...\nYou see on the Spotify app\nI thought it was an interesting challenge to try and recreate something similar in SwiftUI\nWith ScrollProxies and Publsihed properties\nWith GeomertyReaders and ZStacks\nWe can create something that looks quite cool\nYou can tap on the lyrics to skip the song, or use the scrubber\nWe can hit play\nWe can hit pause\nIf you use this example view whilst listening to a song with lyrics\nIt will confuse your mind\nBecause your brain will try to match the lyrics you hear to this nonsese scrolling by!"

var test_times  =  [0,1,2,4,6,8,10,13,15,18,20,22,24,26,29,32]

struct LyricsView: View {
    
    @ObservedObject var driver = LyricDriver(track: TrackInfo(title: "Lyrics That Flow", artist: "The SwiftUI Band", length: 45, lyrics: test_lyrics, times: test_times))
    
    var body: some View {
        
        VStack(spacing: 0){

            HStack{
                Spacer()
                VStack{
                    Text(driver.trackInfo.title)
                        .bold()
                    Text(driver.trackInfo.artist)
                        .foregroundColor(.gray)
                        .font(.caption)
                }
                
                Spacer()
                
            }.padding(.top, 6)
                .background(driver.themeColor)
            
            ScrollViewReader{ proxy in
                
                
                ScrollView(.vertical, showsIndicators: false){
                    VStack {
                        
                        Text("\n\n\n\n")

                        ForEach(driver.lyricLines, id: \.keyTime){ line in
                            
                            
                            HStack{
                                Text(line.text)
                                
                                    .font(.title)
                                    .bold()
                                    .opacity(driver.time >= line.keyTime ? 1 : 0.5)
                    
                                    
                                Spacer()
                                
                            }.padding(.vertical, 4)
                                .tag(line.keyTime)
                                .onTapGesture {
                    
                                    // By updating the time property on tap gesture, we can tap on a lyric line to scroll to it
                                    
                                    driver.time = line.keyTime
                        
                                }
                            
                        }
                        
                        // This just helps create an empty space below the lyrics so the last lyric line appears nearer middle of scren whens scrolled to.
                        
                        Text("\n\n\n\n\n\n\n\n\n\n")
                    }
                    
                    .onAppear{
                        
                        driver.startTimer()
                        
                    }
                }
                .animation(.linear, value: driver.time)
                
                .onChange(of: driver.time){
                    
                    print(driver.time)
                    
                    withAnimation{
                        proxy.scrollTo(driver.time, anchor: .center)
                    }
                    
                }
            }
            .padding()
            .zIndex(1)
            .mask(LinearGradient(gradient: Gradient(colors: [driver.themeColor, driver.themeColor, driver.themeColor, .clear]), startPoint: .bottom, endPoint: .top))

            MusicControl(driver: self.driver)
        }
        .background(driver.themeColor)

    }
}

#Preview {
    LyricsView()
}
