import SwiftUI

struct EventDetailView: View {
    @Bindable var event: EventModel
    @Environment(UurroosterDataStore.self) var datastore
    @State private var showingEdit = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(event.title)
                .font(.title)
            Text(event.location)
            Text("Start: \(DateUtil.formatDateTime(date: event.startDateTime))")
            Text("Einde: \(DateUtil.formatDateTime(date: event.endDateTime))")
            
            Spacer()
            
        }
        .padding()
        .toolbar {
            Button {
                showingEdit = true
            } label: {
                Label("Edit", systemImage: "ellipsis")
            }
        }
        .sheet(isPresented: $showingEdit) {
            EditEventView(event: event)
                .environment(datastore)
        }
    }
}
