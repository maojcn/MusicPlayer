//
//  MusicPlayerApp.swift
//  MusicPlayer
//
//  Created by Mao Jiacheng on 06.03.24.
//

import SwiftUI
import SwiftData

@main
struct MusicPlayerApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(SongState())
        }
    }
}
