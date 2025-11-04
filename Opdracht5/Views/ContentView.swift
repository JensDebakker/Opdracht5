import SwiftUI

struct ContentView: View {
    @Environment(UurroosterDataStore.self) var datastore
    @State private var selectedEventID: String? = nil
    @State private var showingAddEvent = false
    @State private var loading = true
    
    
    // Compute the selected event from the datastore
    var selectedEvent: EventModel? {
        guard let id = selectedEventID else { return nil }
        return datastore.getEvent(id: id)
    }
    
    // Helper to convert event type to string
    func typeText(for event: EventModel) -> String {
        switch event.type {
        case 0: return "Academic"
        case 1: return "Course"
        default: return "Other"
        }
    }
    
    var body: some View {
        NavigationSplitView {
            // Master List
            List(datastore.uurrooster, id: \.id, selection: $selectedEventID) { event in
                VStack(alignment: .leading, spacing: 4) {
                    Text(DateUtil.formatDateTime(date: event.startDateTime)) // Main title
                        .font(.headline)
                    Text(event.title) // Secondary title
                        .font(.subheadline)
                        .bold()
                    HStack {
                        Text(event.location)
                        Text(typeText(for: event))
                    }
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
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
            // Detail pane
            if let event = selectedEvent {
                EventDetailView(event: event)
            } else {
                Text("Select an event")
                    .foregroundStyle(.secondary)
            }
        }
        .task {
            await datastore.loadData()
            loading = false
        }
    }
}
