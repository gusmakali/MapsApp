//
//  PinList.swift
//  Maps
//
//  Created by Liliia Makashova on 2022-04-22.
//

import SwiftUI
import MapKit

struct PinList: View {
    @Binding var pins: [Pin]
    
    var body: some View {
        List{
            ForEach(pins, id: \.id) { pin in
            NavigationLink(destination: PinCard(pin:pin)) {
                Text(pin.name)
            }
            
        }.onDelete(perform: delete)
        
    }.navigationTitle("Pins")
}
   
    func delete(at offsets: IndexSet) {
        pins.remove(atOffsets: offsets)
    }
}


struct PinList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PinList(pins: .constant([
                Pin(location: CLLocationCoordinate2DMake(0, 0), name: "Bla"),
                Pin(location: CLLocationCoordinate2DMake(0, 0), name: "Foo"),
            ]))
        }
    }
}
