//
//  TintColor.swift
//  BrainSys
//
//  Created by Joseph DeWeese on 12/23/24.
//

import Foundation
import SwiftUI


struct TintColor: Identifiable {
    
    let id: UUID = UUID()
    
    let color: String
    var value: Color
}
    var tints: [TintColor] = [
        .init(color: "Red", value: .red),
        .init(color: "Blue", value: .blue),
        .init(color: "Pink", value: .pink),
        .init(color: "Purple", value: .purple),
        .init(color: "Orange", value: .orange),
        .init(color: "Cyan", value: .cyan),
        .init(color: "Indigo", value: .indigo),
        .init(color: "Yellow", value: .yellow),
        .init(color: "Green", value: .green),
        .init(color: "OliveDrab", value: .oliveDrab),
        .init(color: "LightGrey", value: .lightGrey),
        .init(color: "MediumGrey", value: .mediumGrey),
        .init(color: "MediumBlue", value: .mediumBlue),
        .init(color: "LightBlue", value: .lightBlue)
    ]
    
    