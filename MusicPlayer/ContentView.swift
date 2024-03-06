//
//  ContentView.swift
//  MusicPlayer
//
//  Created by Mao Jiacheng on 06.03.24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
//        NavigationSplitView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
//                    } label: {
//                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
//            .toolbar {
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//        } detail: {
//            Text("Select an item")
//        }
        AudioPlayerView()
        LyricsView(song: Song(title: "起风了", lyrics: [
            Lyric(content: "一阵微风塑起记忆", isBlur: false, time: 27),
            Lyric(content: "吹过森林萤火的痕迹", isBlur: true, time: 31),
            Lyric(content: "禁书目录上铭刻着", isBlur: true, time: 34),
            Lyric(content: "魔法的气息", isBlur: true, time: 37),
            Lyric(content: "不禁笑这异世之旅", isBlur: true, time: 40),
            Lyric(content: "又从零开始", isBlur: true, time: 44),
            Lyric(content: "而她的哭泣 泪中的花意 至今仍未知", isBlur: true, time: 45),
            Lyric(content: "我曾握紧刀与剑", isBlur: true, time: 51),
            Lyric(content: "神域之前", isBlur: true, time: 54),
            Lyric(content: "灭鬼之刃扬起烈焰", isBlur: true, time: 56),
            Lyric(content: "也头戴王冠一人将罪恶书写", isBlur: true, time: 58),
            Lyric(content: "徘徊彼方的境界", isBlur: true, time: 63),
            Lyric(content: "追寻千遍", isBlur: true, time: 66),
            Lyric(content: "菓实冰冷浸透齿间", isBlur: true, time: 68),
            Lyric(content: "命运之门依然视而不见", isBlur: true, time: 71),
            Lyric(content: "手中魔刀碎裂了无牵挂", isBlur: true, time: 76),
        ]))
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
