//
//  CategoryCheckBox.swift
//  BrainSys
//
//  Created by Joseph DeWeese on 12/29/24.
//

import SwiftUI
import SwiftData




struct CategoryCheckBox: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @State private var category: Category = .Wiki
   
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(Category.allCases, id: \.rawValue) { category in
                HStack(spacing: 5) {
                    ZStack {
                        Image(systemName: "circle")
                            .font(.title3)
                            .foregroundStyle(.blue)
                        
                        if self.category == category {
                            Image(systemName: "circle.fill")
                                .font(.caption)
                                .foregroundStyle(.orange)
                        }
                    }
                    Text(category.rawValue)
                        .font(.caption)
                        .fontDesign(.serif)
                }
                .contentShape(.rect)
                .onTapGesture {
                    self.category = category
                }
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 12)
        //        .hSpacing(.center)
        .background(.gray.opacity(0.2), in: .rect(cornerRadius: 10))
    }
    
    /// Number Formatter
    var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
}
#Preview {
    CategoryCheckBox()
}
