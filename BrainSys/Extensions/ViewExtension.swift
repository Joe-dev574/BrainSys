//
//  ViewExtension.swift
//  BrainSys
//
//  Created by Joseph DeWeese on 12/28/24.
//

import SwiftUI

extension View {
    @ViewBuilder
    func hSpacing(_ alignment: Alignment = .center) -> some View {
        self
        .frame(maxWidth: .infinity, alignment: alignment)
    }
    @ViewBuilder
    func vSpacing(_ alignment: Alignment = .center) -> some View {
        self
        .frame(maxHeight: .infinity, alignment: alignment)
    }
    @available(iOSApplicationExtension, unavailable)
    var safeArea: UIEdgeInsets {
        if let windowScene = (UIApplication.shared.connectedScenes.first as? UIWindowScene) {
            return windowScene.keyWindow?.safeAreaInsets ?? .zero
        }
        return .zero
    }
    func format(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    var appTint: Color {
        return Constants.shared.tintColor
    }
}

