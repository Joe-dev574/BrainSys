//
//  GenreStackView.swift
//  BrainSys
//
//  Created by Joseph DeWeese on 12/29/24.
//

import SwiftUI

struct TagsStackView: View {
    var tags: [Tag]
    var body: some View {
        HStack {
            ForEach(tags.sorted(using: KeyPathComparator(\Tag.name))) { tag in
                Image(systemName: "tag")
                    .tint(tag.hexColor)
                    .offset(x: 7)
                Text(tag.name)
                    .fontDesign(.serif)
                    .font(.caption)
                    .foregroundStyle(.primary)
                    .background(RoundedRectangle(cornerRadius: 5).fill(tag.hexColor))
            }
        }.padding(4)
    }
}
#Preview {
    TagsStackView(tags: [])
}
