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
    @State private var drawing = PKDrawing()
    @Environment(\.displayScale) var displayScale
    
    var body: some View {
        if let note = dataModelController.getNote(noteID) {
            PKCanvasViewRepresentable(
                drawing: $drawing,
                canvasView: $canvasView,
                toolPicker: toolPicker
            )
            .onChange(of: dataModelController.getNote(noteID)?.title) {
                canvasView.becomeFirstResponder()
            }
            .navigationTitle(dataModelController.getTitleBinding(for: noteID))
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                drawing = note.drawing
                showToolPicker()
            }
            .onDisappear {
                dataModelController.updateNote(
                    id: noteID,
                    drawing: drawing,
                    displayScale: displayScale)
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
