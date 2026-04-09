//
//  PKCanvasViewRepresentable.swift
//  notion-meeting
//
//  Created by Alan Jian on 4/6/26.
//

import SwiftUI
import PencilKit

struct PKCanvasViewRepresentable: UIViewRepresentable {
    @Binding var drawing: PKDrawing
    @Binding var canvasView: PKCanvasView
    let toolPicker: PKToolPicker
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.drawing = drawing
        canvasView.alwaysBounceVertical = true
        canvasView.drawingPolicy = .anyInput
        canvasView.delegate = context.coordinator
        return canvasView
    }
    
    func updateUIView(_ canvasView: PKCanvasView, context: Context) {
        if canvasView.drawing != drawing {
            canvasView.drawing = drawing
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(drawing: $drawing)
    }
    
    class Coordinator: NSObject, PKCanvasViewDelegate {
        var drawing: Binding<PKDrawing>
        
        init(drawing: Binding<PKDrawing>) {
            self.drawing = drawing
        }
        
        func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
            drawing.wrappedValue = canvasView.drawing
        }
    }
}
