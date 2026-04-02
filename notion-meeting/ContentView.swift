//
//  ContentView.swift
//  notion-note
//
//  Created by Alan Jian on 4/1/26.
//

import SwiftUI
import PencilKit

struct ContentView: View {
    
    @State private var notes: [MeetingNote] = MeetingNote.mockData
    
    var body: some View {
        NavigationStack {
            List(notes) { note in
                            NavigationLink(value: note) {
                                MeetingNoteRow(note: note)
                        }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
    }
    
    private func addItem() {
        /*
        withAnimation {
            let newItem = Item(timestamp: Date())
            modelContext.insert(newItem)
        }
        */
    }

    private func deleteItems(offsets: IndexSet) {
        /*
        withAnimation {
            for index in offsets {
                modelContext.delete(notes[index])
            }
        }
        */
    }
}
     
fileprivate struct NavigationViewWrapper<Content: View>: View {
    let content: () -> Content

    var body: some View {
        content()
    }
}

#Preview {
    ContentView()
}
