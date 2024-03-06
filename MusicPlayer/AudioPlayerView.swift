//
//  AudioPlayerView.swift
//  MusicPlayer
//
//  Created by Mao Jiacheng on 06.03.24.
//

import SwiftUI
import AVFoundation

struct AudioPlayerView: View {
    @State private var isPlaying = false
    @State private var currentTime: Double = 0
    @State private var totalTime: Double = 0
    
    let audioURL = Bundle.main.url(forResource: "起风了", withExtension: "m4a")!
    let audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: Bundle.main.path(forResource:"起风了", ofType: "m4a")!))
    
    var body: some View {
        VStack{
            
            HStack {
                Button(action: {
                    if isPlaying {
                        audioPlayer.pause()
                    } else {
                        audioPlayer.play()
                    }
                    isPlaying.toggle()
                }) {
                    Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .resizable()
                        .frame(width: 80, height: 80)
                }
                .padding()
                
                VStack{
                    
                    Slider(value: $currentTime, in: 0...totalTime, onEditingChanged: { editing in
                        if !editing {
                            audioPlayer.currentTime = currentTime
                            if isPlaying {
                                audioPlayer.play()
                            }
                        }
                    })
                    .padding()
                    
                    HStack{
                        Text(formatTime(currentTime))
                        Spacer()
                        Text(formatTime(totalTime))
                    }
                    .padding()
                }
            }
            .onAppear {
                totalTime = audioPlayer.duration
                currentTime = audioPlayer.currentTime
            }
            .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { _ in
                if isPlaying {
                    currentTime = audioPlayer.currentTime
                }
            }
            
        }

    }
    
    func formatTime(_ time: Double) -> String {
            let minutes = Int(time) / 60
            let seconds = Int(time) % 60
            return String(format: "%02d:%02d", minutes, seconds)
        }
}

#Preview {
    AudioPlayerView()
}
