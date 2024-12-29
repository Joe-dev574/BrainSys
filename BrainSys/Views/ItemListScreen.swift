//
//  ItemListScreen.swift
//  BrainSys
//
//  Created by Joseph DeWeese on 12/22/24.
//

import SwiftUI
import SwiftData





struct ItemListScreen: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var showAddItemSheet: Bool = false
    @State private var selectedCategory: Category = .Note
    @State private var selectedItem: Item?
    @State private var startDate: Date = .now.startOfMonth
    @State private var endDate: Date = .now.endOfMonth
    @State private var filter = ""
    @Namespace private var animation
    var body: some View {
        GeometryReader{
            /// For Animation Purpose
            let size = $0.size
            NavigationStack {
                LogoView(_size: size)
                CustomSegmentedControl()
                    .fontDesign(.serif)
                    .padding(.horizontal, 10)
                ScrollView {
                    LazyVStack(spacing: 10, pinnedViews: [.sectionHeaders]) {
                        CategoryFilterView(startDate: startDate, endDate:endDate, category: selectedCategory) { items in
                            ForEach(items) { item in
                                ItemCardView( item: item)
                                    .onTapGesture {
                                        selectedItem = item
                                    }
                            }
                        }
                        .animation(.smooth, value: selectedCategory)
                    }
                }
            
                .navigationDestination(item: $selectedItem) { item in
                    ItemTaskView()
                }
            }
        }    .blur(radius: showAddItemSheet ? 8 : 0)
    }
    @ViewBuilder
    func LogoView( _size: CGSize) -> some View {
        HStack {
            Button{
                print("profile")
                HapticManager.notification(type: .success)
            } label: {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 45, height: 40)
                    .foregroundColor(.blue).opacity(0.6)
            }
            Spacer()
            ZStack{
                Image(systemName: "memorychip")
                    .resizable()
                    .frame(width: 45, height: 45)
                    .foregroundColor(.blue).opacity(0.3)
                HStack {
                    Text("Brain")
                        .font(.callout)
                        .fontDesign(.serif)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .offset(x: 13, y: 1)
                    Text("System")
                        .font(.callout)
                        .fontDesign(.serif)
                        .fontWeight(.heavy)
                        .foregroundStyle(.primary)
                        .offset(x: 5, y: 1)
                    Text("Management")
                        .font(.callout)
                        .fontDesign(.serif)
                        .fontWeight(.heavy)
                        .foregroundStyle(.primary)
                        .offset(x: -3, y: 1)
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
            Button{
                showAddItemSheet = true
                HapticManager.notification(type: .success)
            } label: {
                Image(systemName: "plus")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 45, height: 45)
                    .background(.blue.gradient, in: .circle)
                    .contentShape(.circle)
            }
            .sheet(isPresented: $showAddItemSheet) {
                AddItemView()
                    .presentationDetents([.medium])
            }
        }
        .padding(.horizontal,7)
        .background {
            VStack(spacing: 0) {
                Rectangle()
                    .fill(.background)
            }
            .visualEffect { content, geometryProxy in
                content
                //  .opacity(headerBGOpacity(geometryProxy))
            }
            .padding(.horizontal, -15)
            .padding(.top, 15)
        }
    }
        /// Segmented Control
        @ViewBuilder
        func CustomSegmentedControl() -> some View {
            HStack(spacing: 0) {
                ForEach(Category.allCases, id: \.rawValue) { category in
                    Text(category.rawValue)
                        .hSpacing()
                        .padding(.vertical, 10)
                        .background {
                            if category == selectedCategory {
                                Capsule()
                                    .fill(Color("LightGrey"))
                                    .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                            }
                        }
                        .contentShape(.capsule)
                        .onTapGesture {
                            withAnimation(.snappy) {
                                selectedCategory = category
                            }
                        }
                }
            }
            .background(.gray.opacity(0.69), in: .capsule)
            .padding(.top, 5)
            .padding(.bottom, 5)
        }
        
        func headerBGOpacity(_ proxy: GeometryProxy) -> CGFloat {
            let minY = proxy.frame(in: .scrollView).minY + safeArea.top
            return minY > 0 ? 0 : (-minY / 15)
        }
        
        func headerScale(_ size: CGSize, proxy: GeometryProxy) -> CGFloat {
            let minY = proxy.frame(in: .scrollView).minY
            let screenHeight = size.height
            
            let progress = minY / screenHeight
            let scale = (min(max(progress, 0), 1)) * 0.4
            
            return 1 + scale
        }
    }


#Preview {
    ItemListScreen()
        .modelContainer(for: Item.self, inMemory: true)
}
