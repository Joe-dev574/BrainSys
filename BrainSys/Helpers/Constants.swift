//
//  Constants.swift
//  BrainSys
//
//  Created by Joseph DeWeese on 12/23/24.
//

import SwiftUI

@Observable
class Constants {
    static let shared = Constants()
    
    var appTint: String = UserDefaults.standard.string(forKey: "appTint") ?? "OliveDrab"
    
    var tintColor: Color {
        return tints.first { $0.color == appTint }?.value ?? .blue
    }
   
}
