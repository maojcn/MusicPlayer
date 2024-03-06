//
//  LyricCellView.swift
//  MusicPlayer
//
//  Created by Mao Jiacheng on 06.03.24.
//

import SwiftUI

struct LyricCellView: View {
    @State var lyric: Lyric
    
    var body: some View {
        Text(lyric.content)
            .foregroundColor(.white)
            .font(.system(size: lyric.isBlur ? 25: 30, weight: .bold, design: .rounded))
            .multilineTextAlignment(.leading)
            .padding([.top, .bottom], 10)
            .blur(radius: lyric.isBlur ? 2: 0)
    }
}

#Preview {
    LyricCellView(lyric: Lyric(content: "灭鬼之刃扬起烈焰", isBlur: false, time: 56))
}
