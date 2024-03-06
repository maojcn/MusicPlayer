//
//  Item.swift
//  MusicPlayer
//
//  Created by Mao Jiacheng on 06.03.24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
