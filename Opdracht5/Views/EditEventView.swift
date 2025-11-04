import SwiftUI

struct EditEventView: View {
    @Environment(UurroosterDataStore.self) var datastore
    @Environment(\.dismiss) var dismiss

    @State private var editableEvent: EventModel   // local copy

    init(event: EventModel) {
        _editableEvent = State(initialValue: EventModel(from: event)) // make a copy
    }

    var body: some View {
        Form {
            Section(header: Text("Event Info")) {
                TextField("Title", text: $editableEvent.title)
                TextField("Location", text: $editableEvent.location)
                Toggle("All day", isOn: $editableEvent.allDay)
                Picker("Type", selection: $editableEvent.type) {
                    Text("Academic").tag(0)
                    Text("Other").tag(1)
                }
                .pickerStyle(.segmented)
            }

            Section(header: Text("Timing")) {
                DatePicker("Start", selection: $editableEvent.startDateTime)
                DatePicker("End", selection: $editableEvent.endDateTime)
            }
        }
        .navigationTitle("Edit Event")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    datastore.updateEvent(event: editableEvent) // write changes
                    dismiss()
                }
            }
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") { dismiss() } // discard changes
            }
        }
    }
}
