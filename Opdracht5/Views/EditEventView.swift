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
                TextField("Title", text: $editableEvent.title).tint(.accentColor).textFieldStyle(.roundedBorder)
                TextField("Location", text: $editableEvent.location).textFieldStyle(.roundedBorder)
                
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
        .padding(40)
        .navigationTitle("Edit Event")
        
            HStack{
                Button("Update") {
                    datastore.updateEvent(event: editableEvent)
                    dismiss()
                }
                Button("Cancel") { dismiss() }
            }
        
    }
}
