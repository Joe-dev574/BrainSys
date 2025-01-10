//
//  ItemEditView.swift
//  BrainSys
//
//  Created by Joseph DeWeese on 12/29/24.
//

import SwiftUI
import PhotosUI
import SwiftData



struct ItemEditView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    let item: Item
    @State private var status = Status.Hold
    
    @State private var showImagePicker = false
    @State private var showImageEditor = false
    @State private var title = ""
    @State private var itemColor = Color.accentColor
    @State private var remarks = ""
    @State private var dateAdded: Date = .init()
    @State private var dateStarted: Date = .init()
    @State private var dateCompleted: Date = .init()
    var editItem: Item?
    /// View Properties
    @State private var category: Category = .Objectives
    
    @State private var showTags = false
    init(item: Item) {
        self.item = item
        _status = State(initialValue: Status(rawValue: item.status)!)
    }
    var body: some View {
        NavigationStack{
            VStack{
                ScrollView {
                    DashControlView(item: item, status: $status)
                        .font(.system(size: 14))
                        .fontDesign(.serif)
                        .foregroundStyle(.gray)
                        .padding(.bottom, 10)
                    Text("Category:")
                        .font(.system(size: 16))
                        .fontDesign(.serif)
                        .foregroundStyle(.gray)
                        .padding(.bottom, 3)
                    CategoryCheckBox(category: $category)
                    VStack(alignment: .center, spacing: 7){
                        ///title
                        Text("Item Title")
                            .font(.system(size: 16))
                            .fontDesign(.serif)
                            .foregroundStyle(.gray)
                        TextField("Item Title", text:$title)
                            .font(.system(size: 16))
                            .fontDesign(.serif)
                            .padding()
                            .foregroundStyle(.primary)
                            .background(Color.gray.opacity(0.1))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 1))
                            .padding(.bottom, 10)
                        ///description
                        Text("Brief Description")
                            .font(.system(size: 16))
                            .fontDesign(.serif)
                            .foregroundStyle(.gray)
                        ZStack(alignment: .topLeading) {
                            if remarks.isEmpty {
                                Text("Brief Description...")
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(3)
                                    .foregroundStyle(.primary)
                            }
                            TextEditor(text: $remarks)
                                .scrollContentBackground(.hidden)
                                .background(Color.gray.opacity(0.1))
                                .font(.system(size: 16))
                                .fontDesign(.serif)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                        }
                        if let tags = item.tags {
                            ViewThatFits {
                                TagsStackView(tags: tags)
                                ScrollView(.horizontal, showsIndicators: false) {
                                    TagsStackView(tags: tags)
                                }
                            }
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(uiColor: .tertiarySystemFill), lineWidth: 2))
                        }
                    }
                    .padding()
                    
                    Divider()
                }
                .toolbar{
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        
                        if changed {
                            Button{
                                HapticManager.notification(type: .success)
                                item.status = status.rawValue
                                item.title = title
                                item.category = category.rawValue
                                item.remarks = remarks
                                item.dateAdded = dateAdded
                                item.dateStarted = dateStarted
                                item.dateCompleted = dateCompleted
                                dismiss()
                            }  label: {
                                ZStack{
                                    Text("Update")
                                        .font(.title3)
                                        .foregroundStyle(.white)
                                }
                            }
                            .buttonStyle(.borderedProminent)
                        }
                    }
                }
                .padding(.top, 15)
                .onAppear {
                    title = item.title
                    remarks = item.remarks
                    dateAdded = item.dateAdded
                    dateStarted = item.dateStarted
                    dateCompleted = item.dateCompleted
                    status = Status(rawValue: item.status)!
                    category = Category(rawValue: item.category)!
                    
                }
            }
            var changed: Bool {
                status != Status(rawValue: item.status)!
                || title != item.title
                || remarks != item.remarks
                || category != Category(rawValue: item.category)!
                || dateAdded != item.dateAdded
                || dateStarted != item.dateStarted
                || dateCompleted != item.dateCompleted
                
            }
        }
        
    }
}
