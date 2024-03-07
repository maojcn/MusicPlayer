//
//  Song.swift
//  MusicPlayer
//
//  Created by Mao Jiacheng on 06.03.24.
//

import Foundation

class Song: ObservableObject {
    var title: String
    var lyrics: [Lyric]
    
    init(title: String, lyrics: [Lyric]) {
        self.title = title
        self.lyrics = lyrics
    }
}


class Lyric: Hashable {
    var id: UUID = UUID()
    var content: String
    var isBlur: Bool
    var time: Int
    
    init(content: String, isBlur: Bool, time: Int) {
        self.content = content
        self.isBlur = isBlur
        self.time = time
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Lyric, rhs: Lyric) -> Bool {
        return lhs.id == rhs.id
    }
}
