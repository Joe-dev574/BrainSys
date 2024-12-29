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
    @State private var category: Category = .Objective
    
    @State private var showTags = false
    init(item: Item) {
        self.item = item
        _status = State(initialValue: Status(rawValue: item.status)!)
    }
    var body: some View {
        NavigationStack{
                VStack{
                    ScrollView {
                        DashControlView(item: item)
                            .font(.system(size: 14))
                            .fontDesign(.serif)
                            .foregroundStyle(.gray)
                            .padding(.bottom, 10)
                        Text("Category:")
                            .font(.system(size: 16))
                            .fontDesign(.serif)
                            .foregroundStyle(.gray)
                            .padding(.bottom, 4)
                        CategoryCheckBox()
                        VStack(alignment: .center, spacing: 7){
                            ///title
                            Text("Item Title")
                                .font(.system(size: 16))
                                .fontDesign(.serif)
                                .foregroundStyle(.gray)
                            TextField("Item Title", text:$title)
                                .font(.title3)
                                .fontDesign(.serif)
                                .padding()
                                .foregroundStyle(.primary)
                                .background(.thinMaterial.shadow(.drop(color: .black.opacity(0.65), radius: 3)), in: .rect(cornerRadius: 10))
                                .padding(.horizontal)
                                .padding(.bottom, 10)
                            ///description
                            Text("Brief Description")
                                .font(.system(size: 16))
                                .fontDesign(.serif)
                                .foregroundStyle(.gray)
                            TextEditor(text: $remarks)
                                .background(.ultraThinMaterial.shadow(.drop(color: .black.opacity(0.65), radius: 3)), in: RoundedRectangle(cornerRadius: 4))
                                .multilineTextAlignment(.leading)
                                .lineLimit(3)
                                .foregroundStyle(.primary)
                                .frame(minWidth: 300, maxWidth: .infinity, minHeight: 65, maxHeight: .infinity, alignment: .leading)
                    
                            /// Giving Some Space for tapping
                             
                         
                                
                            //MARK:  CUSTOM COLOR PICKER (OBJECTIVE COLOR)
                            
                            if item.tags != nil {
                                ViewThatFits {
                                    //         TargetTagsStackView(targetTags: targetTags)
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        //            TargetTagsStackView(targetTags: targetTags)
                                    }
                                }
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(uiColor: .tertiarySystemFill), lineWidth: 2))
                            }
                        }
                        .padding()
                        .navigationBarTitle(item.title)
                        .navigationBarTitleDisplayMode(.inline)
                    }
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
                                RoundedRectangle(cornerRadius: 10).stroke(style: StrokeStyle(lineWidth: 1))
                                
                                Text("Update Objective")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                            }
                        }
                        .frame(width: 300, height: 55)
                        .buttonStyle(.borderedProminent)
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
                || status != Status(rawValue: item.status)!
                || dateAdded != item.dateAdded
                || dateStarted != item.dateStarted
                || dateCompleted != item.dateCompleted
                
            }
        }
    
    }
