//
//  Meeting.swift
//  notion-meeting
//
//  Created by Alan Jian on 4/1/26.
//

import Foundation
import PencilKit

struct MeetingNote: Identifiable, Hashable {
    let id: String // Notion page ID
    var title: String
    var date: Date
    var projectName: String? // just a string, Notion owns the relation
    var drawing: PKDrawing
    var thumbnail: UIImage?
    
    static func == (lhs: MeetingNote, rhs: MeetingNote) -> Bool {
            lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
    }
    
    init(id: String = UUID().uuidString, title: String, date: Date = Date(), projectName: String? = nil, drawing: PKDrawing = PKDrawing(), thumbnail: UIImage? = nil) {
            self.id = id
            self.title = title
            self.date = date
            self.projectName = projectName
            self.drawing = drawing
            self.thumbnail = thumbnail
    }
    
    static let mockData: [MeetingNote] = [
            MeetingNote(title: "Q1 Planning", date: Date(), projectName: "Strategy"),
            MeetingNote(title: "Design Review", date: Date().addingTimeInterval(-86400), projectName: "Product"),
            MeetingNote(title: "Quick Sync", date: Date().addingTimeInterval(-172800), projectName: nil),
    ]
    
}
