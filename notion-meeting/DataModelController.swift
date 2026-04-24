//
//  DataModelController.swift
//  notion-meeting
//
//  Created by Alan Jian on 4/8/26.
//

import Foundation
import Combine
import PencilKit

class DataModelController: ObservableObject {
    @Published var notes: [String : MeetingNote] = [String : MeetingNote]()
    
    var notesList: [MeetingNote] {
            notes.values.sorted(by: { $0.date > $1.date })
        }
    
    init() {
    }
    
    func addNote(_ note: MeetingNote) {
        self.notes[note.id] = note
    }
    
    func deleteNote(_ note: MeetingNote) {
        self.notes.removeValue(forKey: note.id)
    }
    
    func updateNote(id: String, drawing: PKDrawing) {
        notes[id]?.drawing = drawing
    }
    
}
