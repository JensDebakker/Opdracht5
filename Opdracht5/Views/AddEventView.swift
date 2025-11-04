//
//  AddEventView.swift
//  Opdracht5
//
//  Created by Jens Debakker on 04/11/2025.
//


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
            Form {
                TextField("Title", text: $title)
                TextField("Location", text: $location)
                
                Toggle("All day", isOn: $allDay)
                DatePicker("Start", selection: $startDate, displayedComponents: [.date, .hourAndMinute])
                DatePicker("End", selection: $endDate, displayedComponents: [.date, .hourAndMinute])
                
                Picker("Type", selection: $type) {
                    Text("Academic").tag(0)
                    Text("Course").tag(1)
                }.pickerStyle(.segmented)
            }
            .navigationTitle("Add Event")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
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
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}
