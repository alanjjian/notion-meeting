//
//  DataModelController.swift
//  notion-meeting
//
//  Created by Alan Jian on 4/8/26.
//

import Foundation
import Combine

class DataModelController: ObservableObject {
    @Published var notes: [String : MeetingNote] = [String : MeetingNote]()
    @Published var notesList: [MeetingNote] = []
    
    init() {
    }
    
    func addNote(_ note: MeetingNote) {
        self.notes[note.id] = note
        self.sortNotesList()
    }
    
    func deleteNote(_ note: MeetingNote) {
        self.notes.removeValue(forKey: note.id)
        self.sortNotesList()
    }
    
    func sortNotesList() {
        // Sort list of notes based on date
        self.notesList = self.notes.values.sorted(by: { $0.date < $1.date })
    }
    
}
