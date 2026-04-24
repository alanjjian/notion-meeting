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
            List {
                if dataModelController.notesList.isEmpty {
                    ContentUnavailableView(
                        "No Meeting Notes",
                        systemImage: "note.text",
                        description: Text("Tap + to create your first meeting note")
                    )
                } else {
                    ForEach(dataModelController.notesList) { note in
                        NavigationLink(value: note.id) {
                            MeetingNoteRow(note: note)
                        }
                    }
                    .onDelete(perform: deleteNotes)
                }
            }
            .navigationTitle("Meeting Notes")
            .navigationDestination(for: String.self) { id in
                if let note = dataModelController.notes[id] {
                    CanvasView(noteID: id)
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
            dataModelController.addNote(MeetingNote(
                title: "New Meeting",
                date: Date(),
                projectName: nil
            ))
        }
    }
    
    private func deleteNotes(offsets: IndexSet) {
        withAnimation {
            offsets.map { dataModelController.notesList[$0] }
                           .forEach { dataModelController.deleteNote($0) }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(DataModelController())
}
