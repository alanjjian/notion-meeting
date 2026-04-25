//
//  MeetingNoteRow.swift
//  notion-meeting
//
//  Created by Alan Jian on 4/2/26.
//

import SwiftUI

struct MeetingNoteRow: View {
    let noteID: String
    @EnvironmentObject var dataModelController: DataModelController
    
    var body: some View {
        if let note = dataModelController.getNote(noteID) {
            HStack(spacing: 12) {
                // Thumbnail
                if let thumbnail = note.thumbnail {
                    Image(uiImage: thumbnail)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .cornerRadius(8)
                        .clipped()
                } else {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(.secondarySystemBackground))
                        .frame(width: 60, height: 60)
                }
                
                // Text content
                            VStack(alignment: .leading, spacing: 4) {
                                Text(note.title)
                                    .font(.headline)
                                HStack(spacing: 6) {
                                    if let project = note.projectName {
                                        Text(project)
                                            .font(.subheadline)
                                            .foregroundColor(.accentColor)
                                        Text("·")
                                            .foregroundColor(.secondary)
                                    }
                                    Text(note.date, style: .date)
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        .padding(.vertical, 4)
        }
    }
}
