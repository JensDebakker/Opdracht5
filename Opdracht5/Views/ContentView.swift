import SwiftUI

struct ContentView: View {
    @Environment(UurroosterDataStore.self) var datastore
    @State private var selectedEventID: String? = nil
    @State private var loading = true

    var selectedEvent: EventModel? {
        guard let id = selectedEventID else { return nil }
        return datastore.getEvent(id: id)
    }

    func typeText(for event: EventModel) -> String {
        switch event.type {
        case 0: return "Academic"
        case 1: return "Course"
        default: return "Other"
        }
    }

    var body: some View {
        NavigationSplitView {
            if loading {
                VStack(spacing: 12) {
                    ProgressView()
                        .scaleEffect(1.5)
                        .tint(.red)
                    Text("Loading…")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                List(datastore.uurrooster, id: \.id, selection: $selectedEventID) { event in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(DateUtil.formatDateTime(date: event.startDateTime))
                            .font(.headline)
                        Text(event.title)
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
                    NavigationLink {
                        AddEventView()
                            .environment(datastore)
                    } label: {
                        Label("Add", systemImage: "plus")
                    }
                }
            }
        } detail: {
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

