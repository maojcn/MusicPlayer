//
//  ContentView.swift
//  MusicPlayer
//
//  Created by Mao Jiacheng on 06.03.24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @EnvironmentObject var songState: SongState

    var body: some View {

        ZStack{
            LinearGradient(gradient: Gradient(colors: [.yellow, .orange]), startPoint: .top, endPoint: .bottom)
                        .edgesIgnoringSafeArea(.all)
            
            LyricsView(song: songEntity)
            .ignoresSafeArea()
            VStack{
                AudioPlayerView()
                    .background(Color.yellow.opacity(0.4))
                    .cornerRadius(6)
                    .shadow(color:.orange ,radius: 20)
                Spacer()
            }
            
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(SongState())
}
