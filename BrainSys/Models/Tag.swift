//
//  Tag.swift
//  BrainSys
//
//  Created by Joseph DeWeese on 12/29/24.
//

import SwiftUI
import SwiftData

@Model
class Tag {
    var name: String = ""
    var color: String = "FF0000"
    var items: [Item]?
    
    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
    
    var hexColor: Color {
        Color(self.color) ?? .red
    }
}



