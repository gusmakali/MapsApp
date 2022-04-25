//
//  ContentView.swift
//  Maps
//
//  Created by Liliia Makashova on 2022-04-13.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State var pins: [Pin] = []
    @State var showSaveModal = false
    @State var addPinViewSheet: AddPinView?
    
    var body: some View {
        VStack {
            LMMapView(pins: pins) { location in
                showSaveModal = true
                addPinViewSheet = AddPinView(location: location, onSave: { name, location in
                    pins.append(Pin(
                        location: location,
                        name: name
                    ))
                    showSaveModal = false
                })
            }
            Spacer(minLength: 30)
            NavigationLink(destination: PinList(pins: pins)){
                Text("My locations")
            }
        }.sheet(isPresented: $showSaveModal) {
            if (addPinViewSheet != nil) {
                addPinViewSheet
            }
        }
            .navigationTitle("My map")
            .padding(20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

