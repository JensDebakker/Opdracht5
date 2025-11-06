import SwiftUI

struct AddEventView: View {
    @Environment(UurroosterDataStore.self) var datastore
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var location = ""
    @State private var allDay = false
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var type = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section(header: Text("Event Info")) {
                        TextField("Title", text: $title)
                            .textFieldStyle(.roundedBorder)
                            .tint(.accentColor)
                        
                        TextField("Location", text: $location)
                            .textFieldStyle(.roundedBorder)
                        
                        Toggle("All day", isOn: $allDay)
                        
                        Picker("Type", selection: $type) {
                            Text("Academic").tag(0)
                            Text("Other").tag(1)
                        }
                        .pickerStyle(.segmented)
                    }
                    
                    Section(header: Text("Timing")) {
                        DatePicker("Start", selection: $startDate, displayedComponents: [.date, .hourAndMinute])
                        DatePicker("End", selection: $endDate, displayedComponents: [.date, .hourAndMinute])
                    }
                }
                
                HStack{
                    Button("Save") {
                        let newEvent = EventModel()
                        newEvent.title = title
                        newEvent.location = location
                        newEvent.allDay = allDay
                        newEvent.startDateTime = startDate
                        newEvent.endDateTime = endDate
                        newEvent.type = type
                        
                        datastore.addEvent(event: newEvent)
                        dismiss()
                    }
                    
                    
                    Button("Cancel") {
                        dismiss()
                    }
                    
                }
            }
            .padding(40)
            .navigationTitle("Add Event")
        }
    }
}
