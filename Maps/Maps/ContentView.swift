//
//  ContentView.swift
//  Maps
//
//  Created by Liliia Makashova on 2022-04-13.
//

import SwiftUI
import MapKit
import PageSheet

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
        }.pageSheet(isPresented: $showSaveModal) {
        
            if (addPinViewSheet != nil) {
                addPinViewSheet.sheetPreference(
                    SheetPreference.detents([.medium()])
                )
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

