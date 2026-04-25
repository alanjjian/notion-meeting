//
//  DataModelController.swift
//  notion-meeting
//
//  Created by Alan Jian on 4/8/26.
//

import SwiftUI
import Foundation
import Combine
import PencilKit

class DataModelController: ObservableObject {
    @Published var notes: [String : MeetingNote] = [String : MeetingNote]()
    
    private let thumbnailQueue = DispatchQueue(label: "ThumbnailQueue", qos: .background) // To not gunk up main queue with laggy process
    static let thumbnailSize = CGSize(width: 192, height: 256)
    static let canvasWidth: CGFloat = 768
    
    var notesList: [MeetingNote] {
            notes.values.sorted(by: { $0.date > $1.date })
        }
    
    init() {
    }
    
    func getTitleBinding(for id: String) -> Binding<String> {
        Binding(
            get: { self.notes[id]?.title ?? "" },
            set: { self.notes[id]?.title = $0 }
        )
    }
    
    func getNote(_ id: String) -> MeetingNote? {
        return self.notes[id]
    }
    
    func addNote(_ note: MeetingNote) {
        self.notes[note.id] = note
    }
    
    func deleteNote(_ note: MeetingNote) {
        self.notes.removeValue(forKey: note.id)
    }
    
    func renameNote(id: String, title: String) {
        notes[id]?.title = title
    }
    
    func updateNote(id: String, drawing: PKDrawing, displayScale: CGFloat) {
        notes[id]?.drawing = drawing
        generateThumbnail(for: id, drawing: drawing, displayScale: displayScale)
    }
    
    private func generateThumbnail(for id: String, drawing: PKDrawing, displayScale: CGFloat) {
        let size = DataModelController.thumbnailSize
        let aspectRatio = size.width / size.height
        let thumbnailRect = CGRect(
            x: 0,
            y: 0,
            width: DataModelController.canvasWidth,
            height: DataModelController.canvasWidth / aspectRatio
        )
        let thumbnailScale = displayScale * size.width / DataModelController.canvasWidth
        
        thumbnailQueue.async {
            let image = drawing.image(from: thumbnailRect, scale: thumbnailScale)
            DispatchQueue.main.async {
                self.notes[id]?.thumbnail = image
            }
        }
    }
    
}
