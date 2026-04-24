//
//  CanvasView.swift
//  notion-meeting
//
//  Created by Alan Jian on 4/6/26.
//

import SwiftUI
import PencilKit

struct CanvasView: View {
    let noteID: String
    @EnvironmentObject var dataModelController: DataModelController
    @State private var canvasView = PKCanvasView()
    @State private var toolPicker = PKToolPicker()
    
    var body: some View {
        if let note = dataModelController.notes[noteID] {
            PKCanvasViewRepresentable(
                drawing: .constant(note.drawing),
                canvasView: $canvasView,
                toolPicker: toolPicker
            )
            .navigationTitle(note.title)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                showToolPicker()
            }
            .onDisappear {
                dataModelController.updateNote(id: noteID, drawing: note.drawing)
                hideToolPicker()
            }
        }
    }
    
    private func showToolPicker() {
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        canvasView.becomeFirstResponder()
    }
    
    private func hideToolPicker() {
        toolPicker.setVisible(false, forFirstResponder: canvasView)
        toolPicker.removeObserver(canvasView)
    }
}
