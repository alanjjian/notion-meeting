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
    @State private var isRenaming = false
    @State private var noteToRename: MeetingNote? = nil
    @State private var newTitle = ""
    
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
                            MeetingNoteRow(noteID: note.id)
                        }
                        .swipeActions(edge: .leading) {
                                Button {
                                    noteToRename = note
                                    newTitle = note.title
                                    isRenaming = true
                                } label: {
                                    Label("Rename", systemImage: "pencil")
                                }
                                .tint(.blue)
                        }
                    }
                    .onDelete(perform: deleteNotes)
                }
            }
            .navigationTitle("Meeting Notes")
            .navigationDestination(for: String.self) { id in
                if let _ = dataModelController.getNote(id) {
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
            .alert("Rename Note", isPresented: $isRenaming, presenting: noteToRename) { note in
                TextField("Note title", text: $newTitle)
                Button("Save") {
                    dataModelController.renameNote(id: note.id, title: newTitle)
                }
                Button("Cancel", role: .cancel) { }
            } message: { note in
                Text("Enter a new name for \"\(note.title)\"")
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
