//
//  ContentView.swift
//  notion-note
//
//  Created by Alan Jian on 4/1/26.
//

import SwiftUI
import PencilKit

struct ContentView: View {
    @EnvironmentObject var dataModelController: DataModelController
    
    var body: some View {
        NavigationStack {
            List(dataModelController.notesList) { note in
                NavigationLink(value: note) {
                    MeetingNoteRow(note: note)
                }
            }
            .navigationTitle("Meeting Notes")
            .navigationDestination(for: MeetingNote.self) { note in
                if let index = notes.firstIndex(of: note) {
                    CanvasView(note: $notes[index])
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addNote) {
                        Label("Add Note", systemImage: "plus")
                    }
                }
            }
        }
    }
    
    private func addNote() {
        withAnimation {
            notes.append(MeetingNote(
                title: "New Meeting",
                date: Date(),
                projectName: nil
            ))
        }
    }
    
    private func deleteNotes(offsets: IndexSet) {
        withAnimation {
            notes.remove(atOffsets: offsets)
        }
    }
}

#Preview {
    ContentView()
}
