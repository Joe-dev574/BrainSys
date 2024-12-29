//
//  LogoView.swift
//  BrainSys
//
//  Created by Joseph DeWeese on 12/28/24.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        ZStack{
            Image(systemName: "memorychip")
                .resizable()
                .frame(width: 45, height: 45)
                .foregroundColor(.blue).opacity(0.3)
            HStack {
                Text("Mind")
                    .font(.callout)
                    .fontDesign(.serif)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .offset(x: 13, y: 1)
                Text("Map")
                    .font(.callout)
                    .fontDesign(.serif)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .offset(x: 5, y: 1)
              
                Text("1.0")
                    .font(.caption)
                    .fontDesign(.serif)
                    .fontWeight(.regular)
                    .padding(.leading, 10)
                    .foregroundColor(.blue)
                    .offset(x: -15, y: -2)
            }.offset(x: 5)
        }
    }
}
#Preview {
    LogoView()
}
