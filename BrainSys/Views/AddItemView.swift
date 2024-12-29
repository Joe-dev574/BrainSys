//
//  AddItemView.swift
//  BrainSys
//
//  Created by Joseph DeWeese on 12/25/24.
//

import SwiftUI

import SwiftUI
import SwiftData

struct AddItemView: View {
    //MARK:  PROPERTIES
    /// Env Properties
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    var editItem: Item?
    /// View Properties
    @State private var title: String = ""
    @State private var remarks: String = ""
    @State private var dateAdded: Date = .now
    @State private var category: Category = .Idea
    /// Random Tint
    @State var tint: TintColor = tints.randomElement()!
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(spacing: 15) {
                    //                    Text("Preview")
                    //                        .font(.caption)
                    //                        .foregroundStyle(.gray)
                    //                        .hSpacing(.leading)
                    //                    ItemCardView(item: .init(
                    //                        title: title.isEmpty ? "Title" : title,
                    //                        remarks: remarks.isEmpty ? "Remarks" : remarks,
                    //                        dateAdded: dateAdded,
                    //                        category: category.rawValue))
                    //                    .padding(.horizontal, 7)
                    
                    Text("Category")
                        .font(.callout)
                        .fontDesign(.serif)
                        .foregroundStyle(.gray)
                        
                  CategoryCheckBox()
                        .padding(.horizontal, 7)
                        .padding(10)
                    CustomSection("Title", "Enter a title for your Objective", value: $title)
                    
                    CustomSection("Brief Description", "Briefly describe your objective", value: $remarks)
                }
            }
            .padding(.horizontal, 7)
            .fontDesign(.serif)
            .background(.background)
           
            .toolbar{
                ToolbarItem(placement: .topBarLeading, content: {
                    Button {
                        HapticManager.notification(type: .success)
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .fontDesign(.serif)
                    }
                    .buttonStyle(.automatic)
                })
                ToolbarItem(placement: .principal, content: {
                    LogoView()
                })
                ToolbarItem(placement:.topBarTrailing, content: {
                    Button {
                        /// Saving Task
                        save()
                        HapticManager.notification(type: .success)
                        dismiss()
                    } label: {
                        Text("Save")
                            .fontDesign(.serif)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(title.isEmpty || remarks.isEmpty)
                    .padding(.horizontal, 2)
                })
            }
        }
    }
    
    //MARK: - Private Methods -
    private func save() {
        /// Saving Task
        let item = Item(title: title, remarks: remarks,category: category, tintColor: tint)
        do {
            context.insert(item)
            try context.save()
            /// After Successful Task Creation, Dismissing the View
            dismiss()
        } catch {
            print(error.localizedDescription)
        }
        HapticManager.notification(type: .success)
        dismiss()
    }
   
    @ViewBuilder
    func CustomSection(_ title: String, _ hint: String, value: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 10, content: {
            Text(title)
                .font(.callout)
                .fontDesign(.serif)
                .foregroundStyle(.gray)
              
            
            TextField(hint, text: value)
                .padding(.horizontal, 15)
                .padding(.vertical, 12)
                .background(.gray.opacity(0.10), in: .rect(cornerRadius: 10))
        }).padding(.horizontal, 7)
    }
    @ViewBuilder
    func LogoView() -> some View {
        VStack(alignment: .leading, spacing: 6){
            HStack {
                Spacer()
                ZStack{
                    
                    Image(systemName: "scope")
                        .resizable()
                        .frame(width: 45, height: 45)
                        .foregroundColor(.blue).opacity(0.3)
                    HStack {
                        Text("Brain")
                            .font(.callout)
                            .fontDesign(.serif)
                            .fontWeight(.bold)
                        
                            .foregroundColor(.blue)
                            .offset(x: 13, y: 7)
                        Text("Scope")
                            .font(.callout)
                            .fontDesign(.serif)
                            .fontWeight(.heavy)
                            .foregroundStyle(.primary)
                            .offset(x: 5, y: 7)
                        Text("1.0")
                            .font(.caption)
                            .fontDesign(.serif)
                            .fontWeight(.regular)
                            .padding(.leading, 10)
                            .foregroundColor(.blue)
                            .offset(x: -15, y: -2)
                    }.offset(x: 5)
                    
                }
                Spacer()
            }
            }
        }

    /// Custom CheckBox
    @ViewBuilder
    func CategoryCheckBox() -> some View {
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
    AddItemView()
}
