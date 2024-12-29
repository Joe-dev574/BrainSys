//
//  DashControlView.swift
//  BrainSys
//
//  Created by Joseph DeWeese on 12/29/24.
//

import SwiftUI

struct DashControlView: View {
            let item: Item
        /// Env Properties
        @Environment(\.modelContext) private var context
        @Environment(\.dismiss) private var dismiss
        @State private var status: Status = .Active
        @State private var showTags: Bool = false
        
        var body: some View {
            VStack {
                //MARK:  STATUS PICKER
                Text("Dash Controls")
                    .foregroundStyle(.gray)
                
                HStack {
                    Picker("Status", selection: $status) {
                        ForEach(Status.allCases) { status in
                            Text(status.descr).tag(status) .fontDesign(.serif)
                        }
                    }.background(.thinMaterial.shadow(.drop(color: .black.opacity(0.95), radius: 4)), in: .rect(cornerRadius: 10))
                        .pickerStyle(.menu)
                        .buttonStyle(.bordered)
                    //MARK:  TARGETS / TAGS
                    Button("Scope", systemImage: "scope") {
                        showTags.toggle()
                    }
                    .background(.thinMaterial.shadow(.drop(color: .black.opacity(0.95), radius: 4)), in: .rect(cornerRadius: 10))
                    .sheet(isPresented: $showTags) {
                        TagView()
                    }
                    //MARK:  UPDATE BUTTON
                    NavigationLink {
                    //   NotesListView()
                    } label: {
                        let count = item.notes?.count ?? 0
                        Label("\(count) Notes", systemImage: "square.and.pencil").fontDesign(.serif)
                    }.foregroundStyle(.gray)
                   
                    .background(.thinMaterial.shadow(.drop(color: .black.opacity(0.95), radius: 4)), in: .rect(cornerRadius: 10))
                    
                }.background(.thinMaterial.shadow(.drop(color: .black.opacity(0.55), radius: 4)), in: .rect(cornerRadius: 10))
                    .buttonStyle(.bordered)
                    .padding(.horizontal, 3)
            }.padding(.top, 15)
                .font(.system(size: 16))
                .fontDesign(.serif)
                .foregroundStyle(.gray)
        }
  
}

    
