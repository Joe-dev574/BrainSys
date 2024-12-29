//
//  StatsView.swift
//  BrainSys
//
//  Created by Joseph DeWeese on 12/28/24.
//

import SwiftUI

struct StatsView: View {
    let icon: String
    let title: String
    let count: Int
           
    var body: some View {
            GroupBox {
                HStack {
                    VStack(spacing: 10) {
                        Image(systemName: icon)
                        Text(title)
                            .fontDesign(.serif)
                    }
                    Spacer()
                    Text("\(count)")
                        .font(.largeTitle)
                        .fontDesign(.serif)
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
#Preview {
    StatsView(icon: "Calendar", title: "Notes", count: 17)
}
