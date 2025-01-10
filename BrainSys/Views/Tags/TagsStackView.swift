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
                Image(systemName: "tag.fill")
                    .foregroundStyle(tag.hexColor)
                    .offset(x: 7)
                Text(tag.name)
                    .fontDesign(.serif)
                    .font(.caption)
                    .foregroundStyle(.primary)
                 
            }
        }.padding(4)
    }
}
#Preview {
    TagsStackView(tags: [])
}
