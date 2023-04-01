//
//  swiftui_coordinator_pattern_ios16App.swift
//  swiftui-coordinator-pattern-ios16
//
//  Created by Norman Basham on 4/1/23.
//

import SwiftUI

@main
struct swiftui_coordinator_pattern_ios16App: App {
    @StateObject private var coordinator = Coordinator()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(coordinator)
        }
    }
}
