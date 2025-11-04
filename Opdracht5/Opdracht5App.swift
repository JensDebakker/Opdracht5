//
//  Opdracht5App.swift
//  Opdracht5
//
//  Created by Jens Debakker on 04/11/2025.
//

import SwiftUI

@main
struct Opdracht5App: App {
    @State private var datastore = UurroosterDataStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environment(datastore)
        }
    }
}
