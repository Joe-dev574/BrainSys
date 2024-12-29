//
//  HapticManager.swift
//  BrainSys
//
//  Created by Joseph DeWeese on 12/25/24.
//

import Foundation
import SwiftUI


class HapticManager {
    
    static private let hapticFeedbackGenerator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        hapticFeedbackGenerator.notificationOccurred(type)
    
    }
}
