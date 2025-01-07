//
//  ItemCardView.swift
//  BrainSys
//
//  Created by Joseph DeWeese on 12/25/24.
//

import SwiftUI
import SwiftData




struct ItemCardView: View {
    @Environment(\.modelContext) private var context
    let item: Item
    
    
    
    var body: some View {
        NavigationStack{
            SwipeAction(cornerRadius: 10, direction: .trailing) {
                ZStack {
                    RoundedRectangle(cornerRadius: 7)
                        .fill(.ultraThinMaterial.opacity(.greatestFiniteMagnitude))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    VStack(alignment: .leading){
                        HStack{
                            ZStack {
                                RoundedRectangle(cornerRadius: 7)
                                    .fill(.ultraThinMaterial)
                                    .frame(height: 30)
                                Text(item.category)
                                    .padding(3)
                                    .padding(.horizontal,2)
                                    .foregroundStyle(.white)
                                    .background(.blue.gradient, in: .rect(cornerRadius: 7))
                                    .contentShape(.rect)
                                    .fontDesign(.serif)
                                    .padding(.horizontal, 30)
                            }
                        }
                        HStack(spacing: 12) {
                            Text("\(String(item.title.prefix(1)))")
                                .font(.title)
                                .fontDesign(.serif)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .shadow(color: .black, radius: 1, x: 1, y: 1)
                                .frame(width: 45, height: 45)
                                .background(item.color.gradient, in: .circle)
                                .padding(.leading, 12)
                                .padding(.bottom, 12)
                            //MARK:  MAIN BODY OF CARD
                            HStack{
                                //MARK:  ICON
                                VStack(alignment: .leading){
                                    Text(item.title )
                                        .fontDesign(.serif)
                                        .font(.system(size: 20))
                                        .fontWeight(.bold)
                                        .foregroundStyle(.primary)
                                        .padding(.horizontal, 2)
                                        .padding(.bottom, 4.0)
                                    if !item.remarks.isEmpty {
                                        Text(item.remarks)
                                            .fontDesign(.serif)
                                            .font(.system(size: 16))
                                            .foregroundStyle(.blue)
                                            .padding(.horizontal, 4)
                                            .padding(.bottom, 7)
                                            .lineLimit(3)
                                    }
                                    HStack {
                                        //MARK:  DATE CREATED DATA LINE
                                        Text("Date Created: ")
                                            .foregroundStyle(.gray)
                                            .fontDesign(.serif)
                                            .font(.system(size: 14))
                                        Image(systemName: "calendar.badge.clock")
                                            .font(.footnote)
                                            .fontDesign(.serif)
                                            .foregroundStyle(.gray)
                                            .font(.system(size: 14))
                                        Text(item.dateAdded.formatted(.dateTime))
                                            .fontDesign(.serif)
                                            .foregroundColor(.secondary)
                                            .font(.system(size: 14))
                                    }.padding(.top, 5)
                                        .padding(.bottom, 3)
                                    
                                    if let tags = item.tags {
                                        ViewThatFits {
                                            TagsStackView(tags: tags)
                                            ScrollView(.horizontal, showsIndicators: false) {
                                                TagsStackView(tags: tags)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            } actions: {
                Action(tint: .red, icon: "trash", action: {
                    context.delete(item)
                    //WidgetCentrer.shared.reloadAllTimneLines
                })
            }
        }
    }
}
