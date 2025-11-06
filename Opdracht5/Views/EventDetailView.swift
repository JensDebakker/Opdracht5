import SwiftUI

struct EventDetailView: View {
    @Bindable var event: EventModel
    @Environment(UurroosterDataStore.self) var datastore
    
    var body: some View {
        VStack(alignment: .leading) {
                
                
                HStack{
                    
                    
                    Text(event.title)
                        .font(.title2.bold())
                        .foregroundColor(.white)
                        .lineLimit(3)
                        
                    
                }.frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(.tint)
                .cornerRadius(12)
                    
                    
                Divider()
                Text(event.location).font(.headline)
                
                HStack{
                    VStack{
                        Text("Start:")
                        Text("Einde:")
                    }
                    
                    Spacer()
                    
                    VStack{
                        Text("\(DateUtil.formatDateTime(date: event.startDateTime))")
                        Text("\(DateUtil.formatDateTime(date:    event.endDateTime))")
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                }
                        
                Divider()
            
           Spacer()
            
        }
        .frame(maxWidth: .infinity)
        .padding()
        .toolbar {
            NavigationLink {
                EditEventView(event: event)
                    .environment(datastore)
            } label: {
                Label("Edit", systemImage: "ellipsis")
            }
        }
    }
}
