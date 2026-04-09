//
//  CanvasView.swift
//  notion-meeting
//
//  Created by Alan Jian on 4/6/26.
//

import SwiftUI
import PencilKit

struct CanvasView: View {
    @Binding var note: MeetingNote
    @State private var canvasView = PKCanvasView()
    @State private var toolPicker = PKToolPicker()
    
    var body: some View {
        PKCanvasViewRepresentable(
            drawing: $note.drawing,
            canvasView: $canvasView,
            toolPicker: toolPicker
        )
        .navigationTitle(note.title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            showToolPicker()
        }
        .onDisappear {
            hideToolPicker()
            
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
