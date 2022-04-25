//
//  PinList.swift
//  Maps
//
//  Created by Liliia Makashova on 2022-04-22.
//

import SwiftUI
import MapKit

struct PinList: View {
    let pins: [Pin]
    
    var body: some View {
        List(pins, id:\.name) { pin in
            NavigationLink(destination: PinCard(pin:pin)) {
                Text(pin.name)
            }
        }
        .navigationTitle("Pins")
    }
        
}


struct PinList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PinList(pins: [
                Pin(location: CLLocationCoordinate2DMake(0, 0), name: "Bla"),
                Pin(location: CLLocationCoordinate2DMake(0, 0), name: "Foo"),
            ])
        }
    }
}
