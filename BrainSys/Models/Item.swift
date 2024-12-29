//
//  Item.swift
//  BrainSys
//
//  Created by Joseph DeWeese on 12/22/24.
//

import SwiftUI
import SwiftData

@Model
final class Item {
    /// Properties
    var title: String
    var remarks: String
    var dateAdded: Date
    var category: String
    var tintColor: String
    
    init(
        title: String = "",
        remarks: String = "",
        dateAdded: Date = Date.now,
        category: Category,
        tintColor: TintColor
    ) {
        self.title = title
        self.remarks = remarks
        self.dateAdded = dateAdded
        self.category = category.rawValue
        self.tintColor = tintColor.color
    }
    
    /// Extracting Color Value from tintColor String
    @Transient
    var color: Color {
        return tints.first(where: { $0.color == tintColor })?.value ?? Constants.shared.tintColor
    }
    @Transient
    var tint: TintColor? {
        return tints.first(where: { $0.color == tintColor })
    }
    @Transient
    var rawCategory: Category? {
        return Category.allCases.first(where: { category == $0.rawValue })
    }
    }

