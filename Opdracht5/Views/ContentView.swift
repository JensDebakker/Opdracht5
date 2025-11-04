//
//  ContentView.swift
//  Opdracht5
//
//  Created by Jens Debakker on 04/11/2025.
//

import SwiftUI

struct ContentView: View {
    @Environment(UurroosterDataStore.self) var datastore
    @State private var selectedEventID: String? = nil
    @State private var showingAddEvent = false

    var selectedEvent: EventModel? {
        datastore.uurrooster.first(where: { $0.id == selectedEventID })
    }

    var body: some View {
        NavigationSplitView {
            List(datastore.uurrooster, id: \.id, selection: $selectedEventID) { event in
                Text(event.title)
            }
            .navigationTitle("Uurrooster")
            .toolbar {
                Button {
                    showingAddEvent = true
                } label: {
                    Label("Add", systemImage: "plus")
                }
            }
            .sheet(isPresented: $showingAddEvent) {
                AddEventView()
                    .environment(datastore)
            }
        } detail: {
            if let event = selectedEvent {
                EventDetailView(event: event)
            } else {
                Text("Select event")
                    .foregroundStyle(.secondary)
            }
        }
    }
}


