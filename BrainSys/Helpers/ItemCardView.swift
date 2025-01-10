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
                        HStack(spacing: 12){
                            ZStack {
                                ///category tag
                                Text(item.category)
                                    .padding(3)
                                    .foregroundStyle(.white)
                                    .background(item.color.gradient, in: .rect(cornerRadius: 7))
                                    .contentShape(.rect)
                                    .fontDesign(.serif)
                                
                            }
                        }
                            //MARK:  MAIN BODY OF CARD
                            //MARK:  ICON
                            HStack{
                                Text("\(String(item.title.prefix(1)))")
                                    .font(.title)
                                    .fontDesign(.serif)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.white)
                                    .shadow(color: .black, radius: 2, x: 1, y: 1)
                                    .frame(width: 35, height: 35)
                                    .background(item.color.gradient, in: .circle)
                                    .padding(5)
                                Text(item.title)
                                    .font(.system(size: 20))
                                    .fontDesign(.serif)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.primary)
                                
                            }
                            VStack(alignment: .center){
                                HStack{
                                    Spacer( )
                                    
                                    if !item.remarks.isEmpty {
                                        Text(item.remarks)
                                            .fontDesign(.serif)
                                            .font(.system(size: 16))
                                            .foregroundStyle(.blue)
                                            .padding(.horizontal, 4)
                                            .lineLimit(3)
                                    }
                                    Spacer( )
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
                            .padding(.horizontal, 10)
                        }
                
                }.padding( 2)
            } actions: {
                Action(tint: .red, icon: "trash", action: {
                    context.delete(item)
                    //WidgetCentrer.shared.reloadAllTimneLines
                })
            }
        }
    }
}
