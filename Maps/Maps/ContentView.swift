//
//  ContentView.swift
//  Maps
//
//  Created by Liliia Makashova on 2022-04-13.
//

import SwiftUI
import MapKit
import PartialSheet

struct ContentView: View {
    @State var pins: [Pin] = []
    @State var showSaveModal = false
    @State var location: CLLocationCoordinate2D?
    
    var body: some View {
        VStack {
            LMMapView(pins: pins) { location in
                self.location = location
                showSaveModal = true
            }
            Spacer(minLength: 30)
            NavigationLink(destination: PinList(pins: pins)){
                ZStack {
//                    Color.blue.frame(width: 100, height: 50)
                    
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .stroke(Color.blue, lineWidth: 1)
                        .frame(width: 115, height: 50)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    Text("My locations").foregroundColor(.blue)
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
            }
        }.partialSheet(isPresented: $showSaveModal) {
            if let location = location {
                AddPinView(location: location, onSave: { name, location in
                    pins.append(Pin(
                        location: location,
                        name: name
                    ))
                    showSaveModal = false
                }).padding(30)
            }
        
        }
            .navigationTitle("")

//            .frame(width: 100, height: 100, alignment: .center)
            .padding(20)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

