//
//  LyricsView.swift
//  MusicPlayer
//
//  Created by Mao Jiacheng on 06.03.24.
//

import SwiftUI

struct LyricsView: View {
    @State var song: Song
    @EnvironmentObject var songState: SongState
    
    var body: some View {
        ScrollViewReader{ proxy in
            List {
                ForEach(song.lyrics, id: \.id) { line in
                    LyricCellView(lyric: line)
                        .id(line.id)
                }
                .listRowSeparator(.hidden)
            }
            .scrollContentBackground(.hidden)
            .onChange(of: songState.currentIndext) { oldIndex, newIndex in
                withAnimation(.linear) {
                    proxy.scrollTo(song.lyrics[newIndex].id, anchor: .center)
                }
                
            }
        }
    }
}

#Preview {
    LyricsView(song: songEntity)
        .environmentObject(SongState())
}
