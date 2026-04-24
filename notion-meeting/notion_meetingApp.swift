//
//  notion_meetingApp.swift
//  notion-meeting
//
//  Created by Alan Jian on 4/1/26.
//

import SwiftUI

@main
struct notion_meetingApp: App {
    @StateObject private var dataModelController: DataModelController = DataModelController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataModelController)
        }
    }
}
