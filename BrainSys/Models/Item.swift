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
    var dateStarted: Date = Date.distantPast
    var dateCompleted: Date = Date.distantPast
    var category: String
    var status: Status.RawValue = Status.Hold.rawValue
    var tintColor: String
    @Relationship(deleteRule: .cascade)
    var notes: [Note]?
    @Relationship(inverse: \Tag.items)
    var tags: [Tag]?
    
    init(
        title: String = "",
        remarks: String = "",
        dateAdded: Date = Date.now,
        category: Category,
        tintColor: TintColor,
        status: Status = .Hold,
        tags: [Tag]? = nil
    ) {
        self.title = title
        self.remarks = remarks
        self.dateAdded = dateAdded
        self.category = category.rawValue
        self.tintColor = tintColor.color
        self.status = status.rawValue
        self.tags = tags
    }
    var icon: Image {
        switch Status(rawValue: status)! {
        case .Hold:
            Image(systemName: "checkmark.diamond.fill")
        case .Active:
            Image(systemName: "item.fill")
        case .Completed:
            Image(systemName: "books.vertical.fill")
        }
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
    enum Status: Int, Codable, Identifiable, CaseIterable {
        case Hold, Active, Completed
        var id: Self {
            self
        }
        var descr: LocalizedStringResource {
            switch self {
            case .Hold:
                "On Shelf"
            case .Active:
                "Active"
            case .Completed:
                "Completed"
            }
        }
    }

